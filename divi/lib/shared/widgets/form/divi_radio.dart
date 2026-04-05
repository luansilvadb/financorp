import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../constants.dart';

/// A reusable radio button component using forui.dev's FRadio.
class DiviRadio extends StatelessWidget {
  final String label;
  final String value;
  final String groupValue;
  final ValueChanged<String?> onChanged;
  final bool enabled;

  const DiviRadio({
    super.key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    
    return FRadio(
      label: Text(label),
      value: isSelected,
      enabled: enabled,
      onChange: (selected) {
        if (selected && enabled) {
          onChanged(value);
        }
      },
    );
  }
}

/// A reusable radio group component for managing multiple radio buttons
/// using forui.dev's FRadio components.
class DiviRadioGroup extends StatelessWidget {
  final String label;
  final List<String> options;
  final String value;
  final ValueChanged<String?> onChanged;
  final String? errorText;
  final bool enabled;

  const DiviRadioGroup({
    super.key,
    required this.label,
    required this.options,
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
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Space Mono',
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: kInk,
          ),
        ),
        const SizedBox(height: 8),
        ...options.map((option) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: DiviRadio(
                label: option,
                value: option,
                groupValue: value,
                onChanged: onChanged,
                enabled: enabled,
              ),
            )),
        if (errorText != null) ...[
          const SizedBox(height: 4),
          Text(
            errorText!,
            style: const TextStyle(
              fontFamily: 'Space Mono',
              color: kPrimaryColor,
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
  }
}
