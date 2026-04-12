---
story_id: "4.3"
story_key: "4-3-implement-search-filter"
epic: "Epic 4 — Ledger & Statement Views"
status: done
title: "Implement Search and Filter"
---

# Story 4.3: Implement Search and Filter

## User Story

As a resident,
I want to search and filter expenses,
So that I can find specific items quickly.

## Acceptance Criteria

**Given** a search bar on the statement screen
**When** I type a search term
**Then** the list filters by name/description with debounce 300ms

**Given** no results match
**When** the search is empty
**Then** an empty state shows: "Sem resultados para '[termo]'" with "Limpar busca" button

**Given** filter chips are present
**When** I tap "Pago" or "Pendente"
**Then** the list filters by status and shows the filtered total

## Context & Business Value

Search and filter functionality helps users quickly find specific transactions in long lists. Without it, users must scroll through all items manually.

**Current State:**

- StatementScreen shows transaction list ✅
- LedgerScreen has basic search (for residents) ✅
- No search/filter within individual statements ❌
- No filter by payment status ❌

**What this story delivers:**

- **Search bar** in StatementScreen with 300ms debounce
- **Filter chips**: "Todos", "Pago", "Pendente"
- **Empty state** when no results match
- **Filtered total** shows count of visible items

## Technical Requirements

### Search Implementation

```dart
class _StatementScreenState extends ConsumerState<StatementScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  String _filterStatus = "todos"; // todos, pago, pendente

  // Debounce timer
  Timer? _debounce;

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() => _searchQuery = query.toLowerCase());
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }
}
```

### Filter Logic

```dart
List<TransactionItem> _filterTransactions(List<TransactionItem> items) {
  return items.where((item) {
    // Search filter
    if (_searchQuery.isNotEmpty) {
      final matchesSearch =
          item.descricao.toLowerCase().contains(_searchQuery);
      if (!matchesSearch) return false;
    }

    // Status filter
    if (_filterStatus == "pago" && !item.pago) return false;
    if (_filterStatus == "pendente" && item.pago) return false;

    return true;
  }).toList();
}
```

### Filter Chips UI

```dart
Widget _buildFilterChips() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        _buildChip("Todos", "todos"),
        _buildChip("Pago", "pago"),
        _buildChip("Pendente", "pendente"),
      ],
    ),
  );
}

Widget _buildChip(String label, String value) {
  final isSelected = _filterStatus == value;
  return Padding(
    padding: const EdgeInsets.only(right: 8),
    child: FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() => _filterStatus = value);
      },
      selectedColor: kSemanticPaid.withValues(alpha: 0.2),
    ),
  );
}
```

## Implementation Approach

### Tasks

- [ ] **Task 1:** Add search bar to StatementScreen with debounce
- [ ] **Task 2:** Add filter chips (Todos/Pago/Pendente)
- [ ] **Task 3:** Implement filter logic for transactions
- [ ] **Task 4:** Add empty state for no results
- [ ] **Task 5:** Show filtered total count
- [ ] **Task 6:** Run flutter analyze

## Testing Requirements

### Manual Testing Checklist

- [ ] Type search term → list filters with 300ms debounce
- [ ] Clear search → all items reappear
- [ ] No results → empty state shows with "Limpar busca"
- [ ] Tap "Pago" chip → only paid items show
- [ ] Tap "Pendente" chip → only pending items show
- [ ] Tap "Todos" chip → all items show
- [ ] Filtered total shows correct count
- [ ] `flutter analyze` — no new errors

## Definition of Done

- [ ] All acceptance criteria met
- [ ] Search works with debounce
- [ ] Filter chips work correctly
- [ ] Empty state shows when no results
- [ ] `flutter analyze` — no new errors

## Dev Agent Record

### Implementation Plan

1. **Added search bar with 300ms debounce** ✅
   - `TextEditingController` with listener for real-time updates
   - Timer-based debounce (300ms) to avoid excessive rebuilds
   - Search icon prefix and clear button suffix
   - Styled with `Space Mono` font to match app design
2. **Added filter chips (Todas/Pago/Pendente)** ✅
   - Horizontal scrollable row of `FilterChip` widgets
   - Selected chip shows green background (`kSemanticPaid` with 20% alpha)
   - Checkmark color matches semantic paid color
   - Border changes color based on selection state
3. **Implemented filter logic** ✅
   - `_filterTransactions()` method filters by search query AND status
   - Search filters by transaction title (case-insensitive)
   - Status filters: "todos" (all), "pago" (paid only), "pendente" (pending only)
   - Maintains original sort order (newest first)
4. **Added empty state for no results** ✅
   - Shows "Sem resultados para '[termo]'" with search_off icon
   - "Limpar busca" button to clear search
   - Styled consistently with other empty states
5. **Added filtered count indicator** ✅
   - Shows "X de Y transações" when filters are active
   - Only visible when search query is not empty OR filter is not "todos"
   - Uses `Space Mono` font for consistency
6. **Updated transaction list** ✅
   - Now uses `filteredTransactions` instead of `allTransactions`
   - Empty state logic: shows no results OR no transactions for month
7. **Verified with flutter analyze** ✅
   - `dart analyze` — **No issues found!**

### Completion Notes

Story 4.3 is complete. All acceptance criteria are met:

- ✅ Search bar with 300ms debounce filters transactions
- ✅ Filter chips (Todas/Pago/Pendente) work correctly
- ✅ Empty state shows "Sem resultados para '[termo]'" with "Limpar busca" button
- ✅ Filtered count shows "X de Y transações"
- ✅ `dart analyze` — **No issues found!**

**Changes Made:**

1. **Added search state management** ✅
   - `_searchController`, `_searchQuery`, `_filterStatus`, `_debounce`
   - `initState` adds listener to search controller
   - `dispose` cancels debounce and removes listener
2. **Added debounce logic** ✅
   - 300ms delay before updating search query
   - Cancels previous timer if user types again
3. **Added filter logic** ✅
   - `_filterTransactions()` filters by search and status
   - Case-insensitive search on transaction title
4. **Added UI components** ✅
   - `_buildSearchBar()` — text field with search icon and clear button
   - `_buildFilterChips()` — horizontal scrollable filter chips
   - `_buildChip()` — individual filter chip with proper styling
   - `_buildNoResultsEmptyState()` — empty state when no results match
5. **Integrated into build method** ✅
   - Filters transactions after sorting
   - Shows filtered count when filters active
   - Shows appropriate empty state based on conditions

## File List

| File                                               | Action   | Description                                                 |
| -------------------------------------------------- | -------- | ----------------------------------------------------------- |
| `lib/features/finance/views/statement_screen.dart` | MODIFIED | +150 lines: search bar, filter chips, debounce, empty state |

## Change Log

- **2026-04-12:** StatementScreen enhanced with search (300ms debounce), filter chips, empty state
- **2026-04-12:** Story created — search and filter specification
fication
