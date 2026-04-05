# Phase 01: Flutter Upgrade & Foundation - Research

**Researched:** 2026-04-05  
**Status:** Complete  
**Researcher:** gsd-phase-researcher (simulated)

---

## 1. Flutter 3.41.0+ Breaking Changes

### Major Changes from 3.1.0 to 3.41.0+

**Dart SDK Changes:**
- Dart upgraded from ~3.1 to ~3.9+ — significant language improvements
- Pattern matching enhancements (when clauses, sealed classes)
- Record types now stable
- Class modifiers (base, final, interface, sealed) fully supported

**Flutter Framework Changes:**
- **Material 3 is now default** — Material 2 deprecated but still available
- **Impeller rendering engine** — Now default on iOS, optional on Android
  - May cause visual differences in custom painters/shaders
  - Test all custom UI components thoroughly
- **Platform view changes** — Improved performance but may affect native integrations
- **Text rendering updates** — Some text layout edge cases may differ slightly

**Common Migration Pitfalls:**
1. **Deprecated APIs removed**: Check for usage of removed widgets/methods
   - `WillPopScope` → use `PopScope` instead
   - Some `ThemeData` properties renamed/restructured
2. **Null safety refinements**: Stricter type checking may expose latent issues
3. **Plugin compatibility**: Many plugins need updates for newer Flutter versions
4. **Build system changes**: Gradle/Kotlin versions may need updating for Android

**Action Required:**
- Run `flutter analyze` after upgrade to catch deprecated API usage
- Test on both iOS and Android emulators
- Verify all custom paint/shader effects work with Impeller

---

## 2. Forui.dev Integration Patterns

### FTheme Wrapper Setup

**Correct Approach:**
```dart
import 'package:forui/forui.dart';

void main() {
  runApp(
    ProviderScope(
      child: FApp(  // or wrap MaterialApp with FTheme
        theme: FThemeData.fromNeutralDarkTouch(),
        child: MyApp(),
      ),
    ),
  );
}
```

**Key Points:**
- FTheme should wrap the **entire app**, not individual screens
- Use `FTheme.of(context)` to access theme data in widgets
- Forui provides its own localization system — may conflict with Flutter's if not configured properly

**Known Issues:**
1. **Hot reload limitations**: Theme changes may require full restart initially
2. **Custom widget compatibility**: Some custom widgets may need adaptation to work with Forui's styling system
3. **Icon integration**: Forui has its own icon set — phosphor_flutter icons will need replacement strategy

**Best Practices:**
- Start with minimal FTheme configuration
- Gradually migrate components rather than all at once
- Keep fallback paths for critical UI elements during transition

---

## 3. FLocalizations Setup

### Single Language (pt-BR) Configuration

**Required Setup:**
```dart
import 'package:forui/forui.dart';

MaterialApp(
  localizationsDelegates: [
    FLocalizations.delegate,  // Forui's localization delegate
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: [
    Locale('pt', 'BR'),  // Portuguese (Brazil)
  ],
  locale: Locale('pt', 'BR'),  // Force pt-BR
  // ... rest of config
)
```

**Important Notes:**
- Forui provides translations for common UI strings (buttons, dialogs, etc.)
- Your app-specific strings still need manual translation via arb files or similar
- FLocalizations.delegate MUST come before Flutter's delegates
- If you only support pt-BR, you can skip dynamic locale switching logic

**Potential Conflicts:**
- If existing code uses `intl` package for formatting, ensure it doesn't conflict with Forui's localization
- Date/number formatting may need explicit locale specification

---

## 4. Dependency Compatibility

### Current Dependencies Analysis

**✅ Compatible (likely no changes needed):**
- `flutter_riverpod ^2.4.10` — Should work with Flutter 3.41.0+
- `supabase_flutter ^2.12.0` — Generally compatible, may have minor updates available
- `freezed ^2.5.2` + `json_serializable ^6.7.1` — Compatible, code generation works fine
- `flutter_dotenv ^6.0.0` — No Flutter-specific dependencies, safe
- `intl ^0.20.2` — Compatible, widely used

**⚠️ Needs Verification:**
- `google_fonts ^6.3.0` — May have updates for newer Flutter, but should work
- `phosphor_flutter ^2.1.0` — Icon package, should work but will be replaced anyway
- `animations ^2.0.11` — Google's animation library, compatible but being removed
- `cupertino_icons ^1.0.8` — Standard, no issues expected
- `dotted_line ^3.2.3` — Simple widget, should work fine
- `app_links ^6.4.1` — Deep linking, verify after upgrade

