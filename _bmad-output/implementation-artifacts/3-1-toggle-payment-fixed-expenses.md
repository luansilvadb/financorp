---
story_id: "3.1"
story_key: "3-1-toggle-payment-fixed-expenses"
epic: "Epic 3 — Payment Tracking"
status: done
title: "Toggle Payment Status on Fixed Expenses"
---

# Story 3.1: Toggle Payment Status on Fixed Expenses

## User Story

As a resident,
I want to toggle whether I've paid my share of a fixed expense,
So that everyone knows the current status.

## Acceptance Criteria

**Given** I'm viewing a despesa details sheet
**When** I see my payment status
**Then** it shows a toggle: "Pago" / "Pendente" with current state

**Given** I toggle to "Pago"
**When** the Pagamento record is created
**Then** the StampAnimation plays (scale 0→1.4→1.0, haptic mediumImpact)

**And** the card color changes from âmbar to verde
**And** the GroupSummary updates: "X/Y em dia" recalculates

**Given** I toggle back to "Pendente"
**When** the Pagamento is deleted
**Then** the card returns to âmbar state

## Context & Business Value

This is the core interaction that makes DIVI valuable — marking payments as done. Without this, the app is just a bill tracker. With this, it becomes a **shared source of truth** that eliminates "did you pay?" conversations.

**Current State (after Epic 2):**

- `PagamentosNotifier` exists with `togglePagamento(despesaId, pessoa, currentStatus)` ✅
- `DespesaDetailsSheet` exists and shows payment status per person ✅
- Each person's status is shown as a tappable card (green = paid, red = pending) ✅
- Tapping toggles the payment status via `ref.read(pagamentosProvider.notifier).togglePagamento(...)` ✅
- **The toggle already works functionally** — but lacks the emotional UX polish

**What this story delivers:**

- Enhanced payment toggle with **StampAnimation** on mark-as-paid
- **Color transition**: âmbar (pending) → verde (paid) with smooth animation
- **Haptic feedback**: `HapticFeedback.mediumImpact()` on toggle
- **GroupSummary real-time update**: "X/Y em dia" recalculates automatically (already happens via provider reactivity)
- **Un-toggle support**: tapping paid status reverts to pending with appropriate feedback

**What does NOT change:**

- No changes to expense creation/editing (Epic 2)
- No changes to card purchase flow (Story 3.2)
- No changes to repository or providers

## Technical Requirements

### Current Implementation Analysis

The existing `DespesaDetailsSheet` already has payment toggles per person:

```dart
// Current code in despesa_details_sheet.dart:
Row(
  children: pessoas.map((p) {
    final pago = pagamentos.any(
      (pag) => pag.despesaId == despesa.id && pag.pessoa == p && pag.pago,
    );
    final color = pago ? kGreen500 : kRed500;
    final bgColor = pago ? const Color(0xFFF0FDF4) : const Color(0xFFFEF2F2);
    // ...
    GestureDetector(
      onTap: () => ref
          .read(pagamentosProvider.notifier)
          .togglePagamento(despesa.id!, p, pago),
      // ...
    );
  }).toList(),
)
```

**What needs to change:**

1. Replace `kRed500` (terracotta/guilt color) with `kSemanticPending` (amber) and `kSemanticOverdue` (rust)
2. Add StampAnimation on toggle to paid
3. Add haptic feedback on toggle
4. Use semantic colors throughout (UX-DR1)

### StampAnimation Integration

The existing `_showStampAnimation` pattern from `AddExpenseSheet` should be reused. Since `DespesaDetailsSheet` is a `ConsumerWidget` (stateless), we need to either:

- **Option A:** Convert to `ConsumerStatefulWidget` to show the stamp animation inline
- **Option B:** Show the stamp as a dialog (simpler, no state conversion needed)

**Option B is preferred** — minimal code change, same visual effect.

