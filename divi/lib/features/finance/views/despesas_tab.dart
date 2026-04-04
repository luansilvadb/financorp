import '../../../core/providers/app_providers.dart';




import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/card_skeleton.dart';
import '../../../shared/providers/month_year_provider.dart';
import '../../../shared/constants.dart';

import '../../../core/utils/formatters.dart';
import '../providers/finance_providers.dart';
import '../../../core/engine/finance_engine.dart';

import 'widgets/despesa_card.dart';

class DespesasTab extends ConsumerWidget {
  const DespesasTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final despesasAsync = ref.watch(despesasProvider);
    final period = ref.watch(periodProvider);
    final totalCasa =
        ref.watch(diviEngineProvider.select((s) => s.totalDespesasCasa));

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: despesasAsync.when(
        data: (despesas) => ListView(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 200),
          children: [
            // Expenses List Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Mês/Ano",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: kSlate900,
                      ),
                    ),
                    Text(
                      "${mesesFull[period.mes]} ${period.ano}",
                      style: const TextStyle(
                        color: kSlate500,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      fmt(totalCasa),
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: kPrimaryColor,
                      ),
                    ),
                    const Text(
                      "Total mensal",
                      style: TextStyle(
                        color: kSlate500,
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Despesas Fixas — cada card é um ConsumerWidget isolado
            ...despesas
                .where((d) => d.id != null)
                .map((d) => DespesaCard(despesaId: d.id!)),
          ],
        ),
        loading: () => ListView(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 200),
          children: const [
            CardSkeleton(),
            CardSkeleton(),
            CardSkeleton(),
          ],
        ),
        error: (e, st) => Center(child: Text("Erro: $e")),
      ),
    );
  }
}
