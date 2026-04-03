import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:divi/shared/constants.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FolderCard extends StatefulWidget {
  final String label;
  final String sublabel;
  final VoidCallback onTap;

  const FolderCard({
    super.key,
    required this.label,
    required this.sublabel,
    required this.onTap,
  });

  @override
  State<FolderCard> createState() => _FolderCardState();
}

class _FolderCardState extends State<FolderCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _isPressed ? 0.96 : 1.0,
      duration: const Duration(milliseconds: 100),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            HapticFeedback.mediumImpact();
            widget.onTap();
          },
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) => setState(() => _isPressed = false),
          onTapCancel: () => setState(() => _isPressed = false),
          borderRadius: BorderRadius.circular(20),
          highlightColor: kInk.withOpacity(0.05),
          splashColor: kInk.withOpacity(0.1),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: kLine, width: 1),
              boxShadow: _isPressed
                  ? []
                  : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon / Tab Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: kInk.withOpacity(0.05),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        LucideIcons.folder,
                        color: kInk,
                        size: 20,
                      ),
                    ),
                    Text(
                      widget.sublabel,
                      style: const TextStyle(
                        fontFamily: 'Space Mono',
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: kInkFaded,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const SizedBox(height: 12),
                Text(
                  widget.label.toUpperCase(),
                  style: const TextStyle(
                    fontFamily: 'Space Mono',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 2,
                    color: kInk,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  height: 2,
                  width: 24,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
