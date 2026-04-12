import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants.dart';

class StampAnimation extends StatelessWidget {
  final bool isPaid;
  final VoidCallback? onComplete;

  const StampAnimation({
    super.key,
    this.isPaid = true,
    this.onComplete,
  });

  static Future<void> show(BuildContext context, {bool isPaid = true}) async {
    // Trigger haptic feedback
    HapticFeedback.mediumImpact();

    // Show the dialog
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (ctx) {
        // Auto-close after 800ms
        Future.delayed(const Duration(milliseconds: 800), () {
          if (ctx.mounted && Navigator.of(ctx).canPop()) Navigator.of(ctx).pop();
        });

        return Center(
          child: StampAnimation(isPaid: isPaid),
        );
      },
    );

    // Wait for the dialog to auto-close
    await Future.delayed(const Duration(milliseconds: 900));
  }

  @override
  Widget build(BuildContext context) {
    // Check for reduce motion
    final reduceMotion = MediaQuery.of(context).accessibleNavigation || 
                         View.of(context).platformDispatcher.accessibilityFeatures.reduceMotion;

    final color = isPaid ? kSemanticPaid : kSemanticPending;
    final icon = isPaid ? Icons.check : Icons.undo;

    if (reduceMotion) {
      // Fallback: Simple fade-in
      return TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 200),
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: _buildContainer(color, icon),
          );
        },
      );
    }

    // Default: Scale + Bounce
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: _buildContainer(color, icon),
        );
      },
    );
  }

  Widget _buildContainer(Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.9),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Icon(icon, color: Colors.white, size: 48),
    );
  }
}
