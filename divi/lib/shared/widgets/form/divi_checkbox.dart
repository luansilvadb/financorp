import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

/// A reusable checkbox component built on top of forui.dev's FCheckbox.
class DiviCheckbox extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String? errorText;
  final bool enabled;

  const DiviCheckbox({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.errorText,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        FCheckbox(
          value: value,
          onChange: enabled ? onChanged : null,
          label: Text(label),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 4),
          Text(
            errorText!,
            style: const TextStyle(color: Colors.red, fontSize: 12),
          ),
        ],
      ],
    );
  }
}
