import '../../../../core/providers/app_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/constants.dart';
import '../../../../shared/models/domain.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../shared/widgets/divi_avatar.dart';

import 'add_purchase_sheet.dart';

class CartaoDetailsSheet extends ConsumerWidget {
  final CompraCartao compra;

  const CartaoDetailsSheet({super.key, required this.compra});

  void _confirmDelete(BuildContext context, WidgetRef ref) {
    showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: kPaper,
        title: const Text("Tem certeza?"),
        content: const Text("Esta ação não pode ser desfeita."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text("Cancelar"),
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
        ref.read(cartaoProvider.notifier).deleteCompra(compra.id!);
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

          // Header: Avatar + Title + Value
          Row(
            children: [
              DiviAvatar(pessoa: compra.pessoa, size: 44),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      compra.descricao,
                      style: const TextStyle(
                        fontFamily: 'Young Serif',
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: kTextPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "${compra.pessoa} • ${compra.data}",
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        color: kTextSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                fmt(compra.valor),
                style: const TextStyle(
                  fontFamily: 'Young Serif',
                  fontWeight: FontWeight.w400,
                  fontSize: 22,
                  color: kTextPrimary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Payment Status Toggle (large button)
          GestureDetector(
            onTap: () {
              ref.read(cartaoProvider.notifier).togglePagamento(compra);
              Navigator.pop(context);
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: compra.pago ? kPaperDepth.withValues(alpha: 0.5) : kSemanticPaid.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: compra.pago ? kPaperDepth : kSemanticPaid.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    compra.pago ? Icons.undo : Icons.check_circle_outline,
                    color: compra.pago ? kTextSecondary : kSemanticPaid,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    compra.pago ? "Marcar Pendente" : "Marcar como Pago",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: compra.pago ? kTextSecondary : kSemanticPaid,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Edit & Delete Buttons
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
                      builder: (context) => AddPurchaseSheet(purchase: compra),
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
