import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../shared/providers/month_year_provider.dart';
import '../../../shared/constants.dart';
import '../../../shared/models/compra_cartao.dart';
import '../../../core/utils/formatters.dart';
import '../providers/cartao_providers.dart';

import 'widgets/add_purchase_sheet.dart';

class CartaoTab extends ConsumerStatefulWidget {
  const CartaoTab({super.key});

  @override
  ConsumerState<CartaoTab> createState() => _CartaoTabState();
}

class _CartaoTabState extends ConsumerState<CartaoTab> {
  String? expandedId;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          controller: _scrollController,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 200),
          children: [
            _buildSummary(compras),
            const SizedBox(height: 32),
            _buildLancamentosHeader(period),
            const SizedBox(height: 16),
            ...compras.map((c) => _buildCompraItem(c)),
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

  Widget _buildCompraItem(CompraCartao c) {
    final isExpanded = expandedId == c.id;
    final color = c.pago ? kGreen500 : kPrimaryColor;
    final bgColor = c.pago ? const Color(0xFFF0FDF4) : Colors.white;
    final borderColor = c.pago ? const Color(0xFFDCFCE7) : kSlate100;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isExpanded ? Colors.white : bgColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
        boxShadow: isExpanded
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => setState(() => expandedId = isExpanded ? null : c.id),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: PhosphorIcon(
                      c.pago
                          ? PhosphorIcons.checkCircle(PhosphorIconsStyle.fill)
                          : PhosphorIcons.forkKnife(PhosphorIconsStyle.regular),
                      color: color,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          c.descricao.toLowerCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            color: c.pago ? kSlate500 : kSlate900,
                            decoration:
                                c.pago ? TextDecoration.lineThrough : null,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              c.pessoa,
                              style: const TextStyle(
                                fontSize: 12,
                                color: kSlate500,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 4,
                              height: 4,
                              decoration: const BoxDecoration(
                                color: kSlate200,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              c.data,
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
                  Text(
                    fmt(c.valor),
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      color: c.pago ? kSlate500 : kPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: [
                  const Divider(height: 1, color: kSlate100),
                  const SizedBox(height: 16),
                  _buildActionBtn(
                    label: c.pago ? "Marcar Pendente" : "Marcar como Pago",
                    icon: c.pago
                        ? PhosphorIcons.arrowCounterClockwise(
                            PhosphorIconsStyle.regular)
                        : PhosphorIcons.checkCircle(PhosphorIconsStyle.regular),
                    color: c.pago ? kSlate600 : kGreen500,
                    onTap: () {
                      ref.read(cartaoProvider.notifier).togglePagamento(c);
                      setState(() => expandedId = null);
                    },
                    fullWidth: true,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildActionBtn(
                          label: "Editar",
                          icon: PhosphorIcons.pencilSimple(
                              PhosphorIconsStyle.regular),
                          color: kPrimaryColor,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) =>
                                  AddPurchaseSheet(purchase: c),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildActionBtn(
                          label: "Excluir",
                          icon: PhosphorIcons.trash(PhosphorIconsStyle.regular),
                          color: kRed500,
                          onTap: () {
                            ref
                                .read(cartaoProvider.notifier)
                                .deleteCompra(c.id!);
                            setState(() => expandedId = null);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActionBtn({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    bool fullWidth = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: fullWidth ? double.infinity : null,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            PhosphorIcon(icon, color: color, size: 20),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
