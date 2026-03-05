import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/constants.dart';
import '../../../../shared/models/compra_cartao.dart';
import '../../../../shared/providers/month_year_provider.dart';
import '../../../../core/utils/formatters.dart';
import '../../providers/cartao_providers.dart';

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
                  child: Icon(
                      isEditing
                          ? Icons.edit_note_rounded
                          : Icons.credit_card_rounded,
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
            _field("DESCRIÇÃO", _descCtrl, Icons.description_outlined,
                placeholder: "Ex: Comida, Farmácia..."),
            const SizedBox(height: 20),
            _field("VALOR (R\$)", _valorCtrl, Icons.payments_outlined,
                placeholder: "0,00",
                keyboardType: TextInputType.number,
                formatters: [BrlCurrencyInputFormatter()]),
            const SizedBox(height: 20),
            _selectField("QUEM GASTOU?"),
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

  Widget _field(
    String label,
    TextEditingController ctrl,
    IconData icon, {
    String? placeholder,
    TextInputType? keyboardType,
    List<TextInputFormatter>? formatters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w900,
            color: kSlate400,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: ctrl,
          keyboardType: keyboardType,
          inputFormatters: formatters,
          style: const TextStyle(
              fontWeight: FontWeight.w700, fontSize: 16, color: kSlate900),
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: TextStyle(
                color: kSlate400.withOpacity(0.6),
                fontWeight: FontWeight.w500),
            prefixIcon: Icon(icon, color: kPrimaryColor, size: 22),
            filled: true,
            fillColor: kSlate100,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: kPrimaryColor, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 18),
          ),
        ),
      ],
    );
  }

  Widget _selectField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w900,
            color: kSlate400,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: kSlate100,
            borderRadius: BorderRadius.circular(16),
          ),
          child: DropdownButtonFormField<String>(
            initialValue: _pessoa,
            items: pessoas
                .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                .toList(),
            onChanged: (v) => setState(() => _pessoa = v!),
            style: const TextStyle(
                fontWeight: FontWeight.w700, fontSize: 16, color: kSlate900),
            decoration: const InputDecoration(
              border: InputBorder.none,
              prefixIcon:
                  Icon(Icons.person_outline, color: kPrimaryColor, size: 22),
              prefixIconConstraints: BoxConstraints(minWidth: 48),
            ),
            dropdownColor: Colors.white,
            icon: const Icon(Icons.expand_more, color: kSlate400),
          ),
        ),
      ],
    );
  }
}
