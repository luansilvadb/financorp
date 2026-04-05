import 'package:flutter/material.dart';

/// A reusable card component with forui-compatible styling.
class DiviCard extends StatelessWidget {
  final Widget child;
  final double? elevation;
  final EdgeInsetsGeometry? margin;
  final Color? color;

  const DiviCard({
    super.key,
    required this.child,
    this.elevation,
    this.margin,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation ?? 2,
      margin: margin ?? const EdgeInsets.all(8),
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}
