import '../../../../core/engine/finance_engine.dart';
import '../../../../core/providers/app_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/constants.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../shared/widgets/divi_avatar.dart';

import '../../../../shared/models/domain.dart';
import '../../../../shared/widgets/stamp_animation.dart';
import 'cartao_details_sheet.dart';

class CartaoCard extends ConsumerStatefulWidget {
  final String compraId;

  const CartaoCard({super.key, required this.compraId});

  @override
  ConsumerState<CartaoCard> createState() => _CartaoCardState();
}

class _CartaoCardState extends ConsumerState<CartaoCard> {
  Future<void> _handleSwipeRight() async {
    final itemState = ref.read(compraItemProvider(widget.compraId));
    if (itemState == null) return;
    final compra = itemState.compra;

    // Show stamp animation
    await StampAnimation.show(context, isPaid: !compra.pago);

    // Toggle payment
    if (mounted) {
      ref.read(cartaoProvider.notifier).togglePagamento(compra);
    }
  }

  @override
  Widget build(BuildContext context) {
    final itemState = ref.watch(compraItemProvider(widget.compraId));

    if (itemState == null) return const SizedBox.shrink();

    final compra = itemState.compra;

    return Dismissible(
      key: Key('compra-${widget.compraId}'),
      direction: DismissDirection.horizontal,
      dismissThresholds: const {
        DismissDirection.startToEnd: 0.4,
        DismissDirection.endToStart: 0.4,
      },
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          // Swipe Right: Toggle Pago with animation
          await _handleSwipeRight();
          return false; // Snap back
        } else {
          // Swipe Left: Excluir (Confirm)
          HapticFeedback.vibrate();
          final confirm = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: kSurfacePaper,
              title: const Text(
                "Excluir compra?",
                style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, color: kTextPrimary),
              ),
              content: const Text(
                "Esta ação não pode ser desfeita.",
                style: TextStyle(fontFamily: 'Inter', color: kTextSecondary),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text("CANCELAR", style: TextStyle(color: kTextPrimary)),
                ),
                FilledButton(
                  onPressed: () => Navigator.pop(context, true),
                  style: FilledButton.styleFrom(
                    backgroundColor: kSemanticOverdue,
                  ),
                  child: const Text("EXCLUIR"),
                ),
              ],
            ),
          );
          if (confirm == true) {
            ref.read(cartaoProvider.notifier).deleteCompra(widget.compraId);
            return true;
          }
          return false;
        }
      },
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: kSemanticPaid.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.only(left: 24),
        alignment: Alignment.centerLeft,
        child: const Icon(Icons.check_circle, color: kSemanticPaid, size: 32),
      ),
      secondaryBackground: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: kSemanticOverdue.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.only(right: 24),
        alignment: Alignment.centerRight,
        child: const Icon(Icons.delete, color: kSemanticOverdue, size: 32),
      ),
      child: _buildCardContent(compra),
    );
  }

  Widget _buildCardContent(CompraCartao compra) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: compra.pago
            ? kSemanticPaid.withValues(alpha: 0.08)
            : kSemanticPending.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: compra.pago
              ? kSemanticPaid.withValues(alpha: 0.2)
              : kSemanticPending.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Main body (tap -> details sheet)
          Expanded(
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => CartaoDetailsSheet(compra: compra),
                );
              },
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                child: Row(
                  children: [
                    // Person avatar initial
                    DiviAvatar(pessoa: compra.pessoa, size: 36),
                    const SizedBox(width: 12),
                    // Description + subtitle
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            compra.descricao.toLowerCase(),
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: compra.pago ? kTextSecondary : kTextPrimary,
                              decoration: compra.pago
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Text(
                                compra.pessoa,
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  color: kTextSecondary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                width: 3,
                                height: 3,
                                decoration: const BoxDecoration(
                                  color: kPaperDepth,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                compra.data,
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  color: kTextSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Value
                    Text(
                      fmt(compra.valor),
                      style: TextStyle(
                        fontFamily: 'Young Serif',
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: compra.pago ? kTextSecondary : kPrimaryOlive,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Trailing: one-tap payment toggle
          GestureDetector(
            onTap: () async {
              HapticFeedback.mediumImpact();
              await StampAnimation.show(context, isPaid: !compra.pago);
              if (mounted) {
                ref.read(cartaoProvider.notifier).togglePagamento(compra);
              }
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 48,
              height: 48,
              margin: const EdgeInsets.only(right: 8),
              alignment: Alignment.center,
              child: Icon(
                compra.pago ? Icons.check_circle : Icons.autorenew,
                color: compra.pago ? kSemanticPaid : kSemanticPending,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
