import '../../../../core/engine/finance_engine.dart';
import '../../../../core/providers/app_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../../shared/constants.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../shared/widgets/divi_avatar.dart';

import 'cartao_details_sheet.dart';

class CartaoCard extends ConsumerWidget {
  final String compraId;

  const CartaoCard({super.key, required this.compraId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemState = ref.watch(compraItemProvider(compraId));

    if (itemState == null) return const SizedBox.shrink();

    final compra = itemState.compra;

    return Dismissible(
      key: Key('compra-$compraId'),
      direction: DismissDirection.horizontal,
      dismissThresholds: const {
        DismissDirection.startToEnd: 0.4,
        DismissDirection.endToStart: 0.4,
      },
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          // Swipe Right: Toggle Pago (Snap Back)
          HapticFeedback.mediumImpact();
          ref.read(cartaoProvider.notifier).togglePagamento(compra);
          return false; // Snap back
        } else {
          // Swipe Left: Excluir (Confirm)
          HapticFeedback.vibrate();
          final confirm = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Excluir compra?"),
              content: const Text("Esta ação não pode ser desfeita."),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text("CANCELAR"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  style: TextButton.styleFrom(foregroundColor: kRed500),
                  child: const Text("EXCLUIR"),
                ),
              ],
            ),
          );
          if (confirm == true) {
            ref.read(cartaoProvider.notifier).deleteCompra(compraId);
            return true;
          }
          return false;
        }
      },
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: kGreen500.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.only(left: 24),
        alignment: Alignment.centerLeft,
        child: Icon(
          Icons.check_circle,
          color: kGreen500,
          size: 32,
        ),
      ),
      secondaryBackground: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: kRed500.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.only(right: 24),
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.delete,
          color: kRed500,
          size: 32,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: compra.pago ? const Color(0xFFF0FDF4) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: compra.pago ? const Color(0xFFDCFCE7) : kSlate100,
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    children: [
                      // Person avatar initial
                      DiviAvatar(
                        pessoa: compra.pessoa,
                        size: 36,
                      ),
                      const SizedBox(width: 12),
                      // Description + subtitle
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              compra.descricao.toLowerCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: compra.pago ? kSlate500 : kSlate900,
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
                                    fontSize: 12,
                                    color: kSlate500,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Container(
                                  width: 3,
                                  height: 3,
                                  decoration: const BoxDecoration(
                                    color: kSlate200,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  compra.data,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: kSlate400,
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
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                          color: compra.pago ? kSlate500 : kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Trailing: one-tap payment toggle
            GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                ref.read(cartaoProvider.notifier).togglePagamento(compra);
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: 48,
                height: 48,
                margin: const EdgeInsets.only(right: 8),
                alignment: Alignment.center,
                child: Icon(
                  compra.pago
                      ? Icons.check_circle
                      : Icons.warning,
                  color: compra.pago ? kGreen500 : kRed500,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
