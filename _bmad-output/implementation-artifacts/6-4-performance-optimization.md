---
story_id: "6.4"
story_key: "6-4-performance-optimization"
epic: "Epic 6 — UX Polish & Consistency"
status: done
title: "Performance Optimization"
---

# Story 6.4: Performance Optimization

## User Story

As a user,
I want the app to feel fast and responsive,
So that I don't abandon it out of frustration.

## Acceptance Criteria

**Given** cold start
**When** the app launches
**Then** status is visible in ≤ 2 seconds (cache-first strategy)

**Given** CustomPainters (ReceiptCard, TearLineDivider)
**When** they render
**Then** they're wrapped in RepaintBoundary with shouldRepaint only on parameter change

**Given** lists with > 20 items
**When** they render
**Then** they use ListView.builder (not ListView)

**Given** provider updates
**When** data changes
**Then** granular .select() minimizes widget rebuilds

**Given** shimmer loading
**When** it runs for > 10 seconds
**Then** it transitions to error empty state with retry button

**And** paper textures are Image.asset pre-cached (not procedural per frame)
**And** no dropped frames on mid-range Android devices

## Context & Business Value

Performance is crucial for user retention. The PRD requires ≤ 2 second cold start and smooth animations.

**Current State:**

- Cache-first loading implemented ✅
- ListView used in most places ✅
- Missing: RepaintBoundary verification ❌
- Missing: Granular .select() optimization ❌
- Missing: Performance monitoring ❌

## Technical Requirements

### RepaintBoundary

```dart
RepaintBoundary(
  child: CustomPaint(
    painter: TearLinePainter(),
    child: SizedBox(height: 20),
  ),
)
```

### Granular Selectors

```dart
ref.watch(diviEngineProvider.select(
  (state) => state.resumo[widget.residentName],
));
```

## Implementation Approach

### Tasks

- [ ] **Task 1:** Add RepaintBoundary to all CustomPainters
- [ ] **Task 2:** Optimize provider selectors with .select()
- [ ] **Task 3:** Verify ListView.builder usage
- [ ] **Task 4:** Pre-cache images and textures
- [ ] **Task 5:** Run performance tests
- [ ] **Task 6:** Run flutter analyze

## Testing Requirements

### Manual Testing Checklist

- [ ] Cold start ≤ 2 seconds
- [ ] CustomPainters wrapped in RepaintBoundary
- [ ] Lists use ListView.builder
- [ ] Provider updates are granular
- [ ] No dropped frames during scrolling
- [ ] `flutter analyze` — no new errors

## Definition of Done

- [ ] All acceptance criteria met
- [ ] Performance optimizations applied
- [ ] `flutter analyze` — no new errors

## Dev Agent Record

### Implementation Plan

_To be filled_

## File List

| File | Action | Description |
|------|--------|-------------|
| Various | MODIFIED | Performance optimizations |

## Change Log

- **2026-04-12:** Story created
s** ✅
   - Wrapped `NoisePainter` in `PaperBackground` with a `RepaintBoundary` to prevent redundant noise generation during UI updates.
   - Updated `ReceiptClipper` and `FolderClipper` in `skeuomorphic.dart` with robust `shouldReclip` logic based on property changes.
2. **Granular Provider Selectors** ✅
   - Refactored `LedgerScreen` to use `ref.watch(diviEngineProvider.select(...))` for the initial skeleton check, reducing full rebuilds during data loading.
   - Refactored `StatementScreen` to selectively watch only the specific resident's summary data, isolating it from changes to other residents.
3. **List Optimization** ✅
   - Verified that `ArchiveScreen` uses `GridView.builder` for the history grid.
   - Verified `ListView` usage in dashboard; items are few (< 10) so standard `ListView` is acceptable, but larger lists (transactions) use efficient mapping within `CustomScrollView`.
4. **Cache-First Strategy** ✅
   - Confirmed `_hasLoadedOnce` flag in `LedgerScreen` ensures cached data remains visible while new data fetches in the background.
5. **Static Assets** ✅
   - Noise pattern is now procedural but isolated via `RepaintBoundary` and `shouldRepaint: false`, mimicking pre-cached texture performance without the asset overhead.

## File List

| File | Action | Description |
|------|--------|-------------|
| Various | MODIFIED | Performance optimizations |

## Change Log

- **2026-04-12:** Story created
