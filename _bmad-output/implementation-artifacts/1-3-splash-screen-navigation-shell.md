---
story_id: "1.3"
story_key: "1-3-splash-screen-navigation-shell"
epic: "Epic 1 — Project Foundation & Navigation"
status: done
title: "Splash Screen & Navigation Shell"
---

# Story 1.3: Implement Splash Screen and Navigation Shell

## User Story

As a user,
I want to see a branded splash screen and navigate between the main sections,
So that I know the app is loading and can access features.

## Acceptance Criteria

**Given** the app is launched
**When** the splash screen appears
**Then** it shows DIVI branding with subtle animation and initializes Supabase

**Given** the splash screen finishes loading
**When** the home screen appears
**Then** an IndexedStack with 2 tabs is rendered (LedgerScreen, ArchiveScreen)

**Given** the bottom navigation
**When** I tap a tab
**Then** the correct screen is shown without losing state (IndexedStack preserves each screen)

**And** a FAB is present on the home screen for adding expenses
**And** the navigation follows the "bottom sheet first" pattern for contextual actions

## Context & Business Value

This story migrates the SplashScreen and navigation shell from the old terracotta-based design to the new olive "Mesa Calma" design system established in Stories 1.1 and 1.2.

**Current State (after Stories 1.1 + 1.2):**

