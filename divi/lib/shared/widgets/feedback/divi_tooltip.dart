import 'package:flutter/material.dart';

/// A reusable tooltip component.
class DiviTooltip extends StatelessWidget {
  final String message;
  final Widget child;
  final Duration? waitDuration;

  const DiviTooltip({
    super.key,
    required this.message,
    required this.child,
    this.waitDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      waitDuration: waitDuration ?? const Duration(milliseconds: 500),
      child: child,
    );
  }
}
