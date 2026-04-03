import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repository.dart';
import '../../shared/models/domain.dart';
import '../../shared/providers/month_year_provider.dart';

final appRepositoryProvider = Provider((ref) => AppRepository());

// Helper abstract class to reduce boilerplate in optimistic updates
abstract class OptimisticNotifier<T> extends AsyncNotifier<List<T>> {
  AppRepository get repo => ref.read(appRepositoryProvider);

  Future<void> optimisticUpdate(
      T updatedItem, bool Function(T item) isSameId, Future<void> Function() repoCall) async {
    final previousState = state;
    state = state.whenData((list) {
      final idx = list.indexWhere(isSameId);
      if (idx >= 0) {
        final newList = List<T>.from(list);
        newList[idx] = updatedItem;
        return newList;
      }
      return [...list, updatedItem];
    });
    try {
      await repoCall();
    } catch (e) {
      state = previousState;
      rethrow;
    }
  }

  Future<void> optimisticAdd(T newItem, Future<void> Function() repoCall) async {
    final previousState = state;
    state = state.whenData((list) => [...list, newItem]);
    try {
      await repoCall();
      ref.invalidateSelf(); // Refresh to get DB ID if needed
    } catch (e) {
      state = previousState;
      rethrow;
    }
  }

  Future<void> optimisticDelete(String id, bool Function(T item) isSameId, Future<void> Function() repoCall) async {
    final previousState = state;
    state = state.whenData((list) => list.where((item) => !isSameId(item)).toList());
    try {
      await repoCall();
    } catch (e) {
      state = previousState;
      rethrow;
    }
  }
}

final despesasProvider = AsyncNotifierProvider<DespesasNotifier, List<Despesa>>(() {
  return DespesasNotifier();
});

class DespesasNotifier extends OptimisticNotifier<Despesa> {
  @override
  Future<List<Despesa>> build() async {
    return repo.getDespesas();
  }

  Future<void> addDespesa(Despesa d) => optimisticAdd(d, () => repo.saveDespesa(d));

  Future<void> updateDespesa(Despesa d) =>
      optimisticUpdate(d, (item) => item.id == d.id, () => repo.saveDespesa(d));

  Future<void> deleteDespesa(String id) =>
      optimisticDelete(id, (item) => item.id == id, () => repo.deleteDespesa(id));
}

final pagamentosProvider = AsyncNotifierProvider<PagamentosNotifier, List<Pagamento>>(() {
  return PagamentosNotifier();
});

class PagamentosNotifier extends OptimisticNotifier<Pagamento> {
  @override
  Future<List<Pagamento>> build() async {
    ref.keepAlive();
    final period = ref.watch(periodProvider);
    return repo.getPagamentos(period.mes, period.ano);
  }

  Future<void> togglePagamento(String despesaId, String pessoa, bool currentStatus) async {
    final period = ref.read(periodProvider);
    final id = '$despesaId-$pessoa-${period.mes}-${period.ano}';
    final novoPagamento = Pagamento(
      id: id,
      despesaId: despesaId,
      pessoa: pessoa,
      mes: period.mes,
      ano: period.ano,
      pago: !currentStatus,
    );

    await optimisticUpdate(novoPagamento, (item) => item.id == id, () => repo.upsertPagamento(novoPagamento));
  }

  Future<void> markAllAsPaid(String pessoa, int mes, int ano, List<String> despesasIds) async {
    final previousState = state;
    final novosPagamentos = despesasIds.map((dId) {
      final id = '$dId-$pessoa-$mes-$ano';
      return Pagamento(id: id, despesaId: dId, pessoa: pessoa, mes: mes, ano: ano, pago: true);
    }).toList();

    state = state.whenData((list) {
      final updatedList = List<Pagamento>.from(list);
      for (final np in novosPagamentos) {
        final idx = updatedList.indexWhere((p) => p.id == np.id);
        if (idx >= 0) {
          updatedList[idx] = np;
        } else {
          updatedList.add(np);
        }
      }
      return updatedList;
    });

    try {
      await repo.upsertPagamentos(novosPagamentos);
    } catch (e) {
      state = previousState;
      rethrow;
    }
  }
}

final cartaoProvider = AsyncNotifierProvider<CartaoNotifier, List<CompraCartao>>(() {
  return CartaoNotifier();
});

class CartaoNotifier extends OptimisticNotifier<CompraCartao> {
  @override
  Future<List<CompraCartao>> build() async {
    ref.keepAlive();
    final period = ref.watch(periodProvider);
    return repo.getCompras(period.mes, period.ano);
  }

  Future<void> addCompra(CompraCartao c) => optimisticAdd(c, () => repo.saveCompra(c));

  Future<void> updateCompra(CompraCartao c) =>
      optimisticUpdate(c, (item) => item.id == c.id, () => repo.saveCompra(c));

  Future<void> deleteCompra(String id) =>
      optimisticDelete(id, (item) => item.id == id, () => repo.deleteCompra(id));

  Future<void> togglePagamento(CompraCartao c) {
    final updated = c.copyWith(pago: !c.pago);
    return optimisticUpdate(updated, (item) => item.id == updated.id, () => repo.saveCompra(updated));
  }

  Future<void> markAllAsPaid(String pessoa, int mes, int ano) async {
    final previousState = state;
    final currentList = state.value ?? [];

    final toUpdate = currentList
        .where((c) => c.pessoa == pessoa && c.mes == mes && c.ano == ano && !c.pago)
        .map((c) => c.copyWith(pago: true))
        .toList();

    if (toUpdate.isEmpty) return;

    state = state.whenData((list) {
      final updatedMap = {for (var c in toUpdate) c.id: c};
      return list.map((c) => updatedMap.containsKey(c.id) ? updatedMap[c.id]! : c).toList();
    });

    try {
      await repo.saveCompras(toUpdate);
    } catch (e) {
      state = previousState;
      rethrow;
    }
  }
}