**🔴 Potential Issues:**
- None identified as critical blockers

**Recommended Version Updates (after initial upgrade):**
```yaml
# Check for latest versions after Flutter upgrade
flutter_riverpod: ^2.6.0  # If available
supabase_flutter: ^2.15.0  # If available
freezed: ^2.5.7  # Latest patch
```

**Action Plan:**
1. Upgrade Flutter SDK first
2. Run `flutter pub outdated` to see available updates
3. Update dependencies incrementally, testing after each
4. Add Forui last, after core dependencies are stable

---

## 5. Migration Strategy

### Recommended Order of Operations

**Phase 1A: Foundation (Safe)**
1. Create feature branch: `git checkout -b feature/flutter-upgrade-forui`
2. Update Flutter SDK constraint in pubspec.yaml: `sdk: ^3.41.0`
3. Run `flutter pub get` — resolve any immediate conflicts
4. Run `flutter analyze` — identify deprecated API usage
5. Fix any breaking changes found
6. Test app compiles and runs (existing UI)
7. Commit: "chore: upgrade Flutter SDK to 3.41.0+"

**Phase 1B: Forui Integration**
8. Add `forui: ^0.18.0` to pubspec.yaml
9. Run `flutter pub get`
10. Wrap MaterialApp with FTheme in main.dart
11. Configure FLocalizations for pt-BR
12. Apply neutral.dark.touch theme
13. Test app runs with new theme wrapper
14. Verify hot reload works
15. Commit: "feat: integrate Forui.dev with neutral.dark.touch theme"

**Phase 1C: Validation & Documentation**
16. Test all screens render correctly
17. Test Riverpod providers (navigate between tabs)
18. Test Supabase integration (fetch real data)
19. Run release build: `flutter build apk --release` (Android) / `flutter build ios` (iOS)
20. Document rollback procedure
21. Create rollback branch/tag
22. Commit: "docs: add rollback documentation and validation results"

**Why This Order:**
- Isolates risks — if Flutter upgrade breaks something, you know it's not Forui
- Easier debugging — fewer variables changing at once
- Clear rollback points — can revert to pre-Forui state if needed
- Validates incrementally — catch issues early

---

## 6. Testing Approach

### Critical Test Checklist

**After Flutter SDK Upgrade:**
```bash
# 1. Basic compilation
flutter clean
flutter pub get
flutter analyze

# 2. Run on emulator
flutter run -d <device_id>

# 3. Test core functionality
- Navigate between Ledger and Archive tabs
- Add/edit/delete expense (if forms work)
- Verify data loads from Supabase
- Check period navigation (month/year selectors)

# 4. Build test
flutter build apk --debug  # Android
flutter build ios --debug  # iOS (Mac only)
```

**After FTheme Integration:**
```bash
# 1. Visual verification
- Check colors match neutral.dark.touch theme
- Verify typography is Inter font (from Forui)
- Ensure no console errors about theme

# 2. Hot reload test
- Make small UI change
- Hot reload (r in terminal)
- Verify change applies without crash

# 3. State management test
- Navigate between tabs multiple times
- Verify Riverpod state persists
- Check FinanceEngine calculations still work

# 4. Performance check
- Monitor frame rate (should stay at 60fps)
- Check for excessive rebuilds (use Flutter DevTools)
```

**Automated Tests (if exist):**
```bash
flutter test  # Run unit tests
flutter test --coverage  # With coverage
```

**Manual QA Scenarios:**
1. Cold start app — does it load correctly?
2. Switch between tabs 10+ times — any memory leaks?
3. Add expense with bottom sheet — does form open/close properly?
4. Change month/year — does data update correctly?
5. Pull to refresh (if implemented) — does it work?
6. Background/foreground app — does state persist?

---

## 7. Rollback Procedures

### Safe Rollback Strategy

**Option 1: Git Revert (Recommended)**
```bash
# Before starting, create a restore point
git tag v1.0-pre-upgrade

# If issues found after upgrade:
git checkout v1.0-pre-upgrade
# Or revert specific commits:
git revert <commit-hash>
```

**Option 2: Feature Branch Isolation**
```bash
# Work on feature branch
git checkout -b feature/flutter-upgrade-forui

# If critical issues:
git checkout main  # Abandon feature branch
git branch -D feature/flutter-upgrade-forui  # Delete if needed
```

