import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class PaperBackground extends StatelessWidget {
  const PaperBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: Opacity(
          opacity: 0.03,
          child: CustomPaint(
            painter: NoisePainter(),
          ),
        ),
      ),
    );
  }
}

class NoisePainter extends CustomPainter {
  final Random random = Random(42);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    // A somewhat dense scatter of small shapes to simulate noise/paper texture
    // Warning: drawing too many points can impact performance. We'll use a moderate amount.
    final pointCount =
        (size.width * size.height * 0.05).toInt().clamp(0, 15000);

    // Use drawPoints to draw a batch of random points at once
    List<Offset> points = [];
    for (int i = 0; i < pointCount; i++) {
      points.add(Offset(
        random.nextDouble() * size.width,
        random.nextDouble() * size.height,
      ));
    }

    paint.strokeWidth = 1.0;
    paint.strokeCap = StrokeCap.round;
    canvas.drawPoints(PointMode.points, points, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
