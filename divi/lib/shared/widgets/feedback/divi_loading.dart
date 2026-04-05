import 'package:flutter/material.dart';

/// A reusable loading indicator component.
class DiviLoading extends StatelessWidget {
  final String? message;
  final double? size;
  final bool isOverlay;

  const DiviLoading({
    super.key,
    this.message,
    this.size,
    this.isOverlay = false,
  });

  const DiviLoading.overlay({
    super.key,
    this.message,
    this.size,
  }) : isOverlay = true;

  @override
  Widget build(BuildContext context) {
    final widget = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularProgressIndicator(strokeWidth: size ?? 4),
        if (message != null) ...[
          const SizedBox(height: 16),
          Text(message!),
        ],
      ],
    );

    if (isOverlay) {
      return Container(
        color: Colors.black54,
        child: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: widget,
            ),
          ),
        ),
      );
    }

    return Center(child: widget);
  }
}