**Option 3: Dependency Rollback**
```yaml
# If Forui causes issues, remove it temporarily:
# pubspec.yaml
dependencies:
  # forui: ^0.18.0  # Comment out or remove
  
# Then:
flutter pub get
flutter run
```

**Rollback Documentation Template:**
```markdown
## Rollback Procedure

If critical issues occur after Flutter/Forui upgrade:

1. **Immediate rollback:**
   ```bash
   git checkout v1.0-pre-upgrade
   flutter clean
   flutter pub get
   flutter run
   ```

2. **Partial rollback (keep Flutter, remove Forui):**
   - Remove `forui` from pubspec.yaml
   - Remove FTheme wrapper from main.dart
   - Remove FLocalizations configuration
   - Run `flutter pub get`

3. **Verify rollback:**
   - App compiles and runs
   - All screens render correctly
   - Data loads from Supabase
   - No console errors

4. **Report issues:**
   - Document what broke
   - Include error messages/logs
   - Note steps to reproduce
   - Suggest alternative approach
```

**Critical Rollback Triggers:**
- App fails to compile after fixes
- Critical runtime errors on startup
- Data loss or corruption
- Performance degradation >50%
- Multiple core features broken

---

## 8. Known Pitfalls & Watch-outs

### Common Issues in Flutter Major Upgrades

**1. Plugin Incompatibility**
- **Symptom:** `flutter pub get` fails or runtime errors
- **Solution:** Check plugin changelogs, update to latest versions
- **Prevention:** Review `flutter pub outdated` before upgrading

**2. Deprecated API Removal**
- **Symptom:** Compilation errors for previously working code
- **Solution:** Replace deprecated APIs (Flutter migration guide helps)
- **Prevention:** Run `flutter analyze` immediately after upgrade

**3. Platform-Specific Issues**
- **Symptom:** Works on Android but not iOS (or vice versa)
- **Solution:** Test on both platforms early
- **Prevention:** Don't assume cross-platform parity

**4. Theme/Styling Breakage**
- **Symptom:** UI looks wrong after Material 3 adoption
- **Solution:** Explicitly set Material 2 if needed, or adapt to Material 3
- **Prevention:** Forui handles this — use their theme system consistently

**5. Build System Changes**
- **Symptom:** Android/iOS build fails after Flutter upgrade
- **Solution:** Update Gradle/Kotlin/Xcode settings as prompted
- **Prevention:** Follow Flutter's migration guide for platform changes

**6. Hot Reload Instability**
- **Symptom:** Hot reload causes crashes or weird behavior
- **Solution:** Full restart instead of hot reload for major changes
- **Prevention:** Restart app after adding FTheme wrapper

**7. Performance Regressions**
- **Symptom:** App feels slower, janky animations
- **Solution:** Profile with DevTools, optimize rebuilds
- **Prevention:** Monitor frame rate during testing

**8. Impeller Rendering Issues (iOS)**
- **Symptom:** Visual glitches, missing shadows/gradients
- **Solution:** Disable Impeller temporarily: `--enable-impeller=false`
- **Prevention:** Test with both Impeller enabled/disabled

---

## Summary & Recommendations

### Key Takeaways

1. **Upgrade order matters:** Flutter SDK → fix issues → add Forui → validate
2. **Test incrementally:** Don't make multiple big changes before testing
3. **Branch strategy:** Use feature branches for easy rollback
4. **Platform testing:** Test on both Android and iOS throughout
5. **Documentation:** Document what works and what doesn't for future reference

### Risk Assessment

**Low Risk:**
- Adding Forui dependency
- Wrapping MaterialApp with FTheme
- Configuring FLocalizations

**Medium Risk:**
- Flutter SDK major version jump (3.1 → 3.41)
- Dependency version updates
- Theme system change

**High Risk:**
- Removing old dependencies too early
- Migrating all components at once (not in Phase 1 scope)
- Skipping testing steps

### Success Factors

✅ Incremental approach with clear checkpoints  
✅ Comprehensive testing after each step  
✅ Rollback plan documented and tested  
✅ Feature branch isolation  
✅ Both platforms tested throughout  

---

## References

- Flutter 3.41.0 Release Notes: https://docs.flutter.dev/release/release-notes
- Forui.dev Documentation: https://forui.dev/docs
- Flutter Migration Guide: https://docs.flutter.dev/release/breaking-changes
- Material 3 Migration: https://docs.flutter.dev/ui/design/material/index
