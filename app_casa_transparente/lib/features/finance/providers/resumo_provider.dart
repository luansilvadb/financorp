import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'finance_providers.dart';
import '../../cartao/providers/cartao_providers.dart';
import '../../../shared/constants.dart';

class PersonSummary {
  final double pendenteCasa;
  final double pendenteCartao;
  final double creditoCartao;
  final double totalGeral;

  PersonSummary({
    required this.pendenteCasa,
    required this.pendenteCartao,
    required this.creditoCartao,
    required this.totalGeral,
  });
}

final resumoProvider = Provider<Map<String, PersonSummary>>((ref) {
  final despesasAsync = ref.watch(despesasProvider);
  final pagamentosAsync = ref.watch(pagamentosProvider);
  final cartaoAsync = ref.watch(cartaoProvider);

  if (despesasAsync is! AsyncData ||
      pagamentosAsync is! AsyncData ||
      cartaoAsync is! AsyncData) {
    return {};
  }

  final despesas = despesasAsync.value!;
  final pagamentos = pagamentosAsync.value!;
  final cartao = cartaoAsync.value!;

  Map<String, PersonSummary> summaries = {};

  for (var p in pessoas) {
    // 1/3 of each expense
    double totalD = despesas.fold(0, (a, d) => a + (d.valor / 3));

    // Total already paid
    double pagoD = despesas
        .where((d) {
          return pagamentos.any(
            (pag) => pag.despesaId == d.id && pag.pessoa == p && pag.pago,
          );
        })
        .fold(0, (a, d) => a + (d.valor / 3));

    double pendCasa = totalD - pagoD;
    double pendCartao = 0;
    double creditoCartao = 0;

    if (p == "Luan") {
      // O Luan não deve a si mesmo no cartão
      pendCartao = 0;
      // O que as outras devem ao Luan e ainda não pagaram
      creditoCartao = cartao
          .where((c) => c.pessoa != "Luan" && !c.pago)
          .fold(0, (a, c) => a + c.valor);
    } else {
      // O que esta pessoa deve ao Luan e ainda não pagou
      pendCartao = cartao
          .where((c) => c.pessoa == p && !c.pago)
          .fold(0, (a, c) => a + c.valor);
      creditoCartao = 0;
    }

    summaries[p] = PersonSummary(
      pendenteCasa: pendCasa,
      pendenteCartao: pendCartao,
      creditoCartao: creditoCartao,
      totalGeral:
          p == "Luan" ? (pendCasa - creditoCartao) : (pendCasa + pendCartao),
    );
  }

  return summaries;
});

final totalDespesasCasaProvider = Provider<double>((ref) {
  final despesas = ref.watch(despesasProvider).value ?? [];
  return despesas.fold(0.0, (a, d) => a + d.valor);
});

final totalGeralProvider = Provider<double>((ref) {
  final despesas = ref.watch(despesasProvider).value ?? [];
  final compras = ref.watch(cartaoProvider).value ?? [];

  final totalDespesas = despesas.fold(0.0, (a, d) => a + d.valor);
  final totalCompras = compras.fold(0.0, (a, c) => a + c.valor);

  return totalDespesas + totalCompras;
});

final arrecadadoCasaProvider = Provider<double>((ref) {
  final despesas = ref.watch(despesasProvider).value ?? [];
  final pagamentos = ref.watch(pagamentosProvider).value ?? [];

  double total = 0;
  for (var d in despesas) {
    for (var p in pessoas) {
      if (pagamentos.any(
        (pag) => pag.despesaId == d.id && pag.pessoa == p && pag.pago,
      )) {
        total += (d.valor / 3);
      }
    }
  }
  return total;
});
