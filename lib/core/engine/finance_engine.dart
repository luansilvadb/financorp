import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/app_providers.dart';
import '../../shared/models/domain.dart';
import '../../shared/constants.dart';

typedef PersonSummaryRecord = ({
  double pendenteCasa,
  double pendenteCartao,
  double creditoCartao,
  double totalGeral,
  double valorPagoReal, // Total efetivamente pago por esta pessoa
  double saldoAcerto, // S = CI - VP
});

typedef DespesaItemRecord = ({
  Despesa despesa,
  int totalPagos,
  bool allPaid,
  bool luanPago,
  double valorPorPessoa,
  Map<String, bool> pagosPorPessoa,
  Map<String, double> valoresPagosPorPessoa,
});

typedef CompraItemRecord = ({
  CompraCartao compra,
  bool isLuan,
});

typedef SettlementTransfer = ({
  String de,
  String para,
  double valor,
});

typedef FinanceState = ({
  Map<String, PersonSummaryRecord> resumo,
  Map<String, DespesaItemRecord> despesas,
  Map<String, CompraCartao> compras,
  Map<String, List<CompraCartao>> comprasPorPessoa,
  double totalGeral,
  double arrecadadoCasa,
  double totalDespesasCasa,
  double custoIndividualAlvo, // CT / N
  List<SettlementTransfer> transferencias,
});

final diviEngineProvider = Provider<FinanceState>((ref) {
  final despesas = ref.watch(despesasProvider).value;
  final pagamentos = ref.watch(pagamentosProvider).value;
  final compras = ref.watch(cartaoProvider).value;

  if (despesas != null && pagamentos != null && compras != null) {
    return _processData(despesas, pagamentos, compras);
  }

  return (
    resumo: const <String, PersonSummaryRecord>{},
    despesas: const <String, DespesaItemRecord>{},
    compras: const <String, CompraCartao>{},
    comprasPorPessoa: const <String, List<CompraCartao>>{},
    totalGeral: 0.0,
    arrecadadoCasa: 0.0,
    totalDespesasCasa: 0.0,
    custoIndividualAlvo: 0.0,
    transferencias: const [],
  );
});

