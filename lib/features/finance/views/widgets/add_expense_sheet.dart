import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:divi/shared/constants.dart';
import 'package:divi/shared/models/domain.dart';
import 'package:divi/core/utils/formatters.dart';
import 'package:divi/core/providers/app_providers.dart';
import 'package:divi/shared/widgets/divi_toasts.dart';
import 'package:divi/shared/widgets/stamp_animation.dart';

/// Bottom sheet form for adding a new fixed expense.
///
/// UX-DR7 (Bottom Sheet First), UX-DR10 (Silent Errors), UX-DR4 (Stamp Animation)
class AddExpenseSheet extends ConsumerStatefulWidget {
  final Despesa? expense;

  const AddExpenseSheet({super.key, this.expense});

  @override
  ConsumerState<AddExpenseSheet> createState() => _AddExpenseSheetState();
}

class _AddExpenseSheetState extends ConsumerState<AddExpenseSheet> {
  final _nomeCtrl = TextEditingController();
  final _valorCtrl = TextEditingController();
  final _diaCtrl = TextEditingController();

  final Map<String, String> _errors = {};
  Timer? _validationTimer;
  bool _hasTyped = false;
  double? _parsedValor;

  @override
  void initState() {
    super.initState();
    if (widget.expense != null) {
      _nomeCtrl.text = widget.expense!.nome;
      _valorCtrl.text = formatBrl(widget.expense!.valor);
      _diaCtrl.text = widget.expense!.diaVencimento.toString();
      _parsedValor = widget.expense!.valor;
    }
  }

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _valorCtrl.dispose();
    _diaCtrl.dispose();
    _validationTimer?.cancel();
    super.dispose();
  }

  void _onValueChanged(String text) {
    _hasTyped = true;
    _parsedValor = parseBrl(text);
    setState(() {});

    // Debounced validation
    _validationTimer?.cancel();
    _validationTimer = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        _validate();
      }
    });
  }

  void _onDiaChanged(String text) {
    _hasTyped = true;
    setState(() {}); // Immediate update for button state

    _validationTimer?.cancel();
    _validationTimer = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        _validate();
      }
    });
  }

  void _validate() {
    final newErrors = <String, String>{};

    if (_nomeCtrl.text.trim().isEmpty) {
      newErrors['nome'] = 'Nome é obrigatório';
    }
    if (_parsedValor == null || _parsedValor! <= 0) {
      newErrors['valor'] = 'Valor deve ser maior que zero';
    }
    final diaText = _diaCtrl.text.replaceAll(RegExp(r'\D'), '');
    final dia = int.tryParse(diaText);
    if (dia == null || dia < 1 || dia > 31) {
      newErrors['dia'] = 'Dia deve ser entre 1 e 31';
    }

    setState(() {
      _errors.clear();
      _errors.addAll(newErrors);
    });
  }

  bool get _isValid {
    final diaText = _diaCtrl.text.replaceAll(RegExp(r'\D'), '');
    final dia = int.tryParse(diaText) ?? 0;
    return _nomeCtrl.text.trim().isNotEmpty &&
        (_parsedValor ?? 0) > 0 &&
        dia >= 1 &&
        dia <= 31;
  }

  Future<void> _submit() async {
    _validate();
    if (!_isValid) return;

    if (widget.expense != null) {
      // Edit mode
      final updated = widget.expense!.copyWith(
        nome: _nomeCtrl.text.trim(),
        diaVencimento: int.parse(_diaCtrl.text.replaceAll(RegExp(r'\D'), '')),
        valor: _parsedValor!,
      );
      try {
        await ref.read(despesasProvider.notifier).updateDespesa(updated);
        if (!mounted) return;
        final nav = Navigator.of(context);
        await StampAnimation.show(context);
        if (!mounted) return;
        nav.pop();
      } catch (e) {
        if (!mounted) return;
        DiviToasts.show(
          context,
          "Não foi possível salvar. Tente novamente.",
          isError: true,
        );
      }
    } else {
      // Create mode
      final newDespesa = Despesa(
        id: null,
        nome: _nomeCtrl.text.trim(),
        diaVencimento: int.parse(_diaCtrl.text.replaceAll(RegExp(r'\D'), '')),
        valor: _parsedValor!,
      );

      try {
        await ref.read(despesasProvider.notifier).addDespesa(newDespesa);

        // Simple stamp animation inline
        if (!mounted) return;
        final nav = Navigator.of(context);
        await StampAnimation.show(context);
        if (!mounted) return;
        nav.pop();
      } catch (e) {
        if (!mounted) return;
        DiviToasts.show(
          context,
          "Não foi possível salvar. Tente novamente.",
          isError: true,
        );
      }
    }
  }

  void _confirmDismiss() {
    if (_hasTyped && !_isValid) {
      showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: kSurfacePaper,
          title: const Text(
            "Dados não salvos",
            style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, color: kTextPrimary),
          ),
          content: const Text(
            "Tem dados que ainda não foram salvos. Fechar mesmo assim?",
            style: TextStyle(fontFamily: 'Inter', color: kTextSecondary),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Cancelar", style: TextStyle(color: kTextPrimary)),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.pop(context);
              },
              child: const Text("Fechar mesmo"),
            ),
          ],
        ),
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final previewText = _parsedValor != null && _parsedValor! > 0
        ? "${fmt(_parsedValor!)} ÷ 3 = ${fmt(_parsedValor! / 3)}/cada"
        : null;

    return GestureDetector(
      onTap: _confirmDismiss,
      child: Container(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () {}, // block tap-through
          child: DraggableScrollableSheet(
            initialChildSize: 0.6,
            maxChildSize: 0.85,
            minChildSize: 0.6,
            builder: (ctx, scrollCtrl) {
              return Material(
                type: MaterialType.transparency,
                child: Container(
                decoration: const BoxDecoration(
                  color: kSurfacePaper,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    // Handle bar
                    Center(
                      child: Container(
                        width: 36,
                        height: 4,
                        margin: const EdgeInsets.only(top: 12, bottom: 16),
                        decoration: BoxDecoration(
                          color: kPaperDepth,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),

                    // Title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        children: [
                          const Text(
                            "NOVA DESPESA FIXA",
                            style: TextStyle(
                              fontFamily: 'Space Mono',
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                              color: kTextSecondary,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(
                              Icons.close,
                              size: 20,
                              color: kTextSecondary,
                            ),
                            onPressed: _confirmDismiss,
                          ),
                        ],
                      ),
                    ),

                    // Form
                    Expanded(
                      child: ListView(
                        controller: scrollCtrl,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        children: [
                          const SizedBox(height: 16),

                          // Nome field
                          _buildField(
                            label: "NOME DA DESPESA",
                            controller: _nomeCtrl,
                            placeholder: "Ex: Aluguel, Conta de Luz...",
                            error: _errors['nome'],
                          ),
                          const SizedBox(height: 24),

                          // Valor field
                          _buildField(
                            label: "VALOR TOTAL",
                            controller: _valorCtrl,
                            placeholder: "0,00",
                            keyboardType: TextInputType.number,
                            formatters: [BrlCurrencyInputFormatter()],
                            error: _errors['valor'],
                            onChanged: _onValueChanged,
                          ),
                          const SizedBox(height: 24),

                          // Dia vencimento
                          _buildField(
                            label: "DIA DE VENCIMENTO",
                            controller: _diaCtrl,
                            placeholder: "Ex: 15",
                            keyboardType: TextInputType.number,
                            error: _errors['dia'],
                            onChanged: _onDiaChanged,
                          ),
                          const SizedBox(height: 32),

                          // Real-time preview
                          if (previewText != null)
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: kPaperDepth,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                previewText,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontFamily: 'Space Mono',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: kTextPrimary,
                                ),
                              ),
                            ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),

                    // Save button
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                        child: FilledButton(
                          onPressed: _isValid ? _submit : null,
                          style: FilledButton.styleFrom(
                            minimumSize: const Size(double.infinity, 56),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "SALVAR DESPESA",
                            style: TextStyle(
                              fontFamily: 'Space Mono',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required String placeholder,
    String? error,
    TextInputType? keyboardType,
    List<TextInputFormatter>? formatters,
    void Function(String)? onChanged,
  }) {
    final hasError = error != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Space Mono',
            fontSize: 12,
            color: kTextSecondary,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: formatters,
          onChanged: onChanged,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: kTextPrimary,
          ),
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: TextStyle(
              color: kTextSecondary.withValues(alpha: 0.2),
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: hasError
                    ? kSemanticOverdue.withValues(alpha: 0.6)
                    : kPaperDepth,
                width: hasError ? 2 : 1,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: hasError ? kSemanticOverdue : kPrimaryOlive,
                width: 2,
              ),
            ),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              children: [
                const Icon(
                  Icons.warning_amber_rounded,
                  size: 14,
                  color: kSemanticOverdue,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    error,
                    style: const TextStyle(
                      fontSize: 12,
                      color: kSemanticOverdue,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
