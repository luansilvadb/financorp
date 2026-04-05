---
phase: 01
plan: 01-02
wave: 2
autonomous: true
gap_closure: false
objective: "Integrate Forui.dev by adding dependency, wrapping MaterialApp with FTheme, configuring neutral.dark.touch theme, and setting up pt-BR localization"
files_modified:
  - divi/pubspec.yaml
  - divi/pubspec.lock
  - divi/lib/main.dart
task_count: 5
created: 2026-04-05
status: pending
depends_on:
  - 01-01
---

# Plan 01-02: Forui Integration

## Objective

Add Forui.dev dependency to the project, wrap MaterialApp with FTheme using neutral.dark.touch theme (no customizations), configure FLocalizations for pt-BR only, and verify the theme applies correctly without breaking existing functionality.

This plan builds on Plan 01-01 (Flutter SDK upgrade must be complete first).

## Tasks

### Task 1: Add Forui Dependency

**Action:** Add Forui package to pubspec.yaml dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  forui: ^0.18.0  # Add this line
  # ... rest of dependencies unchanged
```

Then run:
```bash
cd divi
flutter pub get
```

**Expected outcome:** Forui package downloads successfully

**If errors occur:**
- Check for version conflicts
- Verify Flutter SDK is 3.41.0+
- Try `flutter clean` before `flutter pub get`

**Commit:** `chore(deps): add forui ^0.18.0 dependency`

---

### Task 2: Import Forui in main.dart

**Action:** Add Forui import statement at top of main.dart

```dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:forui/forui.dart';  // Add this import

