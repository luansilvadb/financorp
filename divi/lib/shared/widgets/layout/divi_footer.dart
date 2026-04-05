import 'package:flutter/material.dart';

/// A reusable footer component.
class DiviFooter extends StatelessWidget {
  final String text;
  final List<Widget>? actions;
  final Color? backgroundColor;

  const DiviFooter({
    super.key,
    required this.text,
    this.actions,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: backgroundColor ?? Theme.of(context).cardColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text),
          if (actions != null) ...[
            Row(children: actions!),
          ],
        ],
      ),
    );
  }
}
