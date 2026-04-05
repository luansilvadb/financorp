import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

/// A reusable input field component built on top of forui.dev's FTextFormField.
/// 
/// This component provides a consistent interface for text input across the
/// application with support for labels, error messages, and various input types.
class DiviInput extends StatelessWidget {
  /// The label displayed above the input field.
  final String label;
  
  /// Optional hint text displayed when the input is empty.
  final String? hintText;
  
  /// Optional error text displayed below the input.
  final String? errorText;
  
  /// Optional initial value for the input field.
  final String? initialValue;
  
  /// Callback triggered when the text changes.
  final ValueChanged<String?>? onChanged;
  
  /// Whether the input text should be obscured (for passwords).
  final bool obscureText;
  
  /// The type of keyboard to use for text input.
  final TextInputType? keyboardType;
  
  /// Whether the input is enabled and interactive.
  final bool enabled;
  
  /// Optional validator for form validation.
  final String? Function(String?)? validator;
  
  /// Optional focus node for the text field.
  final FocusNode? focusNode;

  const DiviInput({
    super.key,
    required this.label,
    this.hintText,
    this.errorText,
    this.initialValue,
    this.onChanged,
    this.obscureText = false,
    this.keyboardType,
    this.enabled = true,
    this.validator,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final initialValue = this.initialValue;
    
    return FTextFormField(
      label: Text(label),
      hint: hintText,
      enabled: enabled,
      focusNode: focusNode,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: errorText != null ? (_) => errorText : validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      control: onChanged != null
          ? initialValue != null
              ? FTextFieldControl.managed(
                  initial: TextEditingValue(
                    text: initialValue, 
                    selection: TextSelection.collapsed(offset: initialValue.length)
                  ),
                  onChange: (value) => onChanged!(value.text),
                )
              : FTextFieldControl.managed(
                  onChange: (value) => onChanged!(value.text),
                )
          : initialValue != null
              ? FTextFieldControl.managed(
                  initial: TextEditingValue(
                    text: initialValue, 
                    selection: TextSelection.collapsed(offset: initialValue.length)
                  ),
                )
              : const FTextFieldControl.managed(),
    );
  }
}
