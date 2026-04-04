import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/constants.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/engine/finance_engine.dart';

class PoteStatusCard extends ConsumerWidget {
  const PoteStatusCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Escuta a meta global (Despesas + Cartão) e a arrecadação global no motor unificado
    final totalDespesas =
        ref.watch(diviEngineProvider.select((s) => s.totalDespesasCasa));
    final arrecadado =
        ref.watch(diviEngineProvider.select((s) => s.arrecadadoCasa));

    final progress =
        totalDespesas > 0 ? (arrecadado / totalDespesas).clamp(0.0, 1.0) : 0.0;
    final percent = (progress * 100).toStringAsFixed(1);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: kPrimaryColor.withOpacity(0.05)),
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
                  color: kPrimaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                    Icons.savings,
                    color: kPrimaryColor,
                    size: 28),
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
                "Meta: ${fmt(totalDespesas)}",
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
}