FinanceState _processData(List<Despesa> despesas, List<Pagamento> pagamentos, List<CompraCartao> compras) {
  final pagMap = <String, Map<String, bool>>{};
  final valMap = <String, Map<String, double>>{};
  for (final p in pagamentos) {
    (pagMap[p.despesaId] ??= {})[p.pessoa] = p.pago;
    (valMap[p.despesaId] ??= {})[p.pessoa] = p.valorPago;
  }

  final pendenteCasa = {for (final p in pessoas) p: 0.0};
  final valorPagoReal = {for (final p in pessoas) p: 0.0};
  double totalDespesasBilled = 0.0;

  final despesasIndex = {for (final d in despesas) if (d.id != null) d.id!: () {
    int totalPagos = 0;
    bool luanPago = false;
    final valorPorPessoa = d.valor / pessoas.length;
    final pagosPorPessoa = {for (final p in pessoas) p: false};
    final valoresPagosPorPessoa = {for (final p in pessoas) p: 0.0};

    for (final p in pessoas) {
      if (pagosPorPessoa[p] = pagMap[d.id]?[p] ?? false) {
        totalPagos++;
        if (p == 'Luan') luanPago = true;

        // Compatibilidade com registros legados (onde valorPago é 0)
        final vp = valMap[d.id]?[p] ?? 0.0;
        final realVp = vp > 0 ? vp : valorPorPessoa;

        valoresPagosPorPessoa[p] = realVp;
        valorPagoReal[p] = (valorPagoReal[p] ?? 0.0) + realVp;
      } else {
        pendenteCasa[p] = (pendenteCasa[p] ?? 0.0) + valorPorPessoa;
      }
    }
    totalDespesasBilled += d.valor;

    return (
      despesa: d,
      totalPagos: totalPagos,
      allPaid: totalPagos == pessoas.length,
      luanPago: luanPago,
      valorPorPessoa: valorPorPessoa,
      pagosPorPessoa: pagosPorPessoa,
      valoresPagosPorPessoa: valoresPagosPorPessoa,
    );
  }()};

  final comprasPorPessoa = {for (final p in pessoas) p: <CompraCartao>[]};
  final pendenteCartao = {for (final p in pessoas) p: 0.0};
  double creditoLuan = 0.0, totalGeralComprasBilled = 0.0;

  final comprasIndex = {for (final c in compras) if (c.id != null) c.id!: () {
    comprasPorPessoa[c.pessoa]?.add(c);
    totalGeralComprasBilled += c.valor;

    // Atribuição de contribuição (VP) para compras no cartão:
    // Luan é o pagador primário (banco). Se a pessoa já pagou o Luan, ela assume o VP.
    if (c.pago) {
      valorPagoReal[c.pessoa] = (valorPagoReal[c.pessoa] ?? 0.0) + c.valor;
    } else {
      valorPagoReal['Luan'] = (valorPagoReal['Luan'] ?? 0.0) + c.valor;
      pendenteCartao[c.pessoa] = (pendenteCartao[c.pessoa] ?? 0.0) + c.valor;
      if (c.pessoa != 'Luan') creditoLuan += c.valor;
    }
    return c;
  }()};

  // Custo Total (CT) = Somatório de todos os aportes individuais (VP)
  final totalGeralReal = valorPagoReal.values.fold(0.0, (sum, v) => sum + v);
  final custoIndividualAlvo = totalGeralReal / pessoas.length;

  final resumo = {for (final p in pessoas) p: (
    pendenteCasa: pendenteCasa[p] ?? 0.0,
    pendenteCartao: pendenteCartao[p] ?? 0.0,
    creditoCartao: p == 'Luan' ? creditoLuan : 0.0,
    totalGeral: (pendenteCasa[p]! + pendenteCartao[p]!),
    valorPagoReal: valorPagoReal[p] ?? 0.0,
    saldoAcerto: custoIndividualAlvo - (valorPagoReal[p] ?? 0.0),
  )};

  // Cálculo de transferências para o acerto
  final transferencias = <SettlementTransfer>[];
  final devedores = resumo.entries
      .where((e) => e.value.saldoAcerto > 0.01)
      .map((e) => (pessoa: e.key, saldo: e.value.saldoAcerto))
      .toList();
  final credores = resumo.entries
      .where((e) => e.value.saldoAcerto < -0.01)
      .map((e) => (pessoa: e.key, saldo: e.value.saldoAcerto.abs()))
      .toList();

  int i = 0, j = 0;
  while (i < devedores.length && j < credores.length) {
    final dev = devedores[i];
    final cre = credores[j];
    final valor = dev.saldo < cre.saldo ? dev.saldo : cre.saldo;

    if (valor > 0.01) {
      transferencias.add((de: dev.pessoa, para: cre.pessoa, valor: valor));
    }

    devedores[i] = (pessoa: dev.pessoa, saldo: dev.saldo - valor);
    credores[j] = (pessoa: cre.pessoa, saldo: cre.saldo - valor);

    if (devedores[i].saldo < 0.01) i++;
    if (credores[j].saldo < 0.01) j++;
  }

  return (
    resumo: resumo,
    despesas: despesasIndex,
    compras: comprasIndex,
    comprasPorPessoa: comprasPorPessoa,
    totalGeral: totalGeralReal,
    arrecadadoCasa: totalGeralReal,
    totalDespesasCasa: totalDespesasBilled,
    custoIndividualAlvo: custoIndividualAlvo,
    transferencias: transferencias,
  );
}

final despesaItemProvider = Provider.family<DespesaItemRecord?, String>((ref, id) {
  return ref.watch(diviEngineProvider.select((s) => s.despesas[id]));
});

final compraItemProvider = Provider.family<CompraItemRecord?, String>((ref, id) {
  final compra = ref.watch(diviEngineProvider.select((s) => s.compras[id]));
  return compra != null ? (compra: compra, isLuan: compra.pessoa == 'Luan') : null;
});
