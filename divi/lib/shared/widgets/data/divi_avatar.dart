import 'package:flutter/material.dart';

/// A reusable avatar component.
class DiviAvatar extends StatelessWidget {
  final String label;
  final String? imageUrl;
  final double radius;
  final Color? backgroundColor;

  const DiviAvatar({
    super.key,
    required this.label,
    this.imageUrl,
    this.radius = 20,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
      backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
      child: imageUrl == null
          ? Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: radius * 0.6,
                fontWeight: FontWeight.bold,
              ),
            )
          : null,
    );
  }
}
