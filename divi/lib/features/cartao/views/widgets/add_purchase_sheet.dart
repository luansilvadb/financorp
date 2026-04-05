import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../shared/constants.dart';
import '../../../../shared/models/compra_cartao.dart';
import '../../../../shared/providers/month_year_provider.dart';
import '../../../../core/utils/formatters.dart';
import '../../providers/cartao_providers.dart';
import '../../../../shared/widgets/form/divi_input.dart';
import '../../../../shared/widgets/form/divi_radio.dart';

class AddPurchaseSheet extends ConsumerStatefulWidget {
  final CompraCartao? purchase;
  const AddPurchaseSheet({super.key, this.purchase});

  @override
  ConsumerState<AddPurchaseSheet> createState() => _AddPurchaseSheetState();
}

class _AddPurchaseSheetState extends ConsumerState<AddPurchaseSheet> {
  final _descCtrl = TextEditingController();
  final _valorCtrl = TextEditingController();
  String _pessoa = "Luciana";

  @override
  void initState() {
    super.initState();
    if (widget.purchase != null) {
      final p = widget.purchase!;
      _descCtrl.text = p.descricao;
      _valorCtrl.text = fmt(p.valor).replaceAll(RegExp(r'R\$\s*'), '');
      _pessoa = p.pessoa;
    }
  }

  @override
  void dispose() {
    _descCtrl.dispose();
    _valorCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.purchase != null;

    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 12,
        bottom: MediaQuery.of(context).viewInsets.bottom + 32,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: kSlate200,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: PhosphorIcon(
                      isEditing
                          ? PhosphorIcons.pencilSimple(
                              PhosphorIconsStyle.regular)
                          : PhosphorIcons.creditCard(
                              PhosphorIconsStyle.regular),
                      color: kPrimaryColor,
                      size: 24),
                ),
                const SizedBox(width: 12),
                Text(
                  isEditing ? "Editar Gasto" : "Novo Gasto",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: kSlate900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            DiviInput(
              label: "DESCRIÇÃO",
              hintText: "Ex: Comida, Farmácia...",
              initialValue: _descCtrl.text,
              onChanged: (value) => _descCtrl.text = value ?? '',
            ),
            const SizedBox(height: 20),
            DiviInput(
              label: "VALOR (R\$)",
              hintText: "0,00",
              keyboardType: TextInputType.number,
              initialValue: _valorCtrl.text,
              onChanged: (value) => _valorCtrl.text = value ?? '',
            ),
            const SizedBox(height: 20),
            DiviRadioGroup(
              label: "QUEM GASTOU?",
              options: pessoas,
              value: _pessoa,
              onChanged: (value) => setState(() => _pessoa = value ?? _pessoa),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      foregroundColor: kSlate500,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      "Cancelar",
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final desc = _descCtrl.text.trim();
                      final valor = parseBrl(_valorCtrl.text);

                      if (desc.isEmpty || valor <= 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text("Preencha a descrição e um valor válido"),
                            backgroundColor: kRed500,
                          ),
                        );
                        return;
                      }

                      final period = ref.read(periodProvider);
                      final c = CompraCartao(
                        id: widget.purchase?.id,
                        data: widget.purchase?.data ??
                            DateTime.now().toIso8601String().split('T')[0],
                        descricao: desc,
                        valor: valor,
                        pessoa: _pessoa,
                        mes: widget.purchase?.mes ?? period.mes,
                        ano: widget.purchase?.ano ?? period.ano,
                        pago: widget.purchase?.pago ?? false,
                      );
                      ref.read(cartaoProvider.notifier).addCompra(c);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shadowColor: kPrimaryColor.withOpacity(0.4),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      isEditing ? "Salvar Alterações" : "Salvar",
                      style: const TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
