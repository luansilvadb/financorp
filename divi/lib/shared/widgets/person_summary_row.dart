import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../core/engine/finance_engine.dart';
import '../../core/utils/formatters.dart';
import '../constants.dart';
import 'divi_avatar.dart';

/// Row de mini-cards de resumo por pessoa.
/// Cada mini-card é um ConsumerWidget isolado que escuta apenas
/// a sua fatia do resumoProvider via .select(), evitando rebuilds
/// desnecessários nos cards dos colegas quando apenas um balanço muda.
class PersonSummaryRow extends StatelessWidget {
  const PersonSummaryRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: pessoas
          .map((p) => Expanded(
                child: _PersonMiniCard(
                  pessoa: p,
                  isLast: p == pessoas.last,
                ),
              ))
          .toList(),
    );
  }
}

class _PersonMiniCard extends ConsumerWidget {
  final String pessoa;
  final bool isLast;

  const _PersonMiniCard({required this.pessoa, required this.isLast});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Escuta APENAS a fatia desse usuário no mapa de resumos no motor unificado
    final summary = ref.watch(
      diviEngineProvider.select((s) => s.resumo[pessoa]),
    );

    if (summary == null) return const SizedBox();

    final pendCasa = summary.pendenteCasa;
    final pendCartao = summary.pendenteCartao;
    final total = summary.totalGeral;
    final ok = total <= 0;

    return Container(
      margin: EdgeInsets.only(right: isLast ? 0 : 8.0),
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
              DiviAvatar(
                pessoa: pessoa,
                size: 32,
              ),
              PhosphorIcon(
                ok
                    ? PhosphorIcons.checkCircle(PhosphorIconsStyle.fill)
                    : PhosphorIcons.warningCircle(PhosphorIconsStyle.fill),
                color: ok ? kGreen500 : kRed500,
                size: 16,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            pessoa,
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
    );
  }
}
