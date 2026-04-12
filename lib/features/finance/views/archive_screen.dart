import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:divi/shared/constants.dart';
import 'package:divi/shared/providers/month_year_provider.dart';
import 'package:divi/shared/widgets/divi_toasts.dart';
import 'package:divi/core/engine/finance_engine.dart';
import 'widgets/folder_card.dart';

class ArchiveScreen extends ConsumerWidget {
  const ArchiveScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final financeState = ref.watch(diviEngineProvider);

    // Generate dates for last 24 months
    final now = DateTime.now();
    final allMonths = List.generate(24, (i) {
      return DateTime(now.year, now.month - i, 1);
    });

    // Filter to show only months with data
    final monthsWithData = <DateTime, int>{};
    for (final date in allMonths) {
      // For now, show all months that have ANY data in the system
      // This is a simplification - ideally we'd track month/year per expense
      if (financeState.despesas.isNotEmpty ||
          financeState.compras.values.isNotEmpty) {
        monthsWithData[date] =
            financeState.despesas.length + financeState.compras.values.length;
      }
    }

    // If no data at all, show last 12 months anyway
    final displayMonths = monthsWithData.isEmpty
        ? List.generate(
            12,
            (i) => DateTime(now.year, now.month - i, 1),
          ).map((d) => MapEntry(d, 0)).toList()
        : monthsWithData.entries.toList();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Refined Header
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 40, 24, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "HISTÓRICO",
                    style: TextStyle(
                      fontFamily: 'Space Mono',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                      letterSpacing: 4,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Arquivo Digital",
                    style: TextStyle(
                      fontFamily: 'Young Serif',
                      fontSize: 32,
                      color: kInk,
                      letterSpacing: -1,
                    ),
                  ),
                ],
              ),
            ),

            // Content Grid
            Expanded(
              child: displayMonths.isEmpty
                  ? const Center(
                      child: Text(
                        "Nenhum histórico disponível",
                        style: TextStyle(
                          fontFamily: 'Space Mono',
                          color: kInkFaded,
                        ),
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.only(
                        left: 24,
                        right: 24,
                        bottom: 120,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 1.1,
                          ),
                      itemCount: displayMonths.length,
                      itemBuilder: (context, index) {
                        final entry = displayMonths[index];
                        final date = entry.key;
                        final expenseCount = entry.value;
                        return FolderCard(
                          label: mesesAbrev[date.month - 1],
                          sublabel: date.year.toString(),
                          recordCount: expenseCount,
                          onTap: () {
                            ref
                                .read(periodProvider.notifier)
                                .setMes(date.month - 1);
                            ref.read(periodProvider.notifier).setAno(date.year);

                            // Haptic Feedback for premium feel
                            HapticFeedback.mediumImpact();

                            DiviToasts.show(
                              context,
                              "ABRINDO ${mesesFull[date.month - 1].toUpperCase()} ${date.year}",
                            );

                            // Navigate back to LedgerScreen
                            Navigator.of(
                              context,
                            ).popUntil((route) => route.isFirst);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