// Rest of imports...
```

**Commit:** `feat(forui): import Forui package in main.dart`

---

### Task 3: Wrap MaterialApp with FTheme

**Action:** Modify CasaApp widget to wrap MaterialApp with FTheme

**Current code (lines ~32-66):**
```dart
@override
Widget build(BuildContext context) {
  return MaterialApp(
    title: 'DIVI',
    debugShowCheckedModeBanner: false,
    scaffoldMessengerKey: scaffoldMessengerKey,
    theme: ThemeData(
      textTheme: GoogleFonts.interTextTheme().apply(
        bodyColor: kInk,
        displayColor: kInk,
      ),
      scaffoldBackgroundColor: kPaper,
      colorScheme: ColorScheme.fromSeed(
        seedColor: kPrimaryColor,
        surface: kPaper,
        onSurface: kInk,
        error: kPrimaryColor,
      ),
    ),
    builder: (context, child) {
      return Stack(
        children: [
          if (child != null) child,
          const PaperBackground(),
        ],
      );
    },
    home: SplashScreen(
      initializationFuture: _initialize(),
      onInitialized: () {},
    ),
  );
}
```

**New code:**
```dart
@override
Widget build(BuildContext context) {
  return FTheme(
    data: FThemeData.fromNeutralDarkTouch(),  // Use neutral.dark.touch theme
    child: MaterialApp(
      title: 'DIVI',
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: scaffoldMessengerKey,
      // Keep existing theme config as fallback (Forui will override most)
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme().apply(
          bodyColor: kInk,
          displayColor: kInk,
        ),
        scaffoldBackgroundColor: kPaper,
        colorScheme: ColorScheme.fromSeed(
          seedColor: kPrimaryColor,
          surface: kPaper,
          onSurface: kInk,
          error: kPrimaryColor,
        ),
      ),
      builder: (context, child) {
        return Stack(
          children: [
            if (child != null) child,
            const PaperBackground(),
          ],
        );
      },
      home: SplashScreen(
        initializationFuture: _initialize(),
        onInitialized: () {},
      ),
    ),
  );
}
```

**Key changes:**
- Wrapped entire MaterialApp with `FTheme` widget
- Set `data: FThemeData.fromNeutralDarkTouch()` for the theme
- Kept existing ThemeData as fallback (Forui will override visual styling)

**Commit:** `feat(forui): wrap MaterialApp with FTheme using neutral.dark.touch`

---

### Task 4: Configure FLocalizations for pt-BR

**Action:** Add localization delegates and supported locales to MaterialApp

**Modify MaterialApp configuration:**
```dart
return FTheme(
  data: FThemeData.fromNeutralDarkTouch(),
  child: MaterialApp(
    title: 'DIVI',
    debugShowCheckedModeBanner: false,
    scaffoldMessengerKey: scaffoldMessengerKey,
    
    // Add localization configuration
    localizationsDelegates: [
      FLocalizations.delegate,  // Forui's delegate (must come first)
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: [
      Locale('pt', 'BR'),  // Portuguese (Brazil) only
    ],
    locale: Locale('pt', 'BR'),  // Force pt-BR locale
    
    // Rest of config unchanged...
    theme: ThemeData(...),
    builder: (context, child) {...},
    home: SplashScreen(...),
  ),
);
```

**Also add import if not present:**
```dart
import 'package:flutter_localizations/flutter_localizations.dart';
```

**Note:** If `flutter_localizations` is not in pubspec.yaml, add it:
```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:  # Add this
    sdk: flutter
  forui: ^0.18.0
  # ... rest
```

**Commit:** `feat(i18n): configure FLocalizations for pt-BR`

---

### Task 5: Visual Verification & Testing

**Action:** Run app and verify Forui theme applies correctly

```bash
cd divi
flutter run -d <device_id>
```

**Visual checklist:**
- [ ] App launches without crashes
- [ ] Dark theme applied (backgrounds should be dark, text light)
- [ ] Typography uses Inter font (from Forui)
- [ ] No console errors about theme or localization
- [ ] Bottom navigation renders correctly
- [ ] Cards and buttons use Forui styling
- [ ] Colors match neutral.dark.touch palette

**Functional checklist:**
- [ ] Switch between Ledger and Archive tabs
- [ ] Data loads from Supabase
- [ ] Bottom sheet forms open/close properly
- [ ] Period navigation works
- [ ] Hot reload works (make small UI change, press 'r')

**If issues found:**
- **Hot reload crashes:** Do full restart instead (`R` in terminal)
- **Theme not applying:** Verify FTheme wraps MaterialApp (not inside)
- **Console errors:** Check FLocalizations.delegate is included
- **Visual glitches:** May be Impeller rendering — test with `--enable-impeller=false`

**Expected outcome:** App runs with Forui's neutral.dark.touch theme applied globally

**Commit:** `test: verify Forui theme application and functionality`

---

## Success Criteria

- [ ] `forui: ^0.18.0` added to pubspec.yaml
- [ ] `flutter pub get` completes without errors
- [ ] FTheme wraps MaterialApp in main.dart
- [ ] Theme set to `FThemeData.fromNeutralDarkTouch()`
- [ ] FLocalizations configured with pt-BR locale
- [ ] App launches without crashes
- [ ] Dark theme visually applied (verify colors)
- [ ] No console errors about theme/localization
- [ ] All core features still work (navigation, data, forms)
- [ ] Hot reload functions correctly

## Verification Steps

1. **Check dependency:**
   ```bash
   grep "forui:" divi/pubspec.yaml
   # Should show: forui: ^0.18.0
   ```

2. **Verify FTheme wrapper:**
   ```bash
   grep -A 2 "FTheme" divi/lib/main.dart
   # Should show FTheme wrapping MaterialApp
   ```

3. **Check localization config:**
   ```bash
   grep "FLocalizations" divi/lib/main.dart
   # Should show FLocalizations.delegate in list
   ```

4. **Visual smoke test:**
   - Run app on emulator
   - Confirm dark theme is active (dark backgrounds, light text)
   - Check typography looks modern/clean (Inter font)
   - Navigate between tabs — verify no visual breakage

5. **Console check:**
   - Open dev console
   - Look for any red error messages
   - Should have zero theme/localization errors

6. **Hot reload test:**
   - Change a text label in any screen
   - Press 'r' in terminal
   - Verify change applies without crash

## Dependencies

- **Depends on:** Plan 01-01 (Flutter SDK Upgrade) must be complete
- Flutter SDK must already be 3.41.0+
- Existing app must compile and run before adding Forui

## Notes

- User explicitly chose NO customizations — use neutral.dark.touch as-is
- Keep google_fonts import for now (will remove in Phase 8)
- If hot reload is unstable after FTheme addition, use full restart
- Don't migrate individual components yet — that's Phase 2+
- Old theme config in ThemeData can stay as fallback during transition
