import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/models/despesa.dart';
import '../../../shared/models/compra_cartao.dart';
import '../../../shared/models/pagamento.dart';
import '../../../shared/constants.dart';

import '../../../features/finance/providers/finance_providers.dart';
import '../../../features/cartao/providers/cartao_providers.dart';

/// Records densos para eliminar boilerplate de classes efêmeras (freezed).
typedef PersonSummaryRecord = ({
  double pendenteCasa,
  double pendenteCartao,
  double creditoCartao,
  double totalGeral,
});

typedef DespesaItemRecord = ({
  Despesa despesa,
  int totalPagos,
  bool allPaid,
  bool luanPago,
  double valorPorPessoa,
});

typedef CompraItemRecord = ({
  CompraCartao compra,
  bool isLuan,
});

typedef FinanceState = ({
  Map<String, PersonSummaryRecord> resumo,
  Map<String, DespesaItemRecord> despesas,
  Map<String, CompraCartao> compras, // Indexado por ID para acesso O(1)
  Map<String, List<CompraCartao>> comprasPorPessoa, // Agrupado para views
  double totalGeral,
  double arrecadadoCasa,
  double totalDespesasCasa,
});

/// O Motor Central (DiviEngine) - Processamento Single-Pass O(N).
final diviEngineProvider = Provider<FinanceState>((ref) {
  final despesasAsync = ref.watch(despesasProvider);
  final pagamentosAsync = ref.watch(pagamentosProvider);
  final comprasAsync = ref.watch(cartaoProvider);

  return switch ((despesasAsync, pagamentosAsync, comprasAsync)) {
    (
      AsyncData(value: final despesas),
      AsyncData(value: final pagamentos),
      AsyncData(value: final compras)
    ) =>
      _processData(despesas, pagamentos, compras),
    _ => (
        resumo: <String, PersonSummaryRecord>{},
        despesas: <String, DespesaItemRecord>{},
        compras: <String, CompraCartao>{},
        comprasPorPessoa: <String, List<CompraCartao>>{},
        totalGeral: 0.0,
        arrecadadoCasa: 0.0,
        totalDespesasCasa: 0.0,
      ),
  };
});

FinanceState _processData(List<Despesa> despesas, List<Pagamento> pagamentos,
    List<CompraCartao> compras) {
  // 1. Map de indexação de pagamentos para busca O(1)
  final pagMap = {
    for (final p in pagamentos) '${p.despesaId}-${p.pessoa}': p.pago
  };

  final despesasIndex = <String, DespesaItemRecord>{};
  final pendenteCasaPessoa = {for (final p in pessoas) p: 0.0};
  double totalDespesasCasa = 0.0;
  double arrecadadoFixo = 0.0;

  // 2. Processamento de Despesas Fixas O(N)
  for (final d in despesas) {
    if (d.id == null) continue;

    int totalPagos = 0;
    bool luanPago = false;
    final valorPorPessoa = d.valor / 3;

    for (final p in pessoas) {
      final isPago = pagMap['${d.id}-$p'] ?? false;
      if (isPago) {
        totalPagos++;
        if (p == 'Luan') luanPago = true;
        arrecadadoFixo += valorPorPessoa;
      } else {
        pendenteCasaPessoa[p] = (pendenteCasaPessoa[p] ?? 0.0) + valorPorPessoa;
      }
    }

    despesasIndex[d.id!] = (
      despesa: d,
      totalPagos: totalPagos,
      allPaid: totalPagos == pessoas.length,
      luanPago: luanPago,
      valorPorPessoa: valorPorPessoa,
    );
    totalDespesasCasa += d.valor;
  }

  final comprasIndex = <String, CompraCartao>{};
  final comprasPorPessoa = {for (final p in pessoas) p: <CompraCartao>[]};
  final pendenteCartaoPessoa = {for (final p in pessoas) p: 0.0};
  double creditoCartaoLuan = 0.0;
  double totalGeralCompras = 0.0;
  double arrecadadoCartao = 0.0;

  // 3. Processamento de Compras de Cartão O(N)
  for (final c in compras) {
    if (c.id == null) continue;
    comprasIndex[c.id!] = c;
    comprasPorPessoa[c.pessoa]?.add(c);
    totalGeralCompras += c.valor;

    if (!c.pago) {
      if (c.pessoa == 'Luan') {
        pendenteCartaoPessoa['Luan'] =
            (pendenteCartaoPessoa['Luan'] ?? 0.0) + c.valor;
      } else {
        pendenteCartaoPessoa[c.pessoa] =
            (pendenteCartaoPessoa[c.pessoa] ?? 0.0) + c.valor;
        creditoCartaoLuan += c.valor;
      }
    } else {
      arrecadadoCartao += c.valor;
    }
  }

  // 4. Agregação Final do Resumo
  final resumo = {
    for (final p in pessoas)
      p: (
        pendenteCasa: pendenteCasaPessoa[p] ?? 0.0,
        pendenteCartao: pendenteCartaoPessoa[p] ?? 0.0,
        creditoCartao: p == 'Luan' ? creditoCartaoLuan : 0.0,
        totalGeral: p == 'Luan'
            ? (pendenteCasaPessoa[p]! +
                pendenteCartaoPessoa[p]! -
                creditoCartaoLuan)
            : (pendenteCasaPessoa[p]! + pendenteCartaoPessoa[p]!),
      )
  };

  return (
    resumo: resumo,
    despesas: despesasIndex,
    compras: comprasIndex,
    comprasPorPessoa: comprasPorPessoa,
    totalGeral: totalDespesasCasa + totalGeralCompras,
    arrecadadoCasa: arrecadadoFixo + arrecadadoCartao,
    totalDespesasCasa: totalDespesasCasa,
  );
}