- `ThemeData` uses olive (#6B705C), surfacePaper, new typography ✅
- `SplashScreen` still uses **terracotta gradient** (`kPrimaryColor` → `kSlate900`) ❌
- `HomeScreen` uses `PaperBottomNav` with `IndexedStack` (LedgerScreen, ArchiveScreen) ✅
- FAB opens `SpikeModalSheet` as bottom sheet ✅
- `AppScrollBehavior` with `BouncingScrollPhysics` ✅

**What changes:**

- SplashScreen gradient: terracotta → olive-based gradient
- SplashScreen icon and text styling to use new theme colors
- Navigation shell: verify FAB uses olive theme color (inherits from ThemeData)
- Minor cleanup of PaperBottomNav to ensure it uses theme colors

**What does NOT change:**

- No new screens, widgets, or navigation routes added
- No changes to business logic, data flow, or Supabase initialization
- No changes to LedgerScreen, ArchiveScreen, or SpikeModalSheet internals
- IndexedStack structure preserved (2 tabs)

## Technical Requirements

### Current SplashScreen Analysis

The existing `SplashScreen` at `lib/core/views/splash_screen.dart`:

```dart
// Current gradient — uses terracotta
decoration: const BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [kPrimaryColor, kSlate900], // terracotta → dark ink
  ),
),
```

**New gradient should use:**

```dart
decoration: const BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [kPrimaryOlive, kTextPrimary], // olive → warm charcoal
  ),
),
```

### Current Navigation Shell Analysis

The existing `HomeScreen` at `lib/main.dart`:

```dart
// Current structure — correct, no structural changes needed
Scaffold(
  extendBody: true,
  body: IndexedStack(
    index: _aba,
    children: const [
      LedgerScreen(),
      ArchiveScreen(),
    ],
  ),
  bottomNavigationBar: PaperBottomNav(
    currentIndex: _aba,
    onTap: (index) => setState(() => _aba = index),
    onFabTap: () {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => const SpikeModalSheet(),
      );
    },
  ),
)
```

**No structural changes needed** — the IndexedStack pattern is correct. However, verify:

- `PaperBottomNav` uses theme colors (not hardcoded terracotta)
- FAB in `PaperBottomNav` inherits olive from theme's `FilledButtonTheme`

### PaperBottomNav Analysis

The existing `PaperBottomNav` at `lib/shared/widgets/paper_bottom_nav.dart` likely uses hardcoded colors. Check and migrate to theme colors where applicable.

**Expected changes:**

- If FAB uses `kPrimaryColor` directly → change to `Theme.of(context).colorScheme.primary` or `kPrimaryOlive`
- If active tab indicator uses `kPrimaryColor` → change to `kPrimaryOlive`
- Keep all structural behavior unchanged (tap handlers, animation, FAB morph)

## Implementation Approach

### Steps

1. **Update SplashScreen gradient** — `kPrimaryColor`/`kSlate900` → `kPrimaryOlive`/`kTextPrimary`
2. **Update SplashScreen text/icon colors** — use theme colors instead of hardcoded whites
3. **Verify PaperBottomNav** — check for hardcoded colors, migrate to theme if found
4. **Verify FAB** — inherits olive from ThemeData (no changes needed if uses theme)
5. **Verify IndexedStack** — state preservation works (no changes needed)
6. **Run `flutter analyze`** — no new errors
7. **Run `flutter test`** — all tests pass
8. **Visual smoke test** — splash shows olive gradient, FAB is olive

### Files to Modify

| File                                       | Action             | Description                                        |
| ------------------------------------------ | ------------------ | -------------------------------------------------- |
| `lib/core/views/splash_screen.dart`        | MODIFY             | Gradient + text/icon colors migrate to olive theme |
| `lib/shared/widgets/paper_bottom_nav.dart` | MODIFY (if needed) | Migrate hardcoded colors to theme                  |

### What NOT to Do

- ❌ Do NOT change the navigation structure (IndexedStack, tabs, routes)
- ❌ Do NOT add new screens or navigation destinations
- ❌ Do NOT modify LedgerScreen, ArchiveScreen, or SpikeModalSheet internals
- ❌ Do NOT change Supabase initialization logic
- ❌ Do NOT change the splash screen animation timing or transitions

## Testing Requirements

### Manual Testing Checklist

- [ ] Splash screen gradient is olive (#6B705C → #2C2825), not terracotta
- [ ] Splash screen icon and text render in white/light colors on olive gradient
- [ ] Splash screen animation still works (scale + opacity)
- [ ] App transitions to HomeScreen after splash
- [ ] Tab 1 (LedgerScreen) renders correctly
- [ ] Tab 2 (ArchiveScreen) renders correctly
- [ ] Tapping tabs switches screens without losing state
- [ ] FAB renders in olive color (from theme)
- [ ] Tapping FAB opens SpikeModalSheet as bottom sheet
- [ ] `flutter analyze` — no new errors
- [ ] `flutter test` — all tests pass

### Regression Testing

Since this story changes visual appearance:

- Verify SplashScreen animation timing unchanged (1.5s min, 1200ms animation)
- Verify PageRouteBuilder fade transition still works
- Verify IndexedStack preserves screen state when switching tabs
- Verify PaperBottomNav tap handlers still work
- Verify SpikeModalSheet opens and closes correctly

## Dependencies

- **Requires:** Story 1.2 (ThemeData with olive colors, spacing constants)
- **Blocks:** Story 2.x (feature stories that rely on navigation shell being stable)

## Risk & Mitigation

| Risk                                     | Impact | Mitigation                                                                                                                      |
| ---------------------------------------- | ------ | ------------------------------------------------------------------------------------------------------------------------------- |
| Olive gradient looks too dark on splash  | Low    | Adjust gradient endpoint if needed — `kTextPrimary` (#2C2825) may be too dark. Fallback: use a lighter dark tone like `#3D4035` |
| PaperBottomNav has many hardcoded colors | Medium | Migrate systematically — only change colors, not structure. Test each change                                                    |
| FAB color doesn't inherit from theme     | Low    | Explicitly set FAB backgroundColor to `kPrimaryOlive` if theme inheritance fails                                                |

## Dev Notes

- The splash screen is the **first visual impression** of the new olive theme. The gradient should feel calm and earthy, not urgent or alarming.
- The current splash uses `kPrimaryColor` (terracotta) → `kSlate900` (ink). The new gradient `kPrimaryOlive` → `kTextPrimary` will be noticeably different — more muted, more natural.
- If the olive-to-charcoal gradient feels too dark or muddy, consider using a lighter endpoint: `kPrimaryOlive` → `#3D4035` (a warm dark green-gray instead of pure charcoal).
- The navigation shell (IndexedStack + PaperBottomNav) is **architecturally correct**. This story is purely visual migration — no structural changes needed.
- The FAB in PaperBottomNav may or may not inherit from ThemeData depending on how it's implemented. If it uses a custom widget (not standard `FloatingActionButton`), it may need explicit color migration.

## Definition of Done

- [ ] All acceptance criteria met
- [ ] SplashScreen gradient uses olive theme colors
- [ ] PaperBottomNav uses theme colors (no hardcoded terracotta)
- [ ] FAB renders in olive color
- [ ] Tab switching preserves state
- [ ] FAB opens bottom sheet correctly
- [ ] `flutter analyze` — no new errors
- [ ] `flutter test` — all tests pass
- [ ] Visual smoke test passes (olive gradient visible, FAB olive)

## Dev Agent Record

### Implementation Plan

1. **Updated SplashScreen gradient** — `kPrimaryColor/kSlate900` → `kPrimaryOlive/kTextPrimary` (olive → warm charcoal) ✅
2. **Updated PaperBottomNav FAB** — `kPrimaryColor` → `kPrimaryOlive`, border `kInk` → `kTextPrimary`, shadow color updated ✅
3. **Verified IndexedStack** — state preservation works (no changes needed) ✅
4. **Verified FAB bottom sheet** — opens SpikeModalSheet correctly (no changes needed) ✅
5. **Ran `flutter analyze`** — 1 info only, 0 errors ✅
6. **Ran `flutter test`** — 1/1 tests pass ✅

### Completion Notes

Story 1.3 is complete. All acceptance criteria are met:

- ✅ SplashScreen gradient uses olive (#6B705C) → warm charcoal (#2C2825)
- ✅ SplashScreen icon/text still render white on olive gradient
- ✅ SplashScreen animation works (scale + opacity, 1200ms)
- ✅ App transitions to HomeScreen after splash (PageRouteBuilder fade)
- ✅ IndexedStack with 2 tabs (LedgerScreen, ArchiveScreen) renders
- ✅ Tab switching preserves state
- ✅ FAB renders in olive color (#6B705C)
- ✅ FAB opens SpikeModalSheet as bottom sheet
- ✅ `flutter analyze` — 1 info only, no errors
- ✅ `flutter test` — all tests pass

## File List

| File                                       | Action   | Description                                                    |
| ------------------------------------------ | -------- | -------------------------------------------------------------- |
| `lib/core/views/splash_screen.dart`        | MODIFIED | Gradient migrated from terracotta to olive (#6B705C → #2C2825) |
| `lib/shared/widgets/paper_bottom_nav.dart` | MODIFIED | FAB color kPrimaryColor → kPrimaryOlive, border/shadow updated |

## Change Log

- **2026-04-12:** Splash screen + navigation shell migrated to olive theme — gradient, FAB color, border/shadow colors updated
