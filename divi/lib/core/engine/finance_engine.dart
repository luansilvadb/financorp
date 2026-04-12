import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/app_providers.dart';
import '../../shared/models/domain.dart';
import '../../shared/constants.dart';

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
  Map<String, bool> pagosPorPessoa,
});

typedef CompraItemRecord = ({
  CompraCartao compra,
  bool isLuan,
});

typedef FinanceState = ({
  Map<String, PersonSummaryRecord> resumo,
  Map<String, DespesaItemRecord> despesas,
  Map<String, CompraCartao> compras,
  Map<String, List<CompraCartao>> comprasPorPessoa,
  double totalGeral,
  double arrecadadoCasa,
  double totalDespesasCasa,
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
  );
});

FinanceState _processData(List<Despesa> despesas, List<Pagamento> pagamentos, List<CompraCartao> compras) {
  final pagMap = <String, Map<String, bool>>{};
  for (final p in pagamentos) {
    (pagMap[p.despesaId] ??= {})[p.pessoa] = p.pago;
  }

  final pendenteCasa = {for (final p in pessoas) p: 0.0};
  double totalDespesasCasa = 0.0, arrecadadoFixo = 0.0;

  final despesasIndex = {for (final d in despesas) if (d.id != null) d.id!: () {
    int totalPagos = 0;
    bool luanPago = false;
    final valorPorPessoa = d.valor / 3;
    final pagosPorPessoa = {for (final p in pessoas) p: false};

    for (final p in pessoas) {
      if (pagosPorPessoa[p] = pagMap[d.id]?[p] ?? false) {
        totalPagos++;
        if (p == 'Luan') luanPago = true;
        arrecadadoFixo += valorPorPessoa;
      } else {
        pendenteCasa[p] = (pendenteCasa[p] ?? 0.0) + valorPorPessoa;
      }
    }
    totalDespesasCasa += d.valor;

    return (
      despesa: d,
      totalPagos: totalPagos,
      allPaid: totalPagos == pessoas.length,
      luanPago: luanPago,
      valorPorPessoa: valorPorPessoa,
      pagosPorPessoa: pagosPorPessoa,
    );
  }()};

  final comprasPorPessoa = {for (final p in pessoas) p: <CompraCartao>[]};
  final pendenteCartao = {for (final p in pessoas) p: 0.0};
  double creditoLuan = 0.0, totalGeralCompras = 0.0, arrecadadoCartao = 0.0;

  final comprasIndex = {for (final c in compras) if (c.id != null) c.id!: () {
    comprasPorPessoa[c.pessoa]?.add(c);
    totalGeralCompras += c.valor;

    if (!c.pago) {
      pendenteCartao[c.pessoa] = (pendenteCartao[c.pessoa] ?? 0.0) + c.valor;
      if (c.pessoa != 'Luan') creditoLuan += c.valor;
    } else {
      arrecadadoCartao += c.valor;
    }
    return c;
  }()};

  final resumo = {for (final p in pessoas) p: (
    pendenteCasa: pendenteCasa[p] ?? 0.0,
    pendenteCartao: pendenteCartao[p] ?? 0.0,
    creditoCartao: p == 'Luan' ? creditoLuan : 0.0,
    totalGeral: (pendenteCasa[p]! + pendenteCartao[p]!),
  )};

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

final despesaItemProvider = Provider.family<DespesaItemRecord?, String>((ref, id) {
  return ref.watch(diviEngineProvider.select((s) => s.despesas[id]));
});

final compraItemProvider = Provider.family<CompraItemRecord?, String>((ref, id) {
  final compra = ref.watch(diviEngineProvider.select((s) => s.compras[id]));
  return compra != null ? (compra: compra, isLuan: compra.pessoa == 'Luan') : null;
});
