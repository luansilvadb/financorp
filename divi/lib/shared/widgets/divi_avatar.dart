import 'package:flutter/material.dart';
import '../constants.dart';

class DiviAvatar extends StatelessWidget {
  final String pessoa;
  final double size;

  const DiviAvatar({
    super.key,
    required this.pessoa,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    final color = coresPessoa[pessoa] ?? kInkFaded;
    final initial = pessoa.isNotEmpty ? pessoa[0].toUpperCase() : '?';

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: size * 0.45,
          // Using a slightly more condensed or standard font to ensure initials fit well
        ),
      ),
    );
  }
}
