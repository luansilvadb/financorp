import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repository.dart';
import '../../shared/models/domain.dart';
import '../../shared/providers/month_year_provider.dart';

final appRepositoryProvider = Provider((ref) => AppRepository());

abstract class OptimisticNotifier<T> extends AsyncNotifier<List<T>> {
  AppRepository get repo => ref.read(appRepositoryProvider);

  Future<void> optimisticUpdate(T updatedItem, bool Function(T item) isSameId, Future<void> Function() repoCall) async {
    final prev = state;
    state = state.whenData((list) {
      final idx = list.indexWhere(isSameId);
      if (idx >= 0) {
        final newList = List<T>.from(list);
        newList[idx] = updatedItem;
        return newList;
      }
      return [...list, updatedItem];
    });
    try { await repoCall(); } catch (_) { state = prev; rethrow; }
  }

  Future<void> optimisticAdd(T newItem, Future<void> Function() repoCall) async {
    final prev = state;
    state = state.whenData((list) => [...list, newItem]);
    try { await repoCall(); ref.invalidateSelf(); } catch (_) { state = prev; rethrow; }
  }

  Future<void> optimisticDelete(String id, bool Function(T item) isSameId, Future<void> Function() repoCall) async {
    final prev = state;
    state = state.whenData((list) => list.where((item) => !isSameId(item)).toList());
    try { await repoCall(); } catch (_) { state = prev; rethrow; }
  }
}

final despesasProvider = AsyncNotifierProvider<DespesasNotifier, List<Despesa>>(DespesasNotifier.new);

class DespesasNotifier extends OptimisticNotifier<Despesa> {
  @override Future<List<Despesa>> build() => repo.getDespesas();
  Future<void> addDespesa(Despesa d) => optimisticAdd(d, () => repo.saveDespesa(d));
  Future<void> updateDespesa(Despesa d) => optimisticUpdate(d, (i) => i.id == d.id, () => repo.saveDespesa(d));
  Future<void> deleteDespesa(String id) => optimisticDelete(id, (i) => i.id == id, () => repo.deleteDespesa(id));
}

final pagamentosProvider = AsyncNotifierProvider<PagamentosNotifier, List<Pagamento>>(PagamentosNotifier.new);

class PagamentosNotifier extends OptimisticNotifier<Pagamento> {
  @override Future<List<Pagamento>> build() {
    ref.keepAlive();
    final p = ref.watch(periodProvider);
    return repo.getPagamentos(p.mes, p.ano);
  }

  Future<void> togglePagamento(String despesaId, String pessoa, bool currentStatus) async {
    final p = ref.read(periodProvider);
    final id = '$despesaId-$pessoa-${p.mes}-${p.ano}';
    final n = Pagamento(id: id, despesaId: despesaId, pessoa: pessoa, mes: p.mes, ano: p.ano, pago: !currentStatus);
    return optimisticUpdate(n, (i) => i.id == id, () => repo.upsertPagamento(n));
  }

  Future<void> markAllAsPaid(String pessoa, int mes, int ano, List<String> despesasIds) async {
    final prev = state;
    final novos = despesasIds.map((dId) => Pagamento(id: '$dId-$pessoa-$mes-$ano', despesaId: dId, pessoa: pessoa, mes: mes, ano: ano, pago: true)).toList();
    state = state.whenData((list) {
      final updated = List<Pagamento>.from(list);
      for (final n in novos) {
        final idx = updated.indexWhere((p) => p.id == n.id);
        if (idx >= 0) {
          updated[idx] = n;
        } else {
          updated.add(n);
        }
      }
      return updated;
    });
    try { await repo.upsertPagamentos(novos); } catch (_) { state = prev; rethrow; }
  }
}

final cartaoProvider = AsyncNotifierProvider<CartaoNotifier, List<CompraCartao>>(CartaoNotifier.new);

class CartaoNotifier extends OptimisticNotifier<CompraCartao> {
  @override Future<List<CompraCartao>> build() {
    ref.keepAlive();
    final p = ref.watch(periodProvider);
    return repo.getCompras(p.mes, p.ano);
  }

  Future<void> addCompra(CompraCartao c) => optimisticAdd(c, () => repo.saveCompra(c));
  Future<void> updateCompra(CompraCartao c) => optimisticUpdate(c, (i) => i.id == c.id, () => repo.saveCompra(c));
  Future<void> deleteCompra(String id) => optimisticDelete(id, (i) => i.id == id, () => repo.deleteCompra(id));
  Future<void> togglePagamento(CompraCartao c) {
    final u = c.copyWith(pago: !c.pago);
    return optimisticUpdate(u, (i) => i.id == u.id, () => repo.saveCompra(u));
  }

  Future<void> markAllAsPaid(String pessoa, int mes, int ano) async {
    final prev = state;
    final list = state.value ?? [];
    final toUpdate = list.where((c) => c.pessoa == pessoa && c.mes == mes && c.ano == ano && !c.pago).map((c) => c.copyWith(pago: true)).toList();
    if (toUpdate.isEmpty) return;

    state = state.whenData((l) {
      final map = {for (var c in toUpdate) c.id: c};
      return l.map((c) => map[c.id] ?? c).toList();
    });
    try { await repo.saveCompras(toUpdate); } catch (_) { state = prev; rethrow; }
  }
}
