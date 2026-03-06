import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../shared/constants.dart';
import '../../../../shared/models/despesa.dart';
import '../../../../core/utils/formatters.dart';
import '../../providers/finance_providers.dart';

import 'despesa_details_sheet.dart';

class DespesaCard extends ConsumerWidget {
  final Despesa despesa;

  const DespesaCard({super.key, required this.despesa});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pagamentos = ref.watch(pagamentosProvider).value ?? [];

    // Count how many of the 3 people have paid
    final totalPago = pessoas
        .where((p) => pagamentos.any(
              (pag) =>
                  pag.despesaId == despesa.id && pag.pessoa == p && pag.pago,
            ))
        .length;
    final allPaid = totalPago == pessoas.length;

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => DespesaDetailsSheet(despesa: despesa),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: kSlate100),
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
            // Left content: name + due date
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    despesa.nome,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: kSlate900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: kPrimaryColor.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "Dia ${despesa.diaVencimento}",
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: kPrimaryColor,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "${fmt(despesa.valor / 3)} /pessoa",
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

            // Right: value + status indicator
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  fmt(despesa.valor),
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    color: kSlate900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "$totalPago/${pessoas.length} pagos",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: allPaid ? kGreen500 : kSlate400,
                  ),
                ),
              ],
            ),

            const SizedBox(width: 12),

            // Trailing: consolidated status icon
            PhosphorIcon(
              allPaid
                  ? PhosphorIcons.checkCircle(PhosphorIconsStyle.fill)
                  : PhosphorIcons.warningCircle(PhosphorIconsStyle.fill),
              color: allPaid ? kGreen500 : kRed500,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
