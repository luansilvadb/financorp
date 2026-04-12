import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/engine/finance_engine.dart';
import '../../../../shared/constants.dart';
import '../../../../shared/widgets/skeuomorphic.dart';

class ZReportCard extends ConsumerWidget {
  const ZReportCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Escuta apenas as despesas fixas da casa com complexidade O(1)
    final totalDespesas =
        ref.watch(diviEngineProvider.select((s) => s.totalDespesasCasa));

    final formatCurrency = NumberFormat.simpleCurrency(locale: 'pt_BR');

    return ClipPath(
      clipper:
          ReceiptClipper(jaggedTop: false, jaggedBottom: true, toothSize: 5),
      child: Container(
        color: Colors.white,
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "RESUMO DO MÊS",
              style: TextStyle(
                fontFamily: 'Space Mono',
                color: kInkFaded,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const DashedDivider(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "DESPESAS FIXAS",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: kInk,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  formatCurrency.format(totalDespesas),
                  style: const TextStyle(
                    fontFamily: 'Space Mono',
                    color: kInk,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "POR PESSOA",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: kInkFaded,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  formatCurrency.format(totalDespesas / 3),
                  style: const TextStyle(
                    fontFamily: 'Space Mono',
                    color: kInkFaded,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
