import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/constants.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/engine/finance_engine.dart';
import '../../../shared/widgets/divi_avatar.dart';
import 'widgets/pote_status_card.dart';

class ResumoTab extends ConsumerWidget {
  const ResumoTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Escuta APENAS as mudanças no total geral no motor unificado
    final totalGeral =
        ref.watch(diviEngineProvider.select((s) => s.totalGeral));

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 200),
      children: [
        // Widget isolado para o Pote (não reconstrói o resto da aba)
        const PoteStatusCard(),
        const SizedBox(height: 24),
        const Text(
          "RESUMO POR PESSOA",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w900,
            color: kSlate400,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 12),
        // Renderiza cada card de pessoa de forma granular
        ...pessoas.map((p) => _PersonSummaryCard(pessoa: p)),
        const SizedBox(height: 16),
        _FooterSummary(total: totalGeral),
      ],
    );
  }
}

/// Widget privado para isolar a reconstrução de cada pessoa no resumo.
class _PersonSummaryCard extends ConsumerWidget {
  final String pessoa;
  const _PersonSummaryCard({required this.pessoa});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Assiste apenas o resumo desta pessoa específica no motor unificado
    final summary =
        ref.watch(diviEngineProvider.select((s) => s.resumo[pessoa]));

    if (summary == null) return const SizedBox.shrink();

    final statusLabel = summary.totalGeral < 0
        ? "Receber"
        : summary.totalGeral > 0
            ? "Pagar"
            : "Quitado";
    final statusColor = summary.totalGeral < 0
        ? kGreen500
        : summary.totalGeral > 0
            ? kRed500
            : kSlate400;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: kPrimaryColor.withValues(alpha: 0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    DiviAvatar(pessoa: pessoa, size: 40),
                    const SizedBox(width: 12),
                    Text(
                      pessoa,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                        color: kSlate900,
                      ),
                    ),
                  ],
                ),
                _StatusBadge(label: statusLabel, color: statusColor),
              ],
            ),
          ),
          const Divider(height: 1, color: kSlate100),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _SummaryRow(
                    label: "Pendente Casa", val: fmt(summary.pendenteCasa)),
                const SizedBox(height: 8),
                _SummaryRow(label: "Cartão", val: fmt(summary.pendenteCartao)),
                if (pessoa == "Luan") ...[
                  const SizedBox(height: 8),
                  _SummaryRow(
                      label: "Crédito a Receber",
                      val: fmt(summary.creditoCartao),
                      color: kPrimaryColor,
                      isBold: true),
                ],
                const SizedBox(height: 16),
                _TotalRow(
                  label: summary.totalGeral < 0
                      ? "SALDO A RECEBER"
                      : "TOTAL A PAGAR",
                  val: fmt(summary.totalGeral.abs()),
                  color: summary.totalGeral == 0 ? kSlate400 : statusColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// SUB-COMPONETES PRIVADOS PARA LIMPEZA E DENSIDADE

class _StatusBadge extends StatelessWidget {
  final String label;
  final Color color;
  const _StatusBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w900,
          color: color,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String val;
  final Color color;
  final bool isBold;

  const _SummaryRow({
    required this.label,
    required this.val,
    this.color = kSlate500,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w500,
            color: isBold ? color : kSlate500,
          ),
        ),
        Text(
          val,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: isBold ? color : kSlate900,
          ),
        ),
      ],
    );
  }
}

class _TotalRow extends StatelessWidget {
  final String label;
  final String val;
  final Color color;

  const _TotalRow(
      {required this.label, required this.val, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: kSlate100, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: kSlate400,
              letterSpacing: 0.5,
            ),
          ),
          Text(
            val,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterSummary extends StatelessWidget {
  final double total;
  const _FooterSummary({required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kPrimaryColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kPrimaryColor.withValues(alpha: 0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.info_outline, color: kPrimaryColor, size: 20),
          const SizedBox(width: 8),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w600, color: kSlate600),
              children: [
                const TextSpan(text: "Custo Total da Casa: "),
                TextSpan(
                  text: fmt(total),
                  style: const TextStyle(
                      color: kPrimaryColor, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
