import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/engine/finance_engine.dart';
import '../../../../shared/constants.dart';
import '../../../../shared/widgets/skeuomorphic.dart';

class PoteStatusCard extends ConsumerWidget {
  const PoteStatusCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final financeState = ref.watch(diviEngineProvider);
    final total = financeState.totalDespesasCasa;
    final arrecadado = financeState.arrecadadoCasa;
    
    final progress = total > 0 ? (arrecadado / total).clamp(0.0, 1.0) : 0.0;
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'pt_BR');

    return ClipPath(
      clipper: ReceiptClipper(jaggedTop: false, jaggedBottom: true, toothSize: 5),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "POTE DA CASA",
                  style: TextStyle(
                    fontFamily: 'Space Mono',
                    color: kInkFaded,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                Text(
                  "${(progress * 100).toInt()}%",
                  style: TextStyle(
                    fontFamily: 'Space Mono',
                    color: progress >= 1.0 ? kSemanticPaid : kInk,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Progress Bar
            Stack(
              children: [
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: kSlate100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  height: 8,
                  width: (MediaQuery.of(context).size.width - 72) * progress,
                  decoration: BoxDecoration(
                    color: progress >= 1.0 ? kSemanticPaid : kSemanticPending,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: (progress >= 1.0 ? kSemanticPaid : kSemanticPending).withValues(alpha: 0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Arrecadado: ${formatCurrency.format(arrecadado)}",
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 11,
                    color: kInkFaded,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Meta: ${formatCurrency.format(total)}",
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 11,
                    color: kInkFaded,
                    fontWeight: FontWeight.w500,
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
