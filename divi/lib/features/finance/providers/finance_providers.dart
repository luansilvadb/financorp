import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/finance_repository.dart';
import '../../../shared/models/despesa.dart';
import '../../../shared/models/pagamento.dart';
import '../../../core/engine/finance_engine.dart';

import '../../../shared/providers/month_year_provider.dart';

final financeRepositoryProvider = Provider((ref) => FinanceRepository());

final despesasProvider = AsyncNotifierProvider<DespesasNotifier, List<Despesa>>(
  () {
    return DespesasNotifier();
  },
);

class DespesasNotifier extends AsyncNotifier<List<Despesa>> {
  @override
  Future<List<Despesa>> build() async {
    return ref.read(financeRepositoryProvider).getDespesas();
  }

  Future<void> addDespesa(Despesa d) async {
    final previousState = state;
    // Optimistic: add with a placeholder (no id yet)
    state = state.whenData((list) => [...list, d]);
    try {
      await ref.read(financeRepositoryProvider).saveDespesa(d);
      // After server success, re-fetch to get the server-generated ID
      ref.invalidateSelf();
    } catch (e) {
      state = previousState;
      rethrow;
    }
  }

  Future<void> updateDespesa(Despesa d) async {
    final previousState = state;
    state = state.whenData(
        (list) => list.map((item) => item.id == d.id ? d : item).toList());
    try {
      await ref.read(financeRepositoryProvider).saveDespesa(d);
    } catch (e) {
      state = previousState;
      rethrow;
    }
  }

  Future<void> deleteDespesa(String id) async {
    final previousState = state;
    state =
        state.whenData((list) => list.where((item) => item.id != id).toList());
    try {
      await ref.read(financeRepositoryProvider).deleteDespesa(id);
    } catch (e) {
      state = previousState;
      rethrow;
    }
  }
}

final pagamentosProvider =
    AsyncNotifierProvider<PagamentosNotifier, List<Pagamento>>(() {
  return PagamentosNotifier();
});

class PagamentosNotifier extends AsyncNotifier<List<Pagamento>> {
  @override
  Future<List<Pagamento>> build() async {
    ref.keepAlive();
    final period = ref.watch(periodProvider);
    return ref
        .read(financeRepositoryProvider)
        .getPagamentos(period.mes, period.ano);
  }

  Future<void> togglePagamento(
    String despesaId,
    String pessoa,
    bool currentStatus,
  ) async {
    final period = ref.read(periodProvider);
    final repo = ref.read(financeRepositoryProvider);

    final id = '$despesaId-$pessoa-${period.mes}-${period.ano}';

    final novoPagamento = Pagamento(
      id: id,
      despesaId: despesaId,
      pessoa: pessoa,
      mes: period.mes,
      ano: period.ano,
      pago: !currentStatus,
    );

    // Optimistic: update or insert locally
    final previousState = state;
    state = state.whenData((list) {
      final idx = list.indexWhere((p) => p.id == id);
      if (idx >= 0) {
        final updated = List<Pagamento>.from(list);
        updated[idx] = novoPagamento;
        return updated;
      } else {
        return [...list, novoPagamento];
      }
    });

    try {
      await repo.upsertPagamento(novoPagamento);
    } catch (e) {
      state = previousState;
      rethrow;
    }
  }
}

/// Provider granular que utiliza o motor central (O(1) access).
/// Isso isola a reconstrução do widget do card apenas para mudanças relevantes a este ID.
final despesaItemProvider =
    Provider.family<DespesaItemRecord?, String>((ref, id) {
  return ref.watch(diviEngineProvider.select((s) => s.despesas[id]));
});
