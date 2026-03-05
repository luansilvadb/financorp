import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/finance/providers/resumo_provider.dart';
import '../../core/utils/formatters.dart';
import '../constants.dart';

class PersonSummaryRow extends ConsumerWidget {
  const PersonSummaryRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaries = ref.watch(resumoProvider);

    return Row(
      children: pessoas.map((p) {
        final summary = summaries[p];
        if (summary == null) return const Expanded(child: SizedBox());

        final pendCasa = summary.pendenteCasa;
        final pendCartao = summary.pendenteCartao;
        final total = summary.totalGeral;
        final ok = total <= 0;

        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: p == pessoas.last ? 0 : 8.0),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(
                color: ok ? kSlate100 : const Color(0xFFFEE2E2),
                width: ok ? 1 : 2,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: coresPessoa[p]?.withOpacity(0.1),
                        image: DecorationImage(
                          image: NetworkImage(avataresPessoa[p]!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Icon(
                      ok ? Icons.check_circle : Icons.error,
                      color: ok ? kGreen500 : kRed500,
                      size: 16,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  p,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    color: kSlate900,
                  ),
                ),
                Text(
                  "Casa: ${fmt(pendCasa)}",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 10, color: kSlate500),
                ),
                Text(
                  "Cartão: ${fmt(pendCartao)}",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 10, color: kSlate500),
                ),
                const SizedBox(height: 6),
                Text(
                  ok ? "SALDO ${fmt(total.abs())}" : "FALTAM ${fmt(total)}",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 9,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w900,
                    color: ok ? kGreen500 : kRed500,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
