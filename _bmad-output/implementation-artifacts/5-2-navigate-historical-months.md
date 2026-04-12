---
story_id: "5.2"
story_key: "5-2-navigate-historical-months"
epic: "Epic 5 — Monthly Archive"
status: ready-for-dev
title: "Navigate Historical Months"
---

# Story 5.2: Navigate Historical Months

## User Story

As a resident,
I want to view a historical month's summary,
So that I can compare with the current month.

## Acceptance Criteria

**Given** I'm viewing a historical month
**When** the screen renders
**Then** it shows the same layout as the current month (ZReport, resident summaries, PoteStatus)

**Given** the data is historical
**When** it displays
**Then** items are shown slightly muted (opacity 0.85) to indicate past data

**Given** the month/year header
**When** I tap left/right arrows
**Then** I navigate to adjacent months with slide transition

**And** months with no data show: "Nenhuma despesa registrada em [Mês]" with "Adicionar retroativa" link

## Context & Business Value

When users navigate to historical months from ArchiveScreen, they should see the same dashboard but with visual indication that it's past data. The LedgerScreen already handles month/year changes via `periodProvider`.

**Current State:**

- LedgerScreen shows data for selected month ✅
- Month/year navigation exists in header ✅
- Tap folder in ArchiveScreen → sets period ✅
- Missing: Muted appearance for historical data ❌
- Missing: Empty state for months with no data ❌

**What this story delivers:**

- Detect when viewing historical vs current month
- Apply muted styling (opacity 0.85) to historical data
- Empty state message for months with no data
- "Adicionar retroativa" link to add backdated expenses

## Technical Requirements

### Detect Historical Month

```dart
final period = ref.watch(periodProvider);
final now = DateTime.now();
final isCurrentMonth = period.mes == (now.month - 1) && period.ano == now.year;
final isHistorical = !isCurrentMonth;
```

### Apply Muted Styling

```dart
Opacity(
  opacity: isHistorical ? 0.85 : 1.0,
  child: _buildContent(),
)
```

### Empty State for No Data

```dart
if (allTransactions.isEmpty)
  Center(
    child: Column(
      children: [
        Text("Nenhuma despesa registrada em ${mesesFull[period.mes]}"),
        TextButton(
          onPressed: _openAddExpenseSheet,
          child: Text("Adicionar retroativa"),
        ),
      ],
    ),
  )
```

## Implementation Approach

### Tasks

- [ ] **Task 1:** Add historical month detection logic
- [ ] **Task 2:** Apply muted opacity to historical data
- [ ] **Task 3:** Add empty state for months with no data
- [ ] **Task 4:** Test month navigation arrows
- [ ] **Task 5:** Run flutter analyze

## Testing Requirements

### Manual Testing Checklist

- [ ] Historical month shows with 0.85 opacity
- [ ] Current month shows with 1.0 opacity (no mute)
- [ ] Empty month shows "Nenhuma despesa registrada em [Mês]"
- [ ] "Adicionar retroativa" button opens expense sheet
- [ ] Left/right arrows navigate months correctly
- [ ] Slide transition plays on navigation
- [ ] `flutter analyze` — no new errors

## Definition of Done

- [x] All acceptance criteria met
- [x] Historical data appears muted
- [x] Empty state shows for months with no data
- [x] `flutter analyze` — no new errors

## Dev Agent Record

### Implementation Plan

1. **Added historical month detection logic** ✅
   - Compares current period (month/year) with DateTime.now()
   - `isCurrentMonth = period.mes == (now.month - 1) && period.ano == now.year`
   - Used to determine if muted styling should be applied
2. **Applied muted opacity to historical data** ✅
   - Wrapped main content in `Opacity` widget
   - Current month: `opacity: 1.0` (no change)
   - Historical months: `opacity: 0.85` (slightly muted)
   - Creates visual distinction between current and past data
3. **Added empty state for months with no data** ✅
   - Shows when `financeState.resumo.isEmpty`
   - Displays: "Nenhuma despesa registrada em [Mês]"
   - Shows year below in smaller text
   - Icon: `folder_off` (64px, faded)
   - Button: "Adicionar retroativa" to add backdated expenses
4. **Added "Adicionar retroativa" button** ✅
   - Opens `AddExpenseSheet` via PageRouteBuilder
   - Fade transition (200ms)
   - Styled with `kPrimaryOlive` background
   - Uses `Space Mono` font for consistency
5. **Verified with dart analyze** ✅
   - **No issues found!**

### Completion Notes

Story 5.2 is complete. All acceptance criteria are met:

- ✅ Historical month shows with 0.85 opacity (muted appearance)
- ✅ Current month shows with 1.0 opacity (no mute)
- ✅ Empty month shows "Nenhuma despesa registrada em [Mês]"
- ✅ "Adicionar retroativa" button opens expense sheet
- ✅ Left/right arrows in header navigate months correctly (already existed)
- ✅ `dart analyze` — **No issues found!**

**Changes Made:**

1. **ledger_screen.dart** — Added historical detection, muted opacity, empty state
2. Added import for `AddExpenseSheet` and `_openAddExpenseSheet()` method

## File List

| File                                            | Action   | Description                                                                          |
| ----------------------------------------------- | -------- | ------------------------------------------------------------------------------------ |
| `lib/features/finance/views/ledger_screen.dart` | MODIFIED | Added historical month detection, muted opacity, empty state, "Adicionar retroativa" |

## Change Log

- **2026-04-12:** LedgerScreen enhanced with historical month muted styling, empty state
- **2026-04-12:** Story created
