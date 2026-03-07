import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:divi/shared/constants.dart';
import 'package:divi/core/engine/finance_engine.dart';
import 'package:divi/shared/widgets/skeuomorphic.dart';
import 'package:divi/features/cartao/providers/cartao_providers.dart';

import 'widgets/receipt_item_card.dart';
import 'widgets/spike_modal_sheet.dart';
import '../providers/finance_providers.dart';

class StatementScreen extends ConsumerWidget {
  final String residentName;

  const StatementScreen({super.key, required this.residentName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final financeState = ref.watch(diviEngineProvider);
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'pt_BR');

    final summary = financeState.resumo[residentName];
    final totalToPay = summary?.totalGeral ?? 0.0;

    final houseExpensesData = financeState.despesas.values.toList();
    final purchases = financeState.comprasPorPessoa[residentName] ?? [];

    return Scaffold(
      backgroundColor: kPaper,
      body: CustomScrollView(
        slivers: [
          // Skeuomorphic Header
          SliverAppBar(
            expandedHeight: 180,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: PhosphorIcon(
                  PhosphorIcons.caretLeft(PhosphorIconsStyle.bold),
                  color: kInk),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(32)),
                ),
                child: Stack(
                  children: [
                    // Hole Punches
                    const Positioned(
                      top: 40,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          HolePunch(),
                          SizedBox(width: 60),
                          HolePunch(),
                        ],
                      ),
                    ),
                    // Content
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40),
                          Text(
                            residentName.toUpperCase(),
                            style: const TextStyle(
                              fontFamily: 'Space Mono',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: kInkFaded,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            formatCurrency.format(totalToPay.abs()),
                            style: TextStyle(
                              fontFamily: 'Young Serif',
                              fontSize: 36,
                              color: totalToPay > 0 ? kPrimaryColor : kPaid,
                            ),
                          ),
                          Text(
                            totalToPay > 0
                                ? "TOTAL DEVIDO"
                                : (totalToPay < 0 ? "A RECEBER" : "QUITADO"),
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              color: totalToPay > 0 ? kPrimaryColor : kPaid,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // List of Items
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 100),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                if (houseExpensesData.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.only(left: 8, bottom: 12),
                    child: Text(
                      "DESPESAS FIXAS (1/3 CADA)",
                      style: TextStyle(
                        fontFamily: 'Space Mono',
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: kInkFaded,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  ...houseExpensesData.map((item) {
                    final d = item.despesa;
                    final isPaidByResident =
                        item.pagosPorPessoa[residentName] ?? false;
                    return ReceiptItemCard(
                      title: d.nome,
                      date: "Vencimento dia ${d.diaVencimento}",
                      amount: d.valor / 3,
                      isPaid: isPaidByResident,
                      isHouseExpense: true,
                      onToggle: () {
                        if (d.id != null) {
                          ref.read(pagamentosProvider.notifier).togglePagamento(
                                d.id!,
                                residentName,
                                isPaidByResident,
                              );
                        }
                      },
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => SpikeModalSheet(despesa: d),
                        );
                      },
                      onDelete: () => _showDeleteDialog(
                        context,
                        ref,
                        title: d.nome,
                        onConfirm: () {
                          if (d.id != null) {
                            ref
                                .read(despesasProvider.notifier)
                                .deleteDespesa(d.id!);
                          }
                        },
                      ),
                    );
                  }),
                  const SizedBox(height: 24),
                ],
                if (purchases.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.only(left: 8, bottom: 12),
                    child: Text(
                      "COMPRAS NO CARTÃO",
                      style: TextStyle(
                        fontFamily: 'Space Mono',
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: kInkFaded,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  ...purchases.map((c) => ReceiptItemCard(
                        title: c.descricao,
                        date: c.data,
                        amount: c.valor,
                        isPaid: c.pago,
                        onToggle: () {
                          ref.read(cartaoProvider.notifier).togglePagamento(c);
                        },
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => SpikeModalSheet(compra: c),
                          );
                        },
                        onDelete: () => _showDeleteDialog(
                          context,
                          ref,
                          title: c.descricao,
                          onConfirm: () {
                            if (c.id != null) {
                              ref
                                  .read(cartaoProvider.notifier)
                                  .deleteCompra(c.id!);
                            }
                          },
                        ),
                      )),
                ],
                if (houseExpensesData.isEmpty && purchases.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Text(
                        "Nenhum registro este mês.",
                        style: TextStyle(
                            fontFamily: 'Space Mono', color: kInkFaded),
                      ),
                    ),
                  ),
              ]),
            ),
          ),
        ],
      ),
      floatingActionButton: totalToPay > 0
          ? FloatingActionButton.extended(
              onPressed: () {
                for (final c in purchases) {
                  if (!c.pago) {
                    ref.read(cartaoProvider.notifier).togglePagamento(c);
                  }
                }
              },
              label: const Text("QUITAR TUDO",
                  style: TextStyle(
                      fontFamily: 'Space Mono', fontWeight: FontWeight.bold)),
              backgroundColor: kInk,
              foregroundColor: kPaper,
            )
          : null,
    );
  }

  void _showDeleteDialog(
    BuildContext context,
    WidgetRef ref, {
    required String title,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: kPaper,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text(
          "EXCLUIR REGISTRO",
          style: TextStyle(
            fontFamily: 'Space Mono',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: kInk,
            letterSpacing: 1.2,
          ),
        ),
        content: Text(
          "Você tem certeza que deseja remover '$title' do livro?",
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            color: kInk.withOpacity(0.7),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "CANCELAR",
              style: TextStyle(
                fontFamily: 'Space Mono',
                fontWeight: FontWeight.bold,
                color: kInkFaded,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              onConfirm();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            child: const Text(
              "EXCLUIR",
              style: TextStyle(
                fontFamily: 'Space Mono',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
