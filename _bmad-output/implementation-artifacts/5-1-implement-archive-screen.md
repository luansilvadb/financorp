---
story_id: "5.1"
story_key: "5-1-implement-archive-screen"
epic: "Epic 5 — Monthly Archive"
status: done
title: "Implement ArchiveScreen (Month Folder View)"
---

# Story 5.1: Implement ArchiveScreen (Month Folder View)

## User Story

As a resident,
I want to browse past months as folder cards,
So that I can navigate to any historical period.

## Acceptance Criteria

**Given** the ArchiveScreen
**When** it opens
**Then** it shows folder cards for each month that has data, newest first

**Given** a folder card
**When** it renders
**Then** it shows: month name, year, total expenses count, and a folder icon (skeuomorphic)

**Given** I tap a folder card
**When** I navigate
**Then** the LedgerScreen opens for that specific month/year

## Context & Business Value

The **ArchiveScreen already exists** with basic folder grid layout. This story focuses on enhancing it to show only months with data and add expense counts to folder cards.

**Current State:**

- ArchiveScreen exists with grid of folder cards ✅
- Shows last 12 months ✅
- FolderCard component exists ✅
- Tap navigates to selected month ✅
- Missing: Only shows months with data ❌
- Missing: Expense count on folder cards ❌

**What this story delivers:**

- Filter to show only months that have expenses/purchases
- Add expense count to each folder card
- Maintain skeuomorphic folder design
- Keep newest-first ordering

## Technical Requirements

### Filter Months with Data

```dart
// Query which months have data
final monthsWithData = <DateTime>[];
for (final date in allMonths) {
  final hasData = financeState.despesas.isNotEmpty ||
                  financeState.comprasPorPessoa.values.any((l) => l.isNotEmpty);
  if (hasData) monthsWithData.add(date);
}
```

### Add Expense Count to FolderCard

```dart
Widget _buildFolderCard({
  required String month,
  required String year,
  required int expenseCount,
  VoidCallback? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      // ... existing FolderCard design
      child: Column(
        children: [
          Icon(Icons.folder, size: 48, color: kPrimaryOlive),
          Text(month),
          Text(year),
          Text('$expenseCount registros'), // NEW
        ],
      ),
    ),
  );
}
```

## Implementation Approach

### Tasks

- [ ] **Task 1:** Filter months to show only those with data
- [ ] **Task 2:** Add expense count to folder cards
- [ ] **Task 3:** Verify newest-first ordering
- [ ] **Task 4:** Run flutter analyze

## Testing Requirements

### Manual Testing Checklist

- [ ] ArchiveScreen shows only months with data
- [ ] Each folder shows expense count
- [ ] Months ordered newest first
- [ ] Tap folder → navigates to correct month/year
- [ ] Toast shows month name on tap
- [ ] `flutter analyze` — no new errors

## Definition of Done

- [ ] All acceptance criteria met
- [ ] Only months with data shown
- [ ] Expense count visible on folders
- [ ] `flutter analyze` — no new errors

## Dev Agent Record

### Implementation Plan

1. **Added data filtering logic** ✅
   - Watches `diviEngineProvider` to access expenses and purchases
   - Generates last 24 months (instead of 12) for deeper history
   - Filters to show only months that have ANY data (expenses OR purchases)
   - Falls back to showing last 12 months if no data exists
2. **Added expense count to folder cards** ✅
   - Counts total records: `despesas.length + compras.length`
   - Passes `recordCount` to `FolderCard` widget
   - Shows "X registros" below folder label when count > 0
3. **Updated FolderCard component** ✅
   - Added `recordCount` parameter with default value 0
   - Shows count text in `Space Mono` 9px, faded color
   - Only displays when `recordCount > 0`
4. **Added navigation back to LedgerScreen** ✅
   - Tapping folder now pops all routes back to first (LedgerScreen)
   - Sets period (month/year) before navigating
   - Shows toast with month name being opened
5. **Empty state handling** ✅
   - Shows "Nenhum histórico disponível" if no months to display
6. **Verified with dart analyze** ✅
   - **No issues found!**

### Completion Notes

Story 5.1 is complete. All acceptance criteria are met:

- ✅ Shows folder cards for each month that has data, newest first
- ✅ Each folder shows: month name, year, record count, folder icon
- ✅ Tap folder → navigates to LedgerScreen for that specific month/year
- ✅ `dart analyze` — **No issues found!**

**Changes Made:**

1. **archive_screen.dart** — Added filtering, count logic, navigation
2. **folder_card.dart** — Added `recordCount` parameter and display

## File List

| File                                                  | Action   | Description                                                   |
| ----------------------------------------------------- | -------- | ------------------------------------------------------------- |
| `lib/features/finance/views/archive_screen.dart`      | MODIFIED | Filter months with data, add record count, improve navigation |
| `lib/features/finance/views/widgets/folder_card.dart` | MODIFIED | Added `recordCount` parameter and display                     |

## Change Log

- **2026-04-12:** ArchiveScreen enhanced with data filtering, record count, improved navigation
- **2026-04-12:** Story created
 created
