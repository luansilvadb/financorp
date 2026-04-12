---
story_id: "4.4"
story_key: "4-4-implement-cartao-tab"
epic: "Epic 4 — Ledger & Statement Views"
status: done
title: "Implement CartaoTab"
---

# Story 4.4: Implement CartaoTab

## User Story

As a resident,
I want to see all card purchases grouped by person,
So that I can review credit card spending for the month.

## Acceptance Criteria

**Given** the CartaoTab
**When** it renders
**Then** purchases are grouped by person (Luan, Luciana, Giovanna)

**Given** a purchase card
**When** I swipe right
**Then** it's marked as paid (StampAnimation)

**Given** I swipe left
**Then** a delete confirmation appears

**And** the tab shows per-person totals at the top
**And** purchases are sorted by date (newest first)

## Context & Business Value

The **CartaoTab** already existed with swipe gestures from Story 3.2, but was **NOT integrated into the main navigation**. This story completes the integration and verifies all acceptance criteria.

## Dev Agent Record

### Implementation Plan

**Verification Results:**

1. ✅ **CartaoTab grouping** — Already implemented correctly
   - Uses `diviEngineProvider.select((s) => s.comprasPorPessoa)` for O(1) access
   - Groups by person (Luan, Luciana, Giovanna)
   - Per-person subtotals displayed in group headers
   - Empty state shows when no purchases

2. ✅ **Swipe gestures** — Already implemented (Story 3.2)
   - Swipe right → mark as paid with StampAnimation + haptic feedback
   - Swipe left → delete confirmation dialog
   - Semantic colors used (amber/green)

3. ✅ **Per-person totals** — Already displayed
   - Shows subtotal next to person name in group header
   - Formatted with `fmt()` currency formatter

4. ❌ **Integration in main navigation** — **WAS MISSING**
   - CartaoTab existed but was NOT accessible from home screen
   - Only LedgerScreen and ArchiveScreen were in IndexedStack

**Changes Made:**

1. **Added CartaoTab to main navigation** ✅
   - Updated `HomeScreen` in `main.dart`
   - Changed `IndexedStack` from 2 to 3 tabs:
     - Tab 0: `LedgerScreen()` (CONTAS)
     - Tab 1: `CartaoTab()` (CARTÃO) ← NEW
     - Tab 2: `ArchiveScreen()` (HISTÓRICO)

2. **Updated PaperBottomNav** ✅
   - Added third navigation item for CartaoTab
   - Icon: `Icons.credit_card` (CARTÃO label)
   - Reordered tabs: CONTAS (0), CARTÃO (1), FAB (center), HISTÓRICO (2)
   - Adjusted spacing for 3 tabs + FAB

3. **Verified sorting** ✅
   - Purchases come from `comprasPorPessoa` which maintains insertion order
   - Sorted by date when created in `finance_engine.dart`
   - No additional sorting needed in CartaoTab

### Completion Notes

Story 4.4 is complete. All acceptance criteria are met:

- ✅ Purchases grouped by person (Luan, Luciana, Giovanna)
- ✅ Swipe right → marks as paid with StampAnimation (already implemented in Story 3.2)
- ✅ Swipe left → delete confirmation appears (already implemented in Story 3.2)
- ✅ Per-person totals shown at top (subtotals in group headers)
- ✅ Purchases sorted by date (newest first)
- ✅ **CartaoTab NOW ACCESSIBLE** from main navigation (tab 1: CARTÃO)
- ✅ `dart analyze` — **No errors** (1 pre-existing info warning)

**Files Modified:**

| File                                       | Action   | Description                                             |
| ------------------------------------------ | -------- | ------------------------------------------------------- |
| `lib/main.dart`                            | MODIFIED | Added CartaoTab import and to IndexedStack (3 tabs now) |
| `lib/shared/widgets/paper_bottom_nav.dart` | MODIFIED | Added CARTÃO tab with credit_card icon                  |

**No changes needed to:**

- `lib/features/cartao/views/cartao_tab.dart` — Already fully functional
- `lib/features/cartao/views/widgets/cartao_card.dart` — Swipe gestures already implemented (Story 3.2)

## File List

| File                                       | Action   | Description                              |
| ------------------------------------------ | -------- | ---------------------------------------- |
| `lib/main.dart`                            | MODIFIED | Added CartaoTab to IndexedStack (3 tabs) |
| `lib/shared/widgets/paper_bottom_nav.dart` | MODIFIED | Added CARTÃO navigation item             |

## Change Log

- **2026-04-12:** CartaoTab integrated into main navigation (tab 1: CARTÃO)
- **2026-04-12:** Story created — verification and integration specification
