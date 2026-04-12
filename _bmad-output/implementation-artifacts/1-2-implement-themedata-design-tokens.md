---
story_id: "1.2"
story_key: "1-2-implement-themedata-design-tokens"
epic: "Epic 1 — Project Foundation & Navigation"
status: done
title: "Implement ThemeData with Design Tokens"
---

# Story 1.2: Implement ThemeData with Design Tokens

## User Story

As a designer/developer,
I want the app theme configured with all color tokens, typography, and spacing,
So that every component uses consistent design tokens from day one.

## Acceptance Criteria

**Given** the ThemeData configuration
**When** the app renders
**Then** the colorScheme uses primaryOlive #6B705C, surfacePaper #FAF6F1, and semantic colors (semanticPaid #2A7F62, semanticPending #D4953B, semanticOverdue #C2654A)

**Given** the TextTheme
**When** text renders
**Then** Young Serif is used for display/headlines, Inter for body/labels/monetary, Space Mono for dates/codes

**Given** the design tokens
**When** spacing is applied
**Then** the scale uses base 8px: xs=4, sm=8, md=16, lg=24, xl=32, xxl=48

**And** CardTheme has elevation 0 (recibos deitam, não flutuam)
**And** ButtonStyle uses FilledButton for primary, OutlinedButton for secondary

## Context & Business Value

Story 1.1 added the new color tokens to `constants.dart`. This story migrates the actual `ThemeData` in `main.dart` from the old terracotta-based theme to the new olive-based "Mesa Calma" design system.

**Current State (after Story 1.1):**

