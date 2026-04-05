import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

/// A reusable select/dropdown component using forui.dev primitives.
class DiviSelect extends StatelessWidget {
  final String label;
  final List<String> options;
  final String? hint;
  final String? errorText;
  final String? initialValue;
  final ValueChanged<String?>? onChanged;
  final bool enabled;
  final String? Function(String?)? validator;

  const DiviSelect({
    super.key,
    required this.label,
    required this.options,
    this.hint,
    this.errorText,
    this.initialValue,
    this.onChanged,
    this.enabled = true,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return FTextFormField(
      label: Text(label),
      hint: hint ?? 'Select an option',
      enabled: enabled,
      readOnly: true,
      onTap: () {
        // Show dropdown dialog
        showDialog<String>(
          context: context,
          builder: (context) => SimpleDialog(
            title: Text(label),
            children: options.map((option) {
              return SimpleDialogOption(
                onPressed: () {
                  onChanged?.call(option);
                  Navigator.pop(context, option);
                },
                child: Text(option),
              );
            }).toList(),
          ),
        );
      },
      validator: validator,
      control: initialValue != null
          ? FTextFieldControl.managed(
              initial: TextEditingValue(
                text: initialValue!,
                selection: TextSelection.collapsed(offset: initialValue!.length),
              ),
            )
          : const FTextFieldControl.managed(),
    );
  }
}
