import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../shared/constants.dart';
import '../../../../shared/models/compra_cartao.dart';
import '../../../../core/utils/formatters.dart';
import '../../providers/cartao_providers.dart';

import 'add_purchase_sheet.dart';

class CartaoDetailsSheet extends ConsumerWidget {
  final CompraCartao compra;

  const CartaoDetailsSheet({super.key, required this.compra});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personColor = coresPessoa[compra.pessoa] ?? kPrimaryColor;

    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 12, bottom: 32),
      decoration: const BoxDecoration(
        color: Colors.white,
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
              color: kSlate200,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header: Avatar + Title + Value
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: personColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    compra.pessoa[0].toUpperCase(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: personColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      compra.descricao,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: kSlate900,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "${compra.pessoa} • ${compra.data}",
                      style: const TextStyle(
                        fontSize: 13,
                        color: kSlate400,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                fmt(compra.valor),
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                  color: kSlate900,
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
                color: compra.pago ? kSlate100 : const Color(0xFFF0FDF4),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: compra.pago ? kSlate200 : const Color(0xFFDCFCE7),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PhosphorIcon(
                    compra.pago
                        ? PhosphorIcons.arrowCounterClockwise(
                            PhosphorIconsStyle.regular)
                        : PhosphorIcons.checkCircle(PhosphorIconsStyle.regular),
                    color: compra.pago ? kSlate600 : kGreen500,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    compra.pago ? "Marcar Pendente" : "Marcar como Pago",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                      color: compra.pago ? kSlate600 : kGreen500,
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
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => AddPurchaseSheet(purchase: compra),
                    );
                  },
                  icon: PhosphorIcon(
                    PhosphorIcons.pencilSimple(PhosphorIconsStyle.regular),
                    size: 20,
                  ),
                  label: const Text(
                    "Editar",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: kPrimaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: kPrimaryColor.withOpacity(0.15),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextButton.icon(
                  onPressed: () {
                    ref.read(cartaoProvider.notifier).deleteCompra(compra.id!);
                    Navigator.pop(context);
                  },
                  icon: PhosphorIcon(
                    PhosphorIcons.trash(PhosphorIconsStyle.regular),
                    size: 20,
                  ),
                  label: const Text(
                    "Excluir",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: kRed500,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(color: Color(0xFFFEE2E2)),
                    ),
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
