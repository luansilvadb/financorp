import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../constants.dart';

class PremiumNavItem {
  final PhosphorIconData iconRegular;
  final PhosphorIconData iconFill;
  final String label;

  const PremiumNavItem({
    required this.iconRegular,
    required this.iconFill,
    required this.label,
  });
}

class PremiumBottomNav extends ConsumerWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<PremiumNavItem> items;

  const PremiumBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              height: 72,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                  color: kPrimaryColor.withOpacity(0.1),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: LayoutBuilder(builder: (context, constraints) {
                final width = constraints.maxWidth;
                final itemWidth = width / items.length;

                return Stack(
                  children: [
                    // Gooey Indicator
                    _GooeyIndicator(
                      currentIndex: currentIndex,
                      itemWidth: itemWidth,
                    ),
                    // Navigation Buttons
                    Row(
                      children: List.generate(items.length, (index) {
                        return Expanded(
                          child: _PremiumNavItemWidget(
                            index: index,
                            isSelected: currentIndex == index,
                            item: items[index],
                            onTap: () {
                              HapticFeedback.lightImpact();
                              onTap(index);
                            },
                          ),
                        );
                      }),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _GooeyIndicator extends StatefulWidget {
  final int currentIndex;
  final double itemWidth;

  const _GooeyIndicator({
    required this.currentIndex,
    required this.itemWidth,
  });

  @override
  State<_GooeyIndicator> createState() => _GooeyIndicatorState();
}

class _GooeyIndicatorState extends State<_GooeyIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;
  int _lastIndex = 0;

  @override
  void initState() {
    super.initState();
    _lastIndex = widget.currentIndex;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _widthAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 56.0, end: 90.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 90.0, end: 56.0)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
    ]).animate(_controller);
  }

  @override
  void didUpdateWidget(_GooeyIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentIndex != _lastIndex) {
      _controller.forward(from: 0);
      _lastIndex = widget.currentIndex;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const baseWidth = 56.0;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
      left: widget.currentIndex * widget.itemWidth +
          (widget.itemWidth - baseWidth) / 2 -
          (_widthAnimation.value - baseWidth) / 2,
      top: 10,
      bottom: 10,
      child: AnimatedBuilder(
        animation: _widthAnimation,
        builder: (context, child) {
          return Container(
            width: _widthAnimation.value,
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: kPrimaryColor.withOpacity(0.12),
                  blurRadius: 12,
                  spreadRadius: -2,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _PremiumNavItemWidget extends StatelessWidget {
  final int index;
  final bool isSelected;
  final PremiumNavItem item;
  final VoidCallback onTap;

  const _PremiumNavItemWidget({
    required this.index,
    required this.isSelected,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedScale(
            scale: isSelected ? 1.2 : 1.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            child: PhosphorIcon(
              isSelected ? item.iconFill : item.iconRegular,
              color: isSelected ? kPrimaryColor : kSlate400,
              size: 26,
            ),
          ),
          const SizedBox(height: 2),
          AnimatedOpacity(
            opacity: isSelected ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: isSelected ? 14 : 0,
              child: Text(
                item.label.toUpperCase(),
                style: const TextStyle(
                  fontSize: 10,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
