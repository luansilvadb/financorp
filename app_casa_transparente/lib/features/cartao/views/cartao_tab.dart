import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../shared/providers/month_year_provider.dart';
import '../../../shared/constants.dart';
import '../../../shared/models/compra_cartao.dart';
import '../../../core/utils/formatters.dart';
import '../providers/cartao_providers.dart';

import 'widgets/add_purchase_sheet.dart';
import 'widgets/cartao_card.dart';

class CartaoTab extends ConsumerWidget {
  const CartaoTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final comprasAsync = ref.watch(cartaoProvider);
    final period = ref.watch(periodProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const AddPurchaseSheet(),
          );
        },
        backgroundColor: kPrimaryColor,
        shape: const CircleBorder(),
        elevation: 6,
        child: PhosphorIcon(PhosphorIcons.plus(PhosphorIconsStyle.bold),
            color: Colors.white, size: 32),
      ),
      body: comprasAsync.when(
        data: (compras) => ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 200),
          children: [
            _buildSummary(compras),
            const SizedBox(height: 32),
            _buildLancamentosHeader(period),
            const SizedBox(height: 16),
            // Cada compra é agora um ConsumerStatefulWidget isolado
            ...compras.map((c) => CartaoCard(compra: c)),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text("Erro: $e")),
      ),
    );
  }

  Widget _buildSummary(List<CompraCartao> compras) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "RESUMO DE DÍVIDAS",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w900,
            color: kSlate400,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: ["Luciana", "Giovanna"].map((p) {
            // Filtrar apenas compras não pagas para o resumo de dívidas
            final total = compras
                .where((c) => c.pessoa == p && !c.pago)
                .fold(0.0, (a, b) => a + b.valor);
            final hasDebt = total > 0;

            return Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  right: p == "Luciana" ? 12 : 0,
                ),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: kSlate100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p,
                      style: const TextStyle(
                        color: kSlate500,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      fmt(total),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: hasDebt ? kPrimaryColor : kSlate400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      hasDebt ? "Pendente" : "Sem pendências",
                      style: const TextStyle(
                        fontSize: 10,
                        color: kSlate400,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
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
}
