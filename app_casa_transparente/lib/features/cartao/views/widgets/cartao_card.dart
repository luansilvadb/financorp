import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../shared/constants.dart';
import '../../../../shared/models/compra_cartao.dart';
import '../../../../core/utils/formatters.dart';
import '../../providers/cartao_providers.dart';

import 'cartao_details_sheet.dart';

class CartaoCard extends ConsumerWidget {
  final CompraCartao compra;

  const CartaoCard({super.key, required this.compra});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personColor = coresPessoa[compra.pessoa] ?? kPrimaryColor;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: compra.pago ? const Color(0xFFF0FDF4) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: compra.pago ? const Color(0xFFDCFCE7) : kSlate100,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
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
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: personColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          compra.pessoa[0].toUpperCase(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: personColor,
                          ),
                        ),
                      ),
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
              child: PhosphorIcon(
                compra.pago
                    ? PhosphorIcons.checkCircle(PhosphorIconsStyle.fill)
                    : PhosphorIcons.warningCircle(PhosphorIconsStyle.fill),
                color: compra.pago ? kGreen500 : kRed500,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
