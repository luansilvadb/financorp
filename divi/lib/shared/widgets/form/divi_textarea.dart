import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

/// A reusable textarea/multiline input component built on top of forui.dev's FTextFormField.
class DiviTextarea extends StatelessWidget {
  final String label;
  final String? hintText;
  final String? errorText;
  final String? initialValue;
  final ValueChanged<String?>? onChanged;
  final bool enabled;
  final int maxLines;
  final String? Function(String?)? validator;

  const DiviTextarea({
    super.key,
    required this.label,
    this.hintText,
    this.errorText,
    this.initialValue,
    this.onChanged,
    this.enabled = true,
    this.maxLines = 5,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final initialValue = this.initialValue;

    return FTextFormField(
      label: Text(label),
      hint: hintText,
      enabled: enabled,
      maxLines: maxLines,
      expands: false,
      validator: errorText != null ? (_) => errorText : validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      control: initialValue != null
          ? FTextFieldControl.managed(
              initial: TextEditingValue(
                text: initialValue,
                selection: TextSelection.collapsed(offset: initialValue.length),
              ),
              onChange: (value) => onChanged?.call(value.text),
            )
          : FTextFieldControl.managed(
              onChange: (value) => onChanged?.call(value.text),
            ),
    );
  }
}
