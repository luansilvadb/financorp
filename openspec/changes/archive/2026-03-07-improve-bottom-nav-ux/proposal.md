# Proposal: Improve Bottom Navigation UX/UI

## Summary
Upgrade the application's bottom navigation bar to a "Premium FinTech" aesthetic, focusing on organic motion, refined glassmorphism, and improved interactive feedback.

## Motivation
The current bottom navigation bar, while functional and using a blur effect, lacks the high-end polish expected of a modern premium finance app. The goal is to make the navigation feel "alive" and tactile, enhancing the overall user experience for the household members.

## Goals
- Implement an organic "Gooey/Liquid" transition for the active tab indicator.
- Refine the Glassmorphism effect with better border treatments and subtle glows.
- Enhance interactive feedback with synchronized scale animations and Haptics.
- Improve visual hierarchy by making labels appear only on the selected tab (optional/to be decided in design).

## Non-Goals
- Changing the core navigation structure or adding/removing tabs.
- Implementing a completely new navigation pattern (like a side drawer).

## Impact
- **Affected Files**: `lib/main.dart` (where the BottomNav is currently located).
- **APIs**: No changes to backend APIs.
- **Dependencies**: No new dependencies, continuing to use `PhosphorIcons` and standard Flutter animation libraries.