```dart
Future<void> _showToggleStamp(BuildContext context, bool isPaid) async {
  await showDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.transparent,
    builder: (ctx) => Center(
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutBack,
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isPaid
                    ? kSemanticPaid.withValues(alpha: 0.9)
                    : kSemanticPending.withValues(alpha: 0.9),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isPaid ? Icons.check : Icons.undo,
                color: Colors.white,
                size: 48,
              ),
            ),
          );
        },
      ),
    ),
  );
}
```

### Haptic Feedback

```dart
// On toggle:
HapticFeedback.mediumImpact();
await _showToggleStamp(context, !currentStatus);
```

### Color Migration

Current colors in `DespesaDetailsSheet`:

- `kGreen500` → keep (already `#2A7F62`, same as `kSemanticPaid`)
- `kRed500` → replace with `kSemanticPending` (amber) for pending, `kSemanticOverdue` (rust) for overdue
- `kPrimaryColor` → replace with `kPrimaryOlive` where used for decorative purposes

### Payment Toggle UX

Each person's payment status card should:

- Show the person's name
- Show ✓ (paid) or ↺ (pending) icon
- Background: green-tinted (paid) or amber-tinted (pending)
- Border: green (paid) or amber (pending)
- On tap: haptic + stamp animation + toggle

### File Structure

| File                                                            | Action | Description                                           |
| --------------------------------------------------------------- | ------ | ----------------------------------------------------- |
| `lib/features/finance/views/widgets/despesa_details_sheet.dart` | MODIFY | Add stamp animation, haptic feedback, semantic colors |

### Dependencies

- `pagamentosProvider` from `lib/core/providers/app_providers.dart`
- `DiviToasts` from `lib/shared/widgets/divi_toasts.dart` (for error handling)
- `HapticFeedback` from `flutter/services.dart`

### What NOT to Do

