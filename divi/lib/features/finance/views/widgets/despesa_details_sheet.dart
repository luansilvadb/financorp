import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../../shared/constants.dart';
import '../../../../shared/models/domain.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/providers/app_providers.dart';

import 'add_expense_sheet.dart';

class DespesaDetailsSheet extends ConsumerWidget {
  final Despesa despesa;

  const DespesaDetailsSheet({super.key, required this.despesa});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pagamentos = ref.watch(pagamentosProvider).value ?? [];

    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 12, bottom: 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              color: kSlate200,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header: Icon + Title
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.receipt,
                  color: kPrimaryColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      despesa.nome,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: kSlate900,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: kPrimaryColor.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        "VENC. DIA ${despesa.diaVencimento}",
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: kPrimaryColor,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    fmt(despesa.valor),
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 22,
                      color: kSlate900,
                    ),
                  ),
                  Text(
                    "${fmt(despesa.valor / 3)} /pessoa",
                    style: const TextStyle(
                      fontSize: 12,
                      color: kSlate400,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Payment Status per Person
          Row(
            children: pessoas.map((p) {
              final pago = pagamentos.any(
                (pag) =>
                    pag.despesaId == despesa.id && pag.pessoa == p && pag.pago,
              );
              final color = pago ? kGreen500 : kRed500;
              final bgColor =
                  pago ? const Color(0xFFF0FDF4) : const Color(0xFFFEF2F2);
              final borderColor =
                  pago ? const Color(0xFFDCFCE7) : const Color(0xFFFEE2E2);

              return Expanded(
                child: GestureDetector(
                  onTap: () => ref
                      .read(pagamentosProvider.notifier)
                      .togglePagamento(despesa.id!, p, pago),
                  child: Container(
                    margin: EdgeInsets.only(
                      right: p == pessoas.last ? 0 : 8,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: borderColor),
                    ),
                    child: Column(
                      children: [
                        Text(
                          p.toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            color: color,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Icon(
                          pago
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: color,
                          size: 22,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 28),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => AddExpenseSheet(expense: despesa),
                    );
                  },
                  icon: Icon(
                    Icons.edit,
                    size: 20,
                  ),
                  label: const Text(
                    "Editar",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: kPrimaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: kPrimaryColor.withOpacity(0.15),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextButton.icon(
                  onPressed: () {
                    ref
                        .read(despesasProvider.notifier)
                        .deleteDespesa(despesa.id!);
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.delete,
                    size: 20,
                  ),
                  label: const Text(
                    "Excluir",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: kRed500,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(color: Color(0xFFFEE2E2)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
