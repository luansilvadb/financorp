import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_line/dotted_line.dart';

import '../../../shared/constants.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/engine/finance_engine.dart';
import '../../../shared/widgets/divi_avatar.dart';

class SettlementScreen extends ConsumerWidget {
  const SettlementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final engine = ref.watch(diviEngineProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            // Header
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 40, 24, 32),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ACERTO DE CONTAS",
                      style: GoogleFonts.spaceMono(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryOlive,
                        letterSpacing: 4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Quem deve quem",
                      style: GoogleFonts.youngSerif(
                        fontSize: 32,
                        color: kTextPrimary,
                        letterSpacing: -1,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Target Individual Cost Card
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: kPrimaryOlive.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: kPrimaryOlive.withValues(alpha: 0.1)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "CUSTO POR PESSOA ESTE MÊS",
                        style: GoogleFonts.spaceMono(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: kTextMuted,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        fmt(engine.custoIndividualAlvo),
                        style: GoogleFonts.youngSerif(
                          fontSize: 36,
                          color: kPrimaryOlive,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const DottedLine(dashColor: kPaperDepth),
                      const SizedBox(height: 16),
                      Text(
                        "Total da Casa: ${fmt(engine.totalGeral)}",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: kTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 32)),

            // Balances List
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "STATUS INDIVIDUAL",
                      style: GoogleFonts.spaceMono(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: kTextMuted,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...pessoas.map((p) {
                      final res = engine.resumo[p];
                      if (res == null) return const SizedBox.shrink();

                      final isDevedor = res.saldoAcerto > 0.01;
                      final isQuitado = res.saldoAcerto.abs() <= 0.01;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: kPaperDepth),
                        ),
                        child: Row(
                          children: [
                            DiviAvatar(pessoa: p, size: 40),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    p,
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w700,
                                      color: kTextPrimary,
                                    ),
                                  ),
                                  Text(
                                    "Pagou ${fmt(res.valorPagoReal)}",
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: kTextSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  isQuitado ? "QUITADO" : fmt(res.saldoAcerto.abs()),
                                  style: GoogleFonts.spaceMono(
                                    fontWeight: FontWeight.bold,
                                    color: isQuitado
                                        ? kSemanticPaid
                                        : (isDevedor ? kSemanticOverdue : kSemanticPaid),
                                  ),
                                ),
                                Text(
                                  isQuitado ? "EM DIA" : (isDevedor ? "A PAGAR" : "A RECEBER"),
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    color: isQuitado
                                        ? kSemanticPaid
                                        : (isDevedor ? kSemanticOverdue : kSemanticPaid),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 32)),

            // Suggested Transfers
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "COMO LIQUIDAR",
                      style: GoogleFonts.spaceMono(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: kTextMuted,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (engine.transferencias.isEmpty)
                      Container(
                        padding: const EdgeInsets.all(24),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: kSemanticPaid.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: kSemanticPaid.withValues(alpha: 0.1)),
                        ),
                        child: Column(
                          children: [
                            const Icon(Icons.check_circle_outline, color: kSemanticPaid, size: 32),
                            const SizedBox(height: 12),
                            Text(
                              "Tudo equilibrado!",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                color: kSemanticPaidDark,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      ...engine.transferencias.map((t) => _TransferCard(transfer: t)),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 120)),
          ],
        ),
      ),
    );
  }
}

class _TransferCard extends StatelessWidget {
  final SettlementTransfer transfer;
  const _TransferCard({required this.transfer});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kHighlight.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kHighlight),
      ),
      child: Row(
        children: [
          _PessoaMini(pessoa: transfer.de, label: "DE"),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Icon(Icons.arrow_forward_rounded, color: kTextMuted, size: 20),
            ),
          ),
          Column(
            children: [
              Text(
                fmt(transfer.valor),
                style: GoogleFonts.youngSerif(
                  fontSize: 20,
                  color: kTextPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: kTextPrimary,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  "PIX",
                  style: GoogleFonts.spaceMono(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Icon(Icons.arrow_forward_rounded, color: kTextMuted, size: 20),
            ),
          ),
          _PessoaMini(pessoa: transfer.para, label: "PARA"),
        ],
      ),
    );
  }
}

class _PessoaMini extends StatelessWidget {
  final String pessoa;
  final String label;
  const _PessoaMini({required this.pessoa, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.spaceMono(
            fontSize: 9,
            fontWeight: FontWeight.bold,
            color: kTextMuted,
          ),
        ),
        const SizedBox(height: 6),
        DiviAvatar(pessoa: pessoa, size: 36),
        const SizedBox(height: 4),
        Text(
          pessoa,
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: kTextPrimary,
          ),
        ),
      ],
    );
  }
}
