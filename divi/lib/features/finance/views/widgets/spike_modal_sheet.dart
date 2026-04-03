import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:divi/shared/constants.dart';
import 'package:divi/shared/models/domain.dart';
import 'package:divi/shared/models/domain.dart';
import 'package:divi/core/utils/formatters.dart';
import 'package:divi/core/providers/app_providers.dart';
import 'package:divi/core/providers/app_providers.dart';
import 'package:divi/shared/providers/month_year_provider.dart';
import 'package:divi/shared/widgets/divi_toasts.dart';

class SpikeModalSheet extends ConsumerStatefulWidget {
  final Despesa? despesa;
  final CompraCartao? compra;

  const SpikeModalSheet({
    super.key,
    this.despesa,
    this.compra,
  });

  @override
  ConsumerState<SpikeModalSheet> createState() => _SpikeModalSheetState();
}

enum _SpikeMode { fixedBill, creditCard }

class _SpikeModalSheetState extends ConsumerState<SpikeModalSheet> {
  _SpikeMode _mode = _SpikeMode.fixedBill;

  // Controllers for both
  final _titleCtrl = TextEditingController();
  final _valueCtrl = TextEditingController();

  // Controller for fixed
  final _dayCtrl = TextEditingController();

  // Selection for credit
  String _pessoa = "Luciana";

  @override
  void initState() {
    super.initState();
    if (widget.despesa != null) {
      _mode = _SpikeMode.fixedBill;
      _titleCtrl.text = widget.despesa!.nome;
      _valueCtrl.text = formatBrl(widget.despesa!.valor);
      _dayCtrl.text = widget.despesa!.diaVencimento.toString();
    } else if (widget.compra != null) {
      _mode = _SpikeMode.creditCard;
      _titleCtrl.text = widget.compra!.descricao;
      _valueCtrl.text = formatBrl(widget.compra!.valor);
      _pessoa = widget.compra!.pessoa;
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _valueCtrl.dispose();
    _dayCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    final title = _titleCtrl.text.trim();
    final value = parseBrl(_valueCtrl.text);

    if (title.isEmpty || value <= 0) {
      DiviToasts.show(
        context,
        "PREENCHA O TÍTULO E VALOR",
        isError: true,
      );
      return;
    }

    if (_mode == _SpikeMode.fixedBill) {
      final d = Despesa(
        id: widget.despesa?.id,
        nome: title,
        diaVencimento: int.tryParse(_dayCtrl.text) ?? 5,
        valor: value,
      );
      if (widget.despesa != null) {
        ref.read(despesasProvider.notifier).updateDespesa(d);
      } else {
        ref.read(despesasProvider.notifier).addDespesa(d);
      }
    } else {
      final period = ref.read(periodProvider);
      final c = CompraCartao(
        id: widget.compra?.id,
        data: widget.compra?.data ??
            DateTime.now().toIso8601String().split('T')[0],
        descricao: title,
        valor: value,
        pessoa: _pessoa,
        mes: widget.compra?.mes ?? period.mes,
        ano: widget.compra?.ano ?? period.ano,
        pago: widget.compra?.pago ?? false,
      );
      if (widget.compra != null) {
        ref.read(cartaoProvider.notifier).updateCompra(c);
      } else {
        ref.read(cartaoProvider.notifier).addCompra(c);
      }
    }

    // Animate down
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      decoration: BoxDecoration(
        color: kPaper,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Top Drag Handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(top: 12, bottom: 24),
                decoration: BoxDecoration(
                  color: kInkFaded.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // Segmented Toggle
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 32),
              child: _buildSegmentedControl(),
            ),

            // Form fields
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  _buildTextField("DESCRICÃO", _titleCtrl,
                      placeholder: _mode == _SpikeMode.fixedBill
                          ? "Ex: Aluguel"
                          : "Ex: Mercado"),
                  const SizedBox(height: 32),
                  _buildTextField("VALOR", _valueCtrl,
                      placeholder: "0,00",
                      keyboardType: TextInputType.number,
                      formatters: [BrlCurrencyInputFormatter()]),
                  const SizedBox(height: 32),
                  if (_mode == _SpikeMode.fixedBill)
                    _buildTextField("DIA VENCIMENTO", _dayCtrl,
                        placeholder: "Ex: 5",
                        keyboardType: TextInputType.number)
                  else
                    _buildRadioGroup(
                        "QUEM DEVE?", ["Luan", "Luciana", "Giovanna"]),
                  const SizedBox(height: 40),
                ],
              ),
            ),

            // Print action
            Padding(
              padding: EdgeInsets.only(
                  left: 24,
                  right: 24,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 16),
              child: Material(
                color: kInk,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  onTap: _submit,
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      widget.despesa != null || widget.compra != null
                          ? "ATUALIZAR REGISTRO"
                          : "LANÇAR",
                      style: const TextStyle(
                        fontFamily: 'Space Mono',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        color: kPaper,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSegmentedControl() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: kLine.withOpacity(0.2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
              child: _buildSegmentOption("CONTAS FIXAS", _SpikeMode.fixedBill)),
          Expanded(child: _buildSegmentOption("CARTÃO", _SpikeMode.creditCard)),
        ],
      ),
    );
  }

  Widget _buildSegmentOption(String label, _SpikeMode sMode) {
    final isSelected = _mode == sMode;
    return GestureDetector(
      onTap: () => setState(() => _mode = sMode),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? kInk : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: kInk.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Space Mono',
            color: isSelected ? kPaper : kInk,
            fontWeight: FontWeight.bold,
            fontSize: 12,
            letterSpacing: 1.0,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {String? placeholder,
      TextInputType? keyboardType,
      List<TextInputFormatter>? formatters}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Space Mono',
            fontSize: 12,
            color: kInkFaded,
            letterSpacing: 1.5,
          ),
        ),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: formatters,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: kInk,
          ),
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: TextStyle(
              color: kInkFaded.withOpacity(0.2),
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: kLine, width: 1),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: kInk, width: 2),
            ),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildRadioGroup(String label, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Space Mono',
            fontSize: 12,
            color: kInkFaded,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 12),
        ...options.map((opt) => InkWell(
              onTap: () => setState(() => _pessoa = opt),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Icon(
                      _pessoa == opt
                          ? PhosphorIcons.circle(PhosphorIconsStyle.fill)
                          : PhosphorIcons.circle(PhosphorIconsStyle.regular),
                      size: 20,
                      color: kInk,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      opt,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: kInk,
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
