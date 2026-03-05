import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/providers/month_year_provider.dart';
import '../../../shared/widgets/person_summary_row.dart';
import '../../../shared/constants.dart';
import '../../../shared/models/despesa.dart';

import '../../../core/utils/formatters.dart';
import '../providers/finance_providers.dart';
import '../providers/resumo_provider.dart';

import 'widgets/add_expense_sheet.dart';

class DespesasTab extends ConsumerStatefulWidget {
  const DespesasTab({super.key});

  @override
  ConsumerState<DespesasTab> createState() => _DespesasTabState();
}

class _DespesasTabState extends ConsumerState<DespesasTab> {
  String? expandedId;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final despesasAsync = ref.watch(despesasProvider);
    final period = ref.watch(periodProvider);
    final totalCasa = ref.watch(totalDespesasCasaProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const AddExpenseSheet(),
          );
        },
        backgroundColor: kPrimaryColor,
        shape: const CircleBorder(),
        elevation: 6,
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 32),
      ),
      body: despesasAsync.when(
        data: (despesas) => ListView(
          controller: _scrollController,
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 200),
          children: [
            const PersonSummaryRow(),
            const SizedBox(height: 32),
            // Expenses List Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Mês/Ano",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: kSlate900,
                      ),
                    ),
                    Text(
                      "${mesesFull[period.mes]} ${period.ano}",
                      style: const TextStyle(
                        color: kSlate500,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      fmt(totalCasa),
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: kPrimaryColor,
                      ),
                    ),
                    const Text(
                      "Total mensal",
                      style: TextStyle(
                        color: kSlate500,
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Despesas Fixas
            ...despesas.map((d) => _buildDespesaCard(d)),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text("Erro: $e")),
      ),
    );
  }

  Widget _buildDespesaCard(Despesa d) {
    final isExpanded = expandedId == d.id;
    final pagamentos = ref.watch(pagamentosProvider).value ?? [];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: isExpanded
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
        border: Border.all(color: kSlate100),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => setState(() => expandedId = isExpanded ? null : d.id),
            behavior: HitTestBehavior.opaque,
            child: Container(
              decoration: BoxDecoration(
                border: const Border(
                  left: BorderSide(
                    color: Colors.transparent,
                    width: 4,
                  ),
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: kPrimaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "VENC. DIA ${d.diaVencimento}",
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: kPrimaryColor,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          d.nome,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                            color: kSlate900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        fmt(d.valor),
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          color: kSlate900,
                        ),
                      ),
                      Text(
                        "${fmt(d.valor / 3)} por pessoa",
                        style: const TextStyle(
                          fontSize: 12,
                          color: kSlate400,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                children: [
                  Row(
                    children: pessoas.map((p) {
                      final pago = pagamentos.any(
                        (pag) =>
                            pag.despesaId == d.id &&
                            pag.pessoa == p &&
                            pag.pago,
                      );
                      final color = pago ? kGreen500 : kRed500;
                      final bgColor = pago
                          ? const Color(0xFFF0FDF4)
                          : const Color(0xFFFEF2F2);
                      final borderColor = pago
                          ? const Color(0xFFDCFCE7)
                          : const Color(0xFFFEE2E2);

                      return Expanded(
                        child: GestureDetector(
                          onTap: () => ref
                              .read(pagamentosProvider.notifier)
                              .togglePagamento(d.id!, p, pago),
                          child: Container(
                            margin: EdgeInsets.only(
                              right: p == pessoas.last ? 0 : 8,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: borderColor),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  p.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w900,
                                    color: color,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Icon(
                                  pago ? Icons.check_circle : Icons.cancel,
                                  color: color,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton.icon(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => AddExpenseSheet(expense: d),
                            );
                          },
                          icon: const Icon(Icons.edit_outlined, size: 18),
                          label: const Text(
                            "Editar",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            foregroundColor: kPrimaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                color: kPrimaryColor.withOpacity(0.1),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextButton.icon(
                          onPressed: () => ref
                              .read(despesasProvider.notifier)
                              .deleteDespesa(d.id!),
                          icon: const Icon(Icons.delete_outline, size: 18),
                          label: const Text(
                            "Excluir",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            foregroundColor: kRed500,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: const BorderSide(color: Color(0xFFFEE2E2)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

}