- `constants.dart` has BOTH old and new tokens (backward compatible)
- `main.dart` still uses `kPrimaryColor` (#E63819 terracotta) as seedColor
- `main.dart` still uses `GoogleFonts.interTextTheme()` for all text (no Young Serif, no Space Mono)
- CardTheme defaults to Material 3 elevation (recibos "flutuam")
- ButtonStyle uses Material 3 defaults

**What changes:**

- `colorScheme.seedColor` → `kPrimaryOlive` (#6B705C)
- `colorScheme.surface` → `kSurfacePaper` (#FAF6F1)
- `textTheme` → Young Serif for display/headlines, Space Mono for labels
- `cardTheme.elevation` → 0
- `buttonTheme` → custom styles for primary/secondary buttons
- Spacing constants accessible via theme extension

**What does NOT change:**

- Existing code that references `kPrimaryColor`, `kPaper`, `kInk` continues to work
- SplashScreen gradient (still uses terracotta for now — migration happens in a later story)
- No new widgets, screens, or features added

## Technical Requirements

### Color Migration (from constants.dart — added in Story 1.1)

```dart
// OLD (legacy — still exists for backward compat)
kPrimaryColor = #E63819  // terracotta
kPaper = #F4F1EA         // warm off-white
kInk = #2C2C2C           // black toner

// NEW (to be used in ThemeData)
kPrimaryOlive = #6B705C  // calm, earthy
kSurfacePaper = #FAF6F1  // paper kraft light
kTextPrimary = #2C2825   // warm charcoal
```

### Typography

**Required fonts via Google Fonts:**

- `Young Serif` — Display, HeadlineLarge, HeadlineMedium
- `Inter` — BodyLarge, BodyMedium, LabelLarge, LabelMedium (already in use)
- `Space Mono` — LabelSmall, dates, codes, data labels

**Implementation:**

```dart
textTheme: TextTheme(
  displayLarge: GoogleFonts.youngSerif(fontSize: 32, fontWeight: FontWeight.w400),
  headlineLarge: GoogleFonts.youngSerif(fontSize: 24, fontWeight: FontWeight.w400),
  headlineMedium: GoogleFonts.youngSerif(fontSize: 20, fontWeight: FontWeight.w400),
  bodyLarge: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400),
  bodyMedium: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400),
  labelLarge: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
  labelMedium: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
  labelSmall: GoogleFonts.spaceMono(fontSize: 12, fontWeight: FontWeight.w400),
).apply(bodyColor: kTextPrimary, displayColor: kTextPrimary),
```

**Font loading:** All three fonts must be loaded via `GoogleFonts` at app startup. `Young Serif` and `Space Mono` are NOT currently loaded — they need to be added.

### ThemeData Updates

The current `main.dart` ThemeData:

```dart
theme: ThemeData(
  textTheme: GoogleFonts.interTextTheme().apply(
    bodyColor: kInk,
    displayColor: kInk,
  ),
  scaffoldBackgroundColor: kPaper,
  colorScheme: ColorScheme.fromSeed(
    seedColor: kPrimaryColor,  // terracotta
    surface: kPaper,
    onSurface: kInk,
    error: kPrimaryColor,
  ),
),
```

**New ThemeData should include:**

```dart
theme: ThemeData(
  useMaterial3: true,
  // Color scheme
  colorScheme: ColorScheme.fromSeed(
    seedColor: kPrimaryOlive,
    surface: kSurfacePaper,
    onSurface: kTextPrimary,
    primary: kPrimaryOlive,
    onPrimary: Colors.white,
    error: kSemanticOverdue, // rust, not red
  ),
  scaffoldBackgroundColor: kSurfacePaper,

  // Typography
  textTheme: /* Young Serif + Inter + Space Mono as above */,

  // Card theme — zero elevation
  cardTheme: CardTheme(
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),

  // Button theme
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: kPrimaryOlive,
      foregroundColor: Colors.white,
      textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
      minimumSize: const Size(double.infinity, 56),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: const BorderSide(color: kPrimaryOlive, width: 1.5),
      foregroundColor: kPrimaryOlive,
      textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500),
      minimumSize: const Size(double.infinity, 56),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),

  // Input decoration
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: kSurfacePaper,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: kPaperDepth),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: kPrimaryOlive, width: 1.5),
    ),
  ),
),
```

### Spacing Constants

Add spacing constants to `constants.dart` (if not already present):

```dart
// Spacing scale (base 8px)
const kSpacingXs = 4.0;
const kSpacingSm = 8.0;
const kSpacingMd = 16.0;
const kSpacingLg = 24.0;
const kSpacingXl = 32.0;
const kSpacingXxl = 48.0;
```

### Google Fonts Loading

All three fonts must load without errors. `Young Serif` and `Space Mono` are not currently referenced in code but are declared as dependencies in `pubspec.yaml` via `google_fonts`.

**Verify:**

```dart
GoogleFonts.youngSerif()    // loads without error
GoogleFonts.inter()         // already works
GoogleFonts.spaceMono()     // loads without error
```

## Implementation Approach

### Steps

1. **Add spacing constants** to `constants.dart`
2. **Update ThemeData** in `main.dart`:
   - Change `seedColor` from `kPrimaryColor` to `kPrimaryOlive`
   - Change `surface` from `kPaper` to `kSurfacePaper`
   - Change `onSurface` from `kInk` to `kTextPrimary`
   - Change `scaffoldBackgroundColor` from `kPaper` to `kSurfacePaper`
   - Change `error` from `kPrimaryColor` to `kSemanticOverdue`
3. **Update TextTheme** with Young Serif + Space Mono
4. **Add CardTheme** with elevation 0
5. **Add FilledButtonTheme** and **OutlinedButtonTheme**
6. **Add InputDecorationTheme**
7. **Verify Google Fonts load** — no errors on startup
8. **Run `flutter analyze`** — no new errors beyond existing Freezed issue
9. **Run `flutter test`** — all tests pass
10. **Visual smoke test** — app renders with olive theme, not terracotta

### Files to Modify

| File                        | Action | Description                                                      |
| --------------------------- | ------ | ---------------------------------------------------------------- |
| `lib/shared/constants.dart` | MODIFY | Add spacing constants                                            |
| `lib/main.dart`             | MODIFY | Update ThemeData with new colors, typography, button/card themes |

### What NOT to Do

- ❌ Do NOT change the SplashScreen gradient (still uses terracotta — separate story)
- ❌ Do NOT migrate individual widget colors yet (they still use kPrimaryColor, kPaper, kInk — those constants still exist for backward compat)
- ❌ Do NOT add new screens, widgets, or features
- ❌ Do NOT change navigation or business logic

## Testing Requirements

### Manual Testing Checklist

- [ ] App launches without crashes
- [ ] Background color is `#FAF6F1` (kSurfacePaper), not `#F4F1EA` (kPaper)
- [ ] Text color is `#2C2825` (kTextPrimary), not `#2C2C2C` (kInk)
- [ ] Headlines use Young Serif font (wider, more decorative than Inter)
- [ ] Dates/labels use Space Mono font (monospace)
- [ ] Buttons are olive `#6B705C`, not terracotta `#E63819`
- [ ] Cards have no shadow (elevation 0)
- [ ] `flutter analyze` — no new errors
- [ ] `flutter test` — all tests pass

### Regression Testing

Since this story changes the theme globally:

- Verify SplashScreen still renders (gradient may look slightly different — acceptable)
- Verify HomeScreen still renders with IndexedStack
- Verify LedgerScreen renders with new theme
- Verify ArchiveScreen renders with new theme
- Verify PaperBottomNav still renders
- Verify PaperBackground still renders
- Verify all resident colors (blue, pink, purple) still render correctly

## Dependencies

- **Requires:** Story 1.1 (color tokens added to constants.dart)
- **Blocks:** Story 1.3 (Splash Screen), Story 2.x (all feature stories that depend on themed components)

## Risk & Mitigation

| Risk                                            | Impact | Mitigation                                                                                                              |
| ----------------------------------------------- | ------ | ----------------------------------------------------------------------------------------------------------------------- |
| ThemeData change breaks existing widget colors  | Medium | Existing constants (kPrimaryColor, kPaper, kInk) still exist — widgets using them won't break, just won't use new theme |
| Young Serif font fails to load                  | Low    | Google Fonts handles fallback — defaults to Inter if unavailable                                                        |
| Global theme change makes some screens look odd | Low    | Acceptable — individual screens will be updated in their own stories to use the new theme properly                      |

## Dev Notes

- This is a **global theme change** — it affects ALL screens. That's intentional and expected. Individual screens that use hardcoded old colors (kPrimaryColor, kPaper) will look slightly mismatched until they're migrated in their own stories. This is fine.
- The splash screen gradient uses `kPrimaryColor` (terracotta) and `kSlate900` (ink). It will NOT automatically update to olive because it uses a custom gradient, not the theme. That's OK — the splash screen gets its own story.
- `ColorScheme.fromSeed` generates a full palette from the seed color. The olive `#6B705C` will produce a different palette than terracotta `#E63819`. Buttons, toggles, and other M3 components that use `Theme.of(context).colorScheme.primary` will automatically switch to olive tones.
- Components that use hardcoded colors (like `kPrimaryColor` directly) will NOT change. They'll be migrated in their respective stories.

## Definition of Done

- [ ] All acceptance criteria met
- [ ] ThemeData uses kPrimaryOlive, kSurfacePaper, kTextPrimary
- [ ] TextTheme uses Young Serif (headlines), Inter (body), Space Mono (labels)
- [ ] CardTheme elevation = 0
- [ ] Button themes configured (FilledButton olive, OutlinedButton outline)
- [ ] Spacing constants added to constants.dart
- [ ] `flutter analyze` — no new errors
- [ ] `flutter test` — all tests pass
- [ ] App launches and renders with new theme

## Dev Agent Record

### Implementation Plan

1. **Added spacing constants** to `constants.dart` — kSpacingXs=4 through kSpacingXxl=48 ✅
2. **Updated ThemeData** in `main.dart`:
   - `seedColor`: kPrimaryColor → kPrimaryOlive (#6B705C)
   - `surface`: kPaper → kSurfacePaper (#FAF6F1)
   - `onSurface`: kInk → kTextPrimary (#2C2825)
   - `scaffoldBackgroundColor`: kPaper → kSurfacePaper
   - `error`: kPrimaryColor → kSemanticOverdue (#C2654A)
3. **Updated TextTheme** with Young Serif (display/headlines), Inter (body/labels), Space Mono (labelSmall)
4. **Added CardTheme** with elevation 0, border-radius 12px
5. **Added FilledButtonTheme** (olive bg, white text, 56px height) and OutlinedButtonTheme (olive border, 56px)
6. **Added InputDecorationTheme** (filled, rounded borders, olive focus border)
7. **Verified Google Fonts** — Young Serif, Inter, Space Mono all load without errors
8. **Ran `flutter analyze`** — 1 info (use_null_aware_elements), 0 errors ✅
9. **Ran `flutter test`** — 1/1 tests pass ✅

### Completion Notes

Story 1.2 is complete. All acceptance criteria are met:

- ✅ colorScheme uses kPrimaryOlive, kSurfacePaper, kSemanticOverdue
- ✅ TextTheme uses Young Serif (display/headlines), Inter (body/labels), Space Mono (labelSmall)
- ✅ CardTheme elevation = 0
- ✅ FilledButtonTheme configured (olive, 56px, white text)
- ✅ OutlinedButtonTheme configured (olive border, 56px)
- ✅ Spacing constants added to constants.dart
- ✅ `flutter analyze` — 1 info only, no errors
- ✅ `flutter test` — all tests pass
- ✅ App renders with new olive-based theme

## File List

| File                        | Action   | Description                                                                         |
| --------------------------- | -------- | ----------------------------------------------------------------------------------- |
| `lib/shared/constants.dart` | MODIFIED | Added spacing constants (kSpacingXs through kSpacingXxl)                            |
| `lib/main.dart`             | MODIFIED | Full ThemeData migration: olive colors, 3-font typography, card/button/input themes |

## Change Log

- **2026-04-12:** ThemeData migration — terracotta → olive, Inter-only → Young Serif + Inter + Space Mono, added CardTheme/FilledButtonTheme/OutlinedButtonTheme/InputDecorationTheme, spacing constants
