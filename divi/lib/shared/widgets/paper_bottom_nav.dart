import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../constants.dart';

class PaperBottomNav extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback onFabTap;

  const PaperBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onFabTap,
  });

  @override
  State<PaperBottomNav> createState() => _PaperBottomNavState();
}

class _PaperBottomNavState extends State<PaperBottomNav> {
  bool _isFabPressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.only(left: 32, right: 32, bottom: 24, top: 0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            kPaper.withOpacity(0),
            kPaper.withOpacity(0.9),
            kPaper,
          ],
          stops: const [0, 0.4, 1],
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          // Background "Tray" for the navigation items
          Container(
            height: 64,
            width: double.infinity,
            decoration: BoxDecoration(
              color: kInk,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildItem(
                  index: 0,
                  iconActive: LucideIcons.receipt,
                  iconInactive:
                      LucideIcons.receipt,
                  label: 'CONTAS',
                ),
                const SizedBox(width: 48), // Spacer for center FAB
                _buildItem(
                  index: 1,
                  iconActive: LucideIcons.folderOpen,
                  iconInactive:
                      LucideIcons.folderOpen,
                  label: 'HISTÓRICO',
                ),
              ],
            ),
          ),

          // Floating FAB with premium look and tactile sensation
          Positioned(
            bottom: 12,
            child: AnimatedScale(
              scale: _isFabPressed ? 0.9 : 1.0,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeOutCubic,
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: kInk, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: kPrimaryColor.withOpacity(0.3),
                      blurRadius: _isFabPressed ? 10 : 20,
                      offset: _isFabPressed
                          ? const Offset(0, 4)
                          : const Offset(0, 8),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTapDown: (_) => setState(() => _isFabPressed = true),
                    onTapUp: (_) => setState(() => _isFabPressed = false),
                    onTapCancel: () => setState(() => _isFabPressed = false),
                    onTap: () {
                      HapticFeedback.heavyImpact();
                      widget.onFabTap();
                    },
                    customBorder: const CircleBorder(),
                    splashColor: Colors.white.withOpacity(0.3),
                    highlightColor: Colors.white.withOpacity(0.1),
                    child: const Center(
                      child: Icon(Icons.add_rounded,
                          color: Colors.white, size: 40),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem({
    required int index,
    required IconData iconActive,
    required IconData iconInactive,
    required String label,
  }) {
    final isActive = widget.currentIndex == index;
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        widget.onTap(index);
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isActive ? iconActive : iconInactive,
              color: isActive ? kPaper : kPaper.withOpacity(0.4),
              size: 24,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Space Mono',
                fontSize: 8,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                letterSpacing: 1.0,
                color: isActive ? kPaper : kPaper.withOpacity(0.4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
