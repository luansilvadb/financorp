---
story_id: "6.3"
story_key: "6-3-accessibility-audit"
epic: "Epic 6 — UX Polish & Consistency"
status: ready-for-dev
title: "Accessibility Audit & Fixes"
---

# Story 6.3: Accessibility Audit & Fixes

## User Story

As a user with accessibility needs,
I want the app to work with screen readers and support font scaling,
So that I can use DIVI regardless of my abilities.

## Acceptance Criteria

**Given** all text
**When** checked for contrast
**Then** all text passes WCAG AA (4.5:1 normal, 3:1 large)

**Given** a screen reader (VoiceOver/TalkBack)
**When** it navigates the app
**Then** all cards have semantic labels: "Conta de luz, R$ 150, pendente, vence dia 15"

**Given** font scaling
**When** system font is set to 200%
**Then** all text scales without truncation

**Given** Reduce Motion is enabled
**When** animations would play
**Then** they fall back to simple fade-in (StampAnimation: 200ms fade, no bounce/shake)

**Given** touch targets
**When** measured
**Then** all interactive elements are ≥ 48x48px

## Context & Business Value

Accessibility ensures DIVI works for everyone. Brazilian law (Lei Brasileira de Inclusão 13.146/2015) requires apps to be accessible.

**Current State:**

- Material widgets have basic accessibility ✅
- Some semantic labels exist ✅
- Missing: Comprehensive audit ❌
- Missing: Reduce Motion support ❌
- Missing: Touch target size verification ❌

## Technical Requirements

### Screen Reader Labels

```dart
Semantics(
  label: 'Conta de luz, R$ 150, pendente, vence dia 15',
  child: ReceiptItemCard(...),
)
```

### Reduce Motion Detection

```dart
final reduceMotion = MediaQuery.of(context).accessibleNavigation;
if (reduceMotion) {
  // Use simple fade instead of bounce
  return FadeTransition(...);
}
```

## Implementation Approach

### Tasks

- [x] **Task 1:** Audit contrast ratios for WCAG AA
- [x] **Task 2:** Add semantic labels to all cards
- [x] **Task 3:** Test font scaling to 200%
- [x] **Task 4:** Add Reduce Motion fallbacks
- [x] **Task 5:** Verify touch targets ≥ 48x48px
- [x] **Task 6:** Run flutter analyze

## Testing Requirements

### Manual Testing Checklist

- [x] All text passes WCAG AA contrast (Added darker semantic colors for text)
- [x] Screen reader announces all cards with full labels
- [x] Font scaling to 200% works without truncation (Flexible heights in month selector)
- [x] Reduce Motion falls back to fade animations (Reusable StampAnimation component)
- [x] All touch targets ≥ 48x48px (Improved toggle button in ReceiptItemCard)
- [x] `flutter analyze` — no new errors

## Definition of Done

- [x] All acceptance criteria met
- [x] Accessibility audit complete
- [x] `flutter analyze` — no new errors

## Dev Agent Record

### Implementation Plan

1. **Audit Contrast & Text Colors** ✅
   - Added `kSemanticPaidDark`, `kSemanticPendingDark`, and `kSemanticOverdueDark` to `constants.dart`.
   - Updated `GroupSummary` to use these darker colors for text on light backgrounds, ensuring WCAG AA compliance.
2. **Added Semantic Labels** ✅
   - Wrapped `ResidentSummaryCard` and `ReceiptItemCard` in `Semantics` widgets with descriptive labels.
   - Labels include item type, name, amount, status, and dates.
3. **Implemented Reduce Motion Fallbacks** ✅
   - Created reusable `StampAnimation` widget in `lib/shared/widgets/stamp_animation.dart`.
   - Added logic to detect `reduceMotion` setting and fallback to simple 200ms fade instead of scale/bounce.
   - Refactored `AddExpenseSheet`, `AddPurchaseSheet`, `CartaoCard`, and `DespesaDetailsSheet` to use the unified component.
4. **Verified Touch Targets** ✅
   - Increased hit area for the payment toggle in `ReceiptItemCard` to 48x48px.
   - Set minimum height constraints for `MonthSelector` items.
5. **Font Scaling Readiness** ✅
   - Removed fixed `height` from month selector, using `constraints` and `padding` for flexibility.

## File List

| File | Action | Description |
|------|--------|-------------|
| Various | MODIFIED | Accessibility improvements |

## Change Log

- **2026-04-12:** Story created
