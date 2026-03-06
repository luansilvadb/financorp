import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/widgets/card_skeleton.dart';
import '../../../shared/providers/month_year_provider.dart';
import '../../../shared/constants.dart';

import '../../../core/utils/formatters.dart';
import '../providers/cartao_providers.dart';
import '../../../core/engine/finance_engine.dart';

import 'widgets/cartao_card.dart';

class CartaoTab extends ConsumerWidget {
  const CartaoTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final comprasAsync = ref.watch(cartaoProvider);
    final period = ref.watch(periodProvider);
    // Consome os dados já agrupados e indexados pelo motor (O(1) access na View)
    final grouped = ref.watch(financeEngineProvider.select((s) => s.comprasPorPessoa));

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: comprasAsync.when(
        data: (compras) {

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 200),
            children: [
              _buildLancamentosHeader(period),
              const SizedBox(height: 16),
              // Renderizar grupos filtrando quem não tem lançamentos
              ...grouped.entries.where((e) => e.value.isNotEmpty).expand((entry) {
                final pessoa = entry.key;
                final itens = entry.value;
                final subtotal = itens.fold(0.0, (acc, c) => acc + c.valor);

                return [
                  _buildGroupHeader(pessoa, subtotal),
                  ...itens.where((c) => c.id != null).map((c) => CartaoCard(compraId: c.id!)),
                  const SizedBox(height: 16),
                ];
              }),
              if (compras.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text(
                      "Nenhum lançamento este mês",
                      style: TextStyle(color: kSlate400, fontSize: 14),
                    ),
                  ),
                ),
            ],
          );
        },
        loading: () => ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 200),
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

  Widget _buildLancamentosHeader(Period period) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "LANÇAMENTOS",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w900,
            color: kSlate900,
            letterSpacing: 1.5,
          ),
        ),
        Text(
          "${mesesFull[period.mes]} ${period.ano}",
          style: const TextStyle(
            fontSize: 12,
            color: kSlate400,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildGroupHeader(String pessoa, double subtotal) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4, right: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 14,
                decoration: BoxDecoration(
                  color: coresPessoa[pessoa] ?? kPrimaryColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                pessoa.toUpperCase(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: kSlate900,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          Text(
            fmt(subtotal),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: coresPessoa[pessoa]?.withOpacity(0.8) ?? kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
