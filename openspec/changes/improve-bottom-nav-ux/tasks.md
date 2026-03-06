# Tasks: Improve Bottom Navigation UX/UI

## 1. Setup & Architecture
- [x] 1.1 Create `lib/shared/widgets/premium_bottom_nav.dart`.
- [x] 1.2 Define `PremiumNavItem` model for icons and labels.
- [x] 1.3 Implement basic `ConsumerWidget` structure for `PremiumBottomNav`.

## 2. Liquid/Gooey Indicator
- [x] 2.1 Implement `GooeyIndicator` using `AnimatedContainer` or `CustomPainter`.
- [x] 2.2 Synchronize indicator movement with the `currentIndex` and `duration: 350ms`.
- [x] 2.3 Apply `Curves.easeOutCirc` or equivalent for "Liquid" stretching effect.

## 3. Interactive UI Items
- [x] 3.1 Implement `PremiumNavItemWidget` with `AnimatedScale` (1.2x) and icon state switching (`regular` -> `fill`).
- [x] 3.2 Add `AnimatedOpacity` to labels (visible only when `selected == true`).
- [x] 3.3 Ensure `HapticFeedback.lightImpact()` on every tap.

## 4. Integration & Polish
- [x] 4.1 Replace the inline BottomNav in `lib/main.dart` with `PremiumBottomNav`.
- [x] 4.2 Fine-tune Glassmorphism parameters (`blur`, `opacity`, `border`).
- [x] 4.3 Verify layout on different screen sizes (SafeArea & padding).
