import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:divi/shared/constants.dart';
import 'package:divi/shared/providers/month_year_provider.dart';
import 'package:divi/shared/widgets/divi_toasts.dart';
import 'widgets/folder_card.dart';

class ArchiveScreen extends ConsumerWidget {
  const ArchiveScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Generate dates for archive
    final now = DateTime.now();
    final months = List.generate(12, (i) {
      final date = DateTime(now.year, now.month - i, 1);
      return date;
    });

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
              child: GridView.builder(
                padding:
                    const EdgeInsets.only(left: 24, right: 24, bottom: 120),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                ),
                itemCount: months.length,
                itemBuilder: (context, index) {
                  final date = months[index];
                  return FolderCard(
                    label: mesesAbrev[date.month - 1],
                    sublabel: date.year.toString(),
                    onTap: () {
                      ref.read(periodProvider.notifier).setMes(date.month - 1);
                      ref.read(periodProvider.notifier).setAno(date.year);

                      // Haptic Feedback for premium feel
                      HapticFeedback.mediumImpact();

                      DiviToasts.show(
                        context,
                        "ABRINDO ${mesesFull[date.month - 1].toUpperCase()} ${date.year}",
                      );
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
