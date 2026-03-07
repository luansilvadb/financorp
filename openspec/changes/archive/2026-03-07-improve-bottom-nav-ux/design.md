# Design: Improve Bottom Navigation UX/UI

## Context
The current bottom navigation in `main.dart` uses a `Stack` with an `AnimatedPositioned` rectangle as a "Glide Indicator". It provides basic visual feedback but feels linear and lacks the organic feel of modern premium interfaces.

## Goals / Non-Goals
- **Goal**: Implement a "Gooey" indicator that deforms during transitions.
- **Goal**: Re-architect the `PremiumBottomNav` into a standalone widget.
- **Goal**: Enhance Glassmorphism with better contrast and subtle glows.
- **Non-Goal**: Change any business logic related to the active index.

## Design Decisions
1. **Standalone Widget**: Extract the BottomNav from `main.dart` to `lib/shared/widgets/premium_bottom_nav.dart`.
2. **Organic Indicator**: 
   - Replace the simple `AnimatedPositioned` with a `CustomPainter` or a complex `Stack` of `AnimatedContainer` widgets.
   - Use a `TweenSequence` or `Curves.elasticOut` for the "Squash & Stretch" effect.
3. **Adaptive Labels**: Implement "Expandable Bottom Bar" behavior—the label only shows for the active item to reduce visual clutter.
4. **Visual Aesthetics**:
   - Background: `Blur(sigma: 20)` + `Color.withOpacity(0.7)`.
   - Active Indicator: Subtle gradient + `InnerShadow` (if available via `BoxShadow` tricks).
   - Icons: Transition from `regular` (unselected) to `fill` (selected) with an `AnimatedScale`.

## Proposed Changes
### `lib/shared/widgets/premium_bottom_nav.dart` (New File)
- Define `PremiumBottomNav` as a `ConsumerWidget`.
- Props: `int currentIndex`, `Function(int) onTap`, `List<PremiumNavItem> items`.
- **Anatomy**:
  - `ClipRRect` for the bar's rounded corners.
  - `BackdropFilter` for the blur.
  - `Stack` containing:
    - The "Gooey" indicator that follows the index.
    - A `Row` of interactive items.

## Risks / Trade-offs
- **Complexity**: Gooey effects can be tricky to synchronize perfectly with user taps.
- **Performance**: Excessive blurs and complex painters could drop frames on older budget Android devices; we will keep `sigma` values reasonable and use `RepaintBoundary`.
