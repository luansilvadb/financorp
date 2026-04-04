import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../../shared/constants.dart';
import '../../../../shared/models/domain.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/providers/app_providers.dart';

class AddExpenseSheet extends ConsumerStatefulWidget {
  final Despesa? expense;
  const AddExpenseSheet({super.key, this.expense});

  @override
  ConsumerState<AddExpenseSheet> createState() => _AddExpenseSheetState();
}

class _AddExpenseSheetState extends ConsumerState<AddExpenseSheet> {
  final _nomeCtrl = TextEditingController();
  final _valorCtrl = TextEditingController();
  final _vencCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.expense != null) {
      final exp = widget.expense!;
      _nomeCtrl.text = exp.nome;
      _valorCtrl.text = fmt(exp.valor).replaceAll(RegExp(r'R\$\s*'), '');
      _vencCtrl.text = exp.diaVencimento.toString();
    }
  }

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _valorCtrl.dispose();
    _vencCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.expense != null;

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
                    color: kPrimaryColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                      isEditing
                          ? Icons.edit
                          : Icons.add_circle,
                      color: kPrimaryColor,
                      size: 24),
                ),
                const SizedBox(width: 12),
                Text(
                  isEditing ? "Editar Despesa" : "Nova Despesa",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: kSlate900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _field("NOME DA CONTA", _nomeCtrl,
                Icons.format_align_left,
                placeholder: "Ex: Aluguel, Luz..."),
            const SizedBox(height: 20),
            _field(
              "VALOR TOTAL",
              _valorCtrl,
              Icons.attach_money,
              placeholder: "0,00",
              keyboardType: TextInputType.number,
              formatters: [BrlCurrencyInputFormatter()],
            ),
            const SizedBox(height: 20),
            _field(
              "DIA DO VENCIMENTO",
              _vencCtrl,
              Icons.calendar_today,
              placeholder: "Ex: 5",
              keyboardType: TextInputType.number,
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
                      final nome = _nomeCtrl.text.trim();
                      final valor = parseBrl(_valorCtrl.text);

                      if (nome.isEmpty || valor <= 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Preencha o nome e um valor válido"),
                            backgroundColor: kRed500,
                          ),
                        );
                        return;
                      }

                      final d = Despesa(
                        id: widget.expense?.id,
                        nome: nome,
                        diaVencimento: int.tryParse(_vencCtrl.text) ?? 5,
                        valor: valor,
                      );
                      ref.read(despesasProvider.notifier).addDespesa(d);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shadowColor: kPrimaryColor.withValues(alpha: 0.4),
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
                color: kSlate400.withValues(alpha: 0.6), fontWeight: FontWeight.w500),
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
}
