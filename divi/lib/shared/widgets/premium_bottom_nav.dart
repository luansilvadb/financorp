import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants.dart';

class PremiumNavItem {
  final IconData iconRegular;
  final IconData iconFill;
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
              child: Row(
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
            ),
          ),
        ),
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
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background pulsante autônomo (Fade/Scale Morph)
          AnimatedOpacity(
            opacity: isSelected ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            child: AnimatedScale(
              scale: isSelected ? 1.0 : 0.5, // Destransforma quando inativo
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutBack, // Leve spring no crescimento
              child: Container(
                width: 56,
                height: 52,
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
              ),
            ),
          ),

          // Ícone e Texto
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                scale: isSelected ? 1.2 : 1.0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                child: Icon(
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
        ],
      ),
    );
  }
}
