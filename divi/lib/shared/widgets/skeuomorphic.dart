import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import '../constants.dart';

/// App-wide dashed divider for receipts
class DashedDivider extends StatelessWidget {
  final Color color;
  const DashedDivider({super.key, this.color = kLine});

  @override
  Widget build(BuildContext context) {
    return DottedLine(
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      lineLength: double.infinity,
      lineThickness: 1.0,
      dashLength: 6.0,
      dashColor: color,
      dashRadius: 0.0,
      dashGapLength: 4.0,
      dashGapColor: Colors.transparent,
      dashGapRadius: 0.0,
    );
  }
}

/// A hole punch visual for the side of cards
class HolePunch extends StatelessWidget {
  const HolePunch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: kPaper,
        shape: BoxShape.circle,
        border: Border.all(color: kLine, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(1, 1),
          ),
        ],
      ),
    );
  }
}

/// Creates jagged edges at the top and/or bottom.
class ReceiptClipper extends CustomClipper<Path> {
  final bool jaggedTop;
  final bool jaggedBottom;
  final double toothSize;

  ReceiptClipper({
    this.jaggedTop = true,
    this.jaggedBottom = true,
    this.toothSize = 6.0,
  });

  @override
  Path getClip(Size size) {
    var path = Path();

    // Top Edge
    if (jaggedTop) {
      path.moveTo(0, toothSize);
      int teeth = (size.width / (toothSize * 2)).ceil();
      for (int i = 0; i < teeth; i++) {
        double x1 = (i * 2 + 1) * toothSize;
        double x2 = (i * 2 + 2) * toothSize;
        path.lineTo(x1, 0);
        path.lineTo(x2, toothSize);
      }
      path.lineTo(size.width, toothSize); // Ensure we hit the corner
    } else {
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
    }

    // Right Edge
    path.lineTo(size.width, size.height - (jaggedBottom ? toothSize : 0));

    // Bottom Edge
    if (jaggedBottom) {
      int teeth = (size.width / (toothSize * 2)).ceil();
      for (int i = teeth - 1; i >= 0; i--) {
        double x1 = (i * 2 + 1) * toothSize;
        double x2 = (i * 2) * toothSize;
        path.lineTo(x1, size.height);
        path.lineTo(x2, size.height - toothSize);
      }
      path.lineTo(0, size.height - toothSize);
    } else {
      path.lineTo(0, size.height);
    }

    // Left Edge
    path.lineTo(0, jaggedTop ? toothSize : 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) =>
      false; // Could be improved by checking properties
}

/// Creates a folder tab at the top-left using curves, simulating a Physical Folder.
class FolderClipper extends CustomClipper<Path> {
  final double tabWidth;
  final double tabHeight;
  final double cornerRadius;

  FolderClipper({
    this.tabWidth = 140.0,
    this.tabHeight = 32.0,
    this.cornerRadius = 8.0,
  });

  @override
  Path getClip(Size size) {
    final path = Path();
    final double tabRight = 20.0 + 8.0 + tabWidth;
    const double slopeWidth = 12.0;

    // Start at top-left of the main body
    path.moveTo(0, tabHeight + cornerRadius);
    path.quadraticBezierTo(0, tabHeight, cornerRadius, tabHeight);

    // Minor indent to start the tab
    path.lineTo(20, tabHeight);

    // Left slope of the tab
    path.lineTo(20 + slopeWidth, 0);

    // Top edge of the tab
    path.lineTo(tabRight, 0);

    // Right slope of the tab
    path.lineTo(tabRight + slopeWidth, tabHeight);

    // Top edge of the main body across to the right
    path.lineTo(size.width - cornerRadius, tabHeight);
    path.quadraticBezierTo(
        size.width, tabHeight, size.width, tabHeight + cornerRadius);

    // Right Edge
    path.lineTo(size.width, size.height - cornerRadius);
    path.quadraticBezierTo(
        size.width, size.height, size.width - cornerRadius, size.height);

    // Bottom Edge
    path.lineTo(cornerRadius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - cornerRadius);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