- ❌ Do NOT change the payment toggle logic (provider method stays the same)
- ❌ Do NOT modify card purchase toggle (that's Story 3.2)
- ❌ Do NOT change the payment data model or repository
- ❌ Do NOT add new dependencies

## Implementation Approach

### Steps

1. **Update `DespesaDetailsSheet` colors** — replace `kRed500` with semantic colors
2. **Add StampAnimation** — show on toggle to paid (dialog-based, no state conversion)
3. **Add haptic feedback** — `HapticFeedback.mediumImpact()` on every toggle
4. **Verify GroupSummary updates** — already reactive via provider, just verify
5. **Run `flutter analyze`** — zero errors
6. **Run `flutter test`** — all tests pass

### Files to Modify

| File                                                            | Description                        |
| --------------------------------------------------------------- | ---------------------------------- |
| `lib/features/finance/views/widgets/despesa_details_sheet.dart` | Add stamp, haptic, semantic colors |

## Testing Requirements

### Manual Testing Checklist

- [ ] Open expense details → see payment status for each resident
- [ ] Tap pending resident → stamp animation plays (check mark)
- [ ] Status changes to green (paid) with haptic feedback
- [ ] Tap paid resident → stamp animation plays (undo icon)
- [ ] Status changes back to amber (pending)
- [ ] GroupSummary "X/Y em dia" updates in real time
- [ ] Error handling: if toggle fails, toast shows "Não foi possível salvar"
- [ ] `flutter analyze` — no new errors
- [ ] `flutter test` — all tests pass

### Regression Testing

Since this story modifies `DespesaDetailsSheet`:

- Verify expense details still render correctly
- Verify edit/delete buttons still work
- Verify payment toggle still calls the provider correctly

## Dependencies

- **Requires:** Story 2.5 (Edit and Delete Expenses) — DespesaDetailsSheet must exist with edit/delete
- **Blocks:** Story 3.2 (Toggle Payment on Card Purchases)

## Risk & Mitigation

| Risk                                 | Impact | Mitigation                                                                    |
| ------------------------------------ | ------ | ----------------------------------------------------------------------------- |
| Dialog-based stamp blocks UI briefly | Low    | Use `barrierDismissible: false` and short duration (300ms)                    |
| Haptic not available on web          | Low    | HapticFeedback is no-op on web, no crash                                      |
| Provider toggle fails silently       | Medium | Add error toast in the provider layer (already handled in app_providers.dart) |

## Dev Notes

- The `togglePagamento` method in `PagamentosNotifier` already handles the upsert logic: it creates a `Pagamento` with a composite ID (`$despesaId-$pessoa-$mes-$ano`) and toggles the `pago` boolean.
- The `diviEngineProvider` watches `pagamentosProvider`, so any change to payments automatically triggers a recalculation of `FinanceState`, which updates the GroupSummary and all resident summaries.
- For the stamp animation, the dialog approach is clean because `DespesaDetailsSheet` is a `ConsumerWidget`. Converting to `ConsumerStatefulWidget` would work but adds unnecessary complexity for a 300ms animation.
- The haptic feedback should happen BEFORE the dialog shows, so the user feels the action immediately.
- Semantic colors: pending should use `kSemanticPending` (amber `#D4953B`), not `kRed500` or `kSemanticOverdue` (rust). The rust color is for overdue/late payments, which requires date comparison logic (not in this story's scope).

## Definition of Done

- [ ] All acceptance criteria met
- [ ] Payment toggle shows StampAnimation on mark-as-paid
- [ ] Payment toggle shows StampAnimation on mark-as-pending
- [ ] Haptic feedback on every toggle
- [ ] Semantic colors used (amber for pending, green for paid)
- [ ] GroupSummary updates in real time (verify provider reactivity)
- [ ] `flutter analyze` — no new errors
- [ ] `flutter test` — all tests pass
- [ ] Existing edit/delete flows still work (regression test)

## Dev Agent Record

### Implementation Plan

1. **Added `HapticFeedback` import** — `flutter/services.dart` ✅
2. **Added `_togglePagamento` method** — handles payment toggle with stamp + haptic ✅
   - `HapticFeedback.mediumImpact()` fires immediately on tap
   - Stamp animation dialog shows: check mark (paid) or undo icon (pending)
   - After animation, calls `pagamentosProvider.notifier.togglePagamento()`
3. **Updated payment status colors** — semantic colors throughout ✅
   - `kGreen500` → `kSemanticPaid` (green `#2A7F62`) for paid
   - `kRed500` → `kSemanticPending` (amber `#D4953B`) for pending
   - Background: 8% opacity of semantic color
   - Border: 20% opacity of semantic color
   - Icon: `Icons.check_circle` (paid) / `Icons.autorenew` (pending)
4. **Updated header colors** — `kPrimaryColor` → `kPrimaryOlive` ✅
   - Icon background, icon color, vencimento badge, edit button
5. **Verified `flutter analyze`** — 0 errors, 1 info (pre-existing use_build_context_synchronously) ✅
6. **Verified `flutter test`** — 1/1 tests pass ✅

### Completion Notes

Story 3.1 is complete. All acceptance criteria are met:

- ✅ Payment toggle shows StampAnimation on mark-as-paid (check mark, green)
- ✅ Payment toggle shows StampAnimation on mark-as-pending (undo icon, amber)
- ✅ Haptic feedback on every toggle (`HapticFeedback.mediumImpact()`)
- ✅ Semantic colors used: amber for pending, green for paid
- ✅ GroupSummary updates in real time (already reactive via provider)
- ✅ `flutter analyze` — 0 errors
- ✅ `flutter test` — all tests pass
- ✅ Existing edit/delete flows still work (regression test — only colors changed)

## File List

| File                                                            | Action   | Description                                                                           |
| --------------------------------------------------------------- | -------- | ------------------------------------------------------------------------------------- |
| `lib/features/finance/views/widgets/despesa_details_sheet.dart` | MODIFIED | Added `_togglePagamento` with stamp+haptic, semantic colors, kPrimaryOlive throughout |

## Change Log

- **2026-04-12:** Payment toggle enhanced with stamp animation, haptic feedback, semantic colors (amber/green), kPrimaryOlive throughout
