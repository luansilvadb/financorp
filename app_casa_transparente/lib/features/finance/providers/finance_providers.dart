import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/finance_repository.dart';
import '../../../shared/models/despesa.dart';
import '../../../shared/models/pagamento.dart';
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
    await ref.read(financeRepositoryProvider).saveDespesa(d);
    ref.invalidateSelf();
  }

  Future<void> deleteDespesa(String id) async {
    await ref.read(financeRepositoryProvider).deleteDespesa(id);
    ref.invalidateSelf();
  }
}

final pagamentosProvider =
    AsyncNotifierProvider<PagamentosNotifier, List<Pagamento>>(() {
      return PagamentosNotifier();
    });

class PagamentosNotifier extends AsyncNotifier<List<Pagamento>> {
  @override
  Future<List<Pagamento>> build() async {
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

    // Simple ID for payment relation: despesaId-pessoa-mes-ano
    final id = '$despesaId-$pessoa-${period.mes}-${period.ano}';

    final novoPagamento = Pagamento(
      id: id,
      despesaId: despesaId,
      pessoa: pessoa,
      mes: period.mes,
      ano: period.ano,
      pago: !currentStatus,
    );

    await repo.upsertPagamento(novoPagamento);
    ref.invalidateSelf();
  }
}
