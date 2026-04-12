import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/constants.dart';
import '../../../../shared/models/domain.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/providers/app_providers.dart';
import '../../../../shared/widgets/stamp_animation.dart';

import 'add_expense_sheet.dart';

class DespesaDetailsSheet extends ConsumerWidget {
  final Despesa despesa;

  const DespesaDetailsSheet({super.key, required this.despesa});

  void _confirmDelete(BuildContext context, WidgetRef ref) {
    showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: kSurfacePaper,
        title: const Text(
          "Tem certeza?",
          style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, color: kTextPrimary),
        ),
        content: const Text(
          "Esta ação não pode ser desfeita.",
          style: TextStyle(fontFamily: 'Inter', color: kTextSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text("Cancelar", style: TextStyle(color: kTextPrimary)),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(backgroundColor: kSemanticOverdue),
            child: const Text("Sim, excluir"),
          ),
        ],
      ),
    ).then((confirmed) {
      if (confirmed == true && context.mounted) {
        ref.read(despesasProvider.notifier).deleteDespesa(despesa.id!);
        Navigator.pop(context);
      }
    });
  }

  Future<void> _togglePagamento(
    BuildContext context,
    WidgetRef ref,
    String pessoa,
    bool currentStatus,
  ) async {
    // Show stamp animation
    await StampAnimation.show(context, isPaid: !currentStatus);

    // Toggle the payment
    ref
        .read(pagamentosProvider.notifier)
        .togglePagamento(despesa.id!, pessoa, currentStatus);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pagamentos = ref.watch(pagamentosProvider).value ?? [];

    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 12, bottom: 32),
      decoration: const BoxDecoration(
        color: kSurfacePaper,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              color: kPaperDepth,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header: Icon + Title
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: kPrimaryOlive.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.receipt, color: kPrimaryOlive, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      despesa.nome,
                      style: const TextStyle(
                        fontFamily: 'Young Serif',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: kTextPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: kPrimaryOlive.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        "VENC. DIA ${despesa.diaVencimento}",
                        style: const TextStyle(
                          fontFamily: 'Space Mono',
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryOlive,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    fmt(despesa.valor),
                    style: const TextStyle(
                      fontFamily: 'Young Serif',
                      fontWeight: FontWeight.w400,
                      fontSize: 22,
                      color: kTextPrimary,
                    ),
                  ),
                  Text(
                    "${fmt(despesa.valor / 3)} /pessoa",
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      color: kTextSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Payment Status per Person
          Row(
            children: pessoas.map((p) {
              final pago = pagamentos.any(
                (pag) =>
                    pag.despesaId == despesa.id && pag.pessoa == p && pag.pago,
              );
              final color = pago ? kSemanticPaid : kSemanticPending;
              final bgColor = pago
                  ? kSemanticPaid.withValues(alpha: 0.08)
                  : kSemanticPending.withValues(alpha: 0.08);
              final borderColor = pago
                  ? kSemanticPaid.withValues(alpha: 0.2)
                  : kSemanticPending.withValues(alpha: 0.2);

              return Expanded(
                child: GestureDetector(
                  onTap: () => _togglePagamento(context, ref, p, pago),
                  child: Container(
                    margin: EdgeInsets.only(right: p == pessoas.last ? 0 : 8),
                    padding: const EdgeInsets.symmetric(vertical: 14),
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
                          pago ? Icons.check_circle : Icons.autorenew,
                          color: color,
                          size: 22,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 28),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => AddExpenseSheet(expense: despesa),
                    );
                  },
                  icon: const Icon(Icons.edit_outlined, size: 20),
                  label: const Text(
                    "Editar",
                    style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _confirmDelete(context, ref),
                  icon: const Icon(Icons.delete_outline, size: 20),
                  label: const Text(
                    "Excluir",
                    style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: kSemanticOverdue,
                    side: const BorderSide(color: kSemanticOverdue, width: 1.5),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
