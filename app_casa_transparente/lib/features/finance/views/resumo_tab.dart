import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/constants.dart';
import '../../../core/utils/formatters.dart';
import '../providers/resumo_provider.dart';

class ResumoTab extends ConsumerWidget {
  const ResumoTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaries = ref.watch(resumoProvider);
    final totalGeral = ref.watch(totalGeralProvider);
    final arrecadado = ref.watch(arrecadadoCasaProvider);

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      children: [
        _buildPoteStatus(arrecadado, totalGeral),
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
        ...pessoas.map((p) => _buildPersonCard(p, summaries[p])),
        const SizedBox(height: 16),
        _buildFooter(totalGeral),
      ],
    );
  }

  Widget _buildPoteStatus(double arrecadado, double total) {
    final progress = total > 0 ? (arrecadado / total).clamp(0.0, 1.0) : 0.0;
    final percent = (progress * 100).toStringAsFixed(1);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: kPrimaryColor.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: kPrimaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.savings_outlined,
                    color: kPrimaryColor, size: 28),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Status do Pote da Casa",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      color: kSlate900,
                    ),
                  ),
                  Text(
                    "Fundo compartilhado mensal",
                    style: TextStyle(
                      fontSize: 13,
                      color: kSlate500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                fmt(arrecadado),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: kPrimaryColor,
                ),
              ),
              Text(
                "Meta: ${fmt(total)}",
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: kSlate400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              color: kPrimaryColor,
              backgroundColor: kSlate100,
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "$percent% arrecadado",
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: kSlate500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonCard(String p, PersonSummary? s) {
    if (s == null) return const SizedBox();

    final statusLabel = s.totalGeral < 0
        ? "Receber"
        : s.totalGeral > 0
            ? "Pagar"
            : "Quitado";
    final statusColor = s.totalGeral < 0
        ? kGreen500
        : s.totalGeral > 0
            ? kRed500
            : kSlate400;
    final statusBg = statusColor.withValues(alpha: 0.1);

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
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: kPrimaryColor.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                        image: avataresPessoa[p] != null
                            ? DecorationImage(
                                image: NetworkImage(avataresPessoa[p]!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: avataresPessoa[p] == null
                          ? Center(
                              child: Text(
                                p[0],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: kPrimaryColor,
                                ),
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      p,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                        color: kSlate900,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    statusLabel.toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: statusColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: kSlate100),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _row("Pendente Casa", fmt(s.pendenteCasa), kSlate500),
                const SizedBox(height: 8),
                _row("Cartão", fmt(s.pendenteCartao), kSlate500),
                if (p == "Luan") ...[
                  const SizedBox(height: 8),
                  _row("Crédito a Receber", fmt(s.creditoCartao), kPrimaryColor,
                      isBold: true),
                ],
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.only(top: 12),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: kSlate100,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        s.totalGeral < 0 ? "SALDO A RECEBER" : "TOTAL A PAGAR",
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: kSlate400,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        fmt(s.totalGeral.abs()),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: s.totalGeral == 0 ? kSlate400 : statusColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String val, Color color, {bool isBold = false}) {
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

  Widget _buildFooter(double total) {
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
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: kSlate600,
                fontFamily: 'Manrope',
              ),
              children: [
                const TextSpan(text: "Custo Total da Casa: "),
                TextSpan(
                  text: fmt(total),
                  style: const TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
