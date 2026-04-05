---
phase: 01
plan: 01-03
wave: 2
autonomous: true
gap_closure: false
objective: "Validate complete Phase 1 implementation by testing all screens, verifying Riverpod providers and Supabase integration, running release builds, and documenting rollback procedure"
files_modified:
  - .planning/phases/01-flutter-upgrade-foundation/ROLLBACK.md
task_count: 6
created: 2026-04-05
status: pending
depends_on:
  - 01-01
  - 01-02
---

# Plan 01-03: Validation & Rollback Documentation

## Objective

Perform comprehensive validation of the Flutter SDK upgrade and Forui integration by testing all screens, verifying state management (Riverpod) and backend integration (Supabase), running release builds on both platforms, and creating detailed rollback documentation. This plan ensures Phase 1 is production-ready before moving to component migration in Phase 2.

This plan can run in parallel with Plan 01-02 after Plan 01-01 completes, but should execute after 01-02 for final validation.

## Tasks

### Task 1: Comprehensive Screen Testing

**Action:** Test all screens render correctly with Forui theme

```bash
cd divi
flutter run -d <device_id>
```

**Screen checklist:**
- [ ] **SplashScreen**: Shows loading state, transitions to HomeScreen
- [ ] **LedgerScreen (Tab 1)**: 
  - Summary cards display (saldo, totais)
  - Expense list renders with data
  - Person cards show avatars/names
  - Period navigation works (month/year selectors)
- [ ] **ArchiveScreen (Tab 2)**:
  - Historical periods list displays
  - Navigation to archived months works
- [ ] **Bottom Sheets**:
  - FAB opens SpikeModalSheet
  - Form fields render correctly
  - Validation messages display
  - Submit/cancel actions work

**Visual verification:**
- All text readable with dark theme
- Icons visible and appropriate
- Spacing/padding looks correct
- No overflow or layout breakage
- Colors consistent with neutral.dark.touch

**Expected outcome:** All screens functional and visually acceptable

**Commit:** `test: verify all screens render with Forui theme`

---

### Task 2: Riverpod Provider Verification

**Action:** Test that all Riverpod providers continue working after FTheme wrapper

**Test scenarios:**

1. **Period Provider:**
   ```dart
   // In app, change month/year using period navigation
   // Verify: Data updates for selected period
   ```
   - [ ] Change to previous month — expenses update
   - [ ] Change to next month — expenses update
   - [ ] Reset to current month — works correctly

2. **Finance Engine Providers:**
   ```dart
   // Navigate between tabs multiple times
   // Verify: Calculations remain accurate
   ```
   - [ ] Switch Ledger ↔ Archive 10+ times
   - [ ] Summary totals recalculate correctly
   - [ ] No stale data or memory leaks

3. **State Persistence:**
   ```dart
   // Add expense (if form works), navigate away, come back
   // Verify: New expense appears in list
   ```
   - [ ] State persists across navigation
   - [ ] No provider errors in console
   - [ ] AsyncNotifiers load data correctly

**Console monitoring:**
- Watch for Riverpod-related errors
- Check for excessive rebuilds
- Monitor memory usage (should be stable)

**Expected outcome:** All providers function identically to pre-Forui behavior

**Commit:** `test: verify Riverpod providers work with FTheme wrapper`

---

### Task 3: Supabase Integration Testing

**Action:** Verify backend integration still operational

**Test real data operations:**

1. **Data Fetching:**
   - [ ] Expenses load from Supabase on app start
   - [ ] Person data fetches correctly
   - [ ] Card transactions display
   - [ ] Historical data loads in Archive screen

2. **Data Consistency:**
   - [ ] Totals match database values
   - [ ] Balances calculate correctly
   - [ ] No missing or duplicate records

3. **Error Handling:**
   - [ ] Network errors handled gracefully
   - [ ] Loading states show during fetch
   - [ ] Retry mechanisms work (if implemented)

**Verification method:**
- Compare app data with Supabase dashboard
- Check network tab in DevTools for API calls
- Verify authentication state persists

**Expected outcome:** Full Supabase integration operational with no regressions

**Commit:** `test: verify Supabase integration remains functional`

---

### Task 4: Release Build Testing

**Action:** Build release versions for both platforms

**Android Release Build:**
```bash
cd divi
flutter build apk --release
```

**Expected output:** `build/app/outputs/flutter-apk/app-release.apk`

**iOS Release Build (Mac only):**
```bash
flutter build ios --release
```

**Expected output:** iOS archive ready for TestFlight/App Store

**Quality checks:**
- [ ] Build completes without errors
- [ ] No critical warnings in build output
- [ ] APK size reasonable (<50MB typical)
- [ ] Install APK on physical device
- [ ] App launches and runs smoothly
- [ ] Performance acceptable (no jank)

**If build fails:**
- Review error messages carefully
- Check platform-specific configs (build.gradle, Podfile)
- May need to update Gradle/Kotlin versions for Android
- May need to update Xcode settings for iOS

**Performance monitoring:**
- Frame rate should stay at 60fps
- No excessive memory usage
- Cold start time <3 seconds
- Tab switching instant

**Expected outcome:** Release builds succeed and run smoothly on devices

**Commit:** `build: verify release builds for Android and iOS`

---

### Task 5: Comprehensive Rollback Documentation

**Action:** Create detailed rollback guide in ROLLBACK.md

**Update/Create file:** `.planning/phases/01-flutter-upgrade-foundation/ROLLBACK.md`

```markdown
# Phase 1 Rollback Procedures

## Quick Rollback (Complete Revert)

If critical issues occur after Phase 1 completion:

```bash
# Revert to pre-upgrade state
git checkout v1.0-pre-forui
cd divi
flutter clean
flutter pub get
flutter run
```

This restores Flutter ^3.1.0 and removes Forui completely.

---

## Partial Rollback Scenarios

### Scenario A: Keep Flutter 3.41.0+, Remove Forui

If Forui causes issues but Flutter upgrade is stable:

1. **Remove Forui dependency:**
   ```yaml
   # divi/pubspec.yaml
   dependencies:
     # forui: ^0.18.0  # Comment out or delete
   ```

2. **Remove FTheme wrapper:**
   ```dart
   // divi/lib/main.dart
   // Remove FTheme wrapper, keep MaterialApp as root
   @override
   Widget build(BuildContext context) {
     return MaterialApp(  // No FTheme wrapper
       // ... rest of config
     );
   }
   ```

3. **Remove localization imports:**
   ```dart
   // Remove: import 'package:flutter_localizations/flutter_localizations.dart';
   // Remove FLocalizations.delegate from delegates list
   ```

4. **Clean and rebuild:**
   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

### Scenario B: Revert Flutter SDK Only

If Flutter 3.41.0+ causes issues (before adding Forui):

```bash
git checkout v1.0-pre-forui
```

Or manually revert:
```yaml
# divi/pubspec.yaml
environment:
  sdk: ^3.1.0  # Revert to original
```

Then:
```bash
flutter clean
flutter pub get
flutter run
```

---

## Known Issues & Workarounds

### Issue 1: Hot Reload Crashes After FTheme Addition

**Symptom:** App crashes when pressing 'r' for hot reload

**Workaround:** Use full restart instead
```bash
# In flutter run terminal, press 'R' (capital) for full restart
```

**Permanent fix:** None needed — hot reload stabilizes after initial setup

---

### Issue 2: Impeller Rendering Glitches (iOS)

**Symptom:** Visual artifacts, missing shadows/gradients on iOS

**Workaround:** Disable Impeller temporarily
```bash
flutter run --enable-impeller=false
```

**Permanent fix:** Update to latest Flutter patch or report to Flutter team

---

### Issue 3: Theme Not Applying

**Symptom:** App still shows old paper/skeuomorphic theme

**Check:**
1. FTheme wraps MaterialApp (not inside it)
2. `FThemeData.fromNeutralDarkTouch()` is set
3. No conflicting ThemeData overrides

**Fix:** Verify main.dart structure matches Plan 01-02 Task 3

---

### Issue 4: Dependency Conflicts

**Symptom:** `flutter pub get` fails with version conflicts

**Solution:**
```bash
flutter pub outdated  # See available updates
flutter pub upgrade   # Update to latest compatible versions
```

If specific package conflicts:
- Check package changelog for Flutter 3.41.0+ compatibility
- Temporarily pin to older version if needed
- Report issue to package maintainer

---

## Diagnostic Checklist

Before rolling back, gather this information:

- [ ] Error messages from console
- [ ] Steps to reproduce the issue
- [ ] Which plan caused the problem (01-01, 01-02, or 01-03)
- [ ] Platform affected (Android, iOS, or both)
- [ ] Severity (blocks development, or minor inconvenience)

Report findings to help improve future migrations.

---

## When to Rollback

**Immediate rollback triggers:**
- App fails to launch after changes
- Critical runtime errors on startup
- Data loss or corruption
- Multiple core features broken
- Performance degradation >50%

**Continue with fixes:**
- Minor visual glitches
- Single feature affected (can workaround)
- Hot reload instability (use full restart)
- Non-critical warnings in console

---

## Support Resources

- Flutter Migration Guide: https://docs.flutter.dev/release/breaking-changes
- Forui.dev Docs: https://forui.dev/docs
- Project CONTEXT.md: `.planning/phases/01-flutter-upgrade-foundation/01-CONTEXT.md`
- Research notes: `.planning/phases/01-flutter-upgrade-foundation/01-RESEARCH.md`
```

**Commit:** `docs: create comprehensive rollback documentation`

---

### Task 6: Final Validation Summary

**Action:** Create validation summary document

**Create file:** `.planning/phases/01-flutter-upgrade-foundation/01-VALIDATION-SUMMARY.md`

```markdown
# Phase 1 Validation Summary

**Date:** 2026-04-05  
**Validator:** gsd-executor agent  
**Status:** [PENDING - Fill after execution]

## Test Results

### Flutter SDK Upgrade (Plan 01-01)
- [ ] SDK constraint updated to ^3.41.0
- [ ] Dependencies resolved without errors
- [ ] Static analysis clean (0 errors)
- [ ] Debug build succeeds
- [ ] Runtime smoke test passed
- [ ] Git tag v1.0-pre-forui created

### Forui Integration (Plan 01-02)
- [ ] Forui dependency added (^0.18.0)
- [ ] FTheme wraps MaterialApp
- [ ] neutral.dark.touch theme applied
- [ ] FLocalizations configured for pt-BR
- [ ] Visual verification passed
- [ ] Hot reload functional

### Comprehensive Validation (Plan 01-03)
- [ ] All screens render correctly
- [ ] Riverpod providers working
- [ ] Supabase integration operational
- [ ] Android release build succeeds
- [ ] iOS release build succeeds (if Mac available)
- [ ] Rollback documentation complete

## Issues Encountered

*(List any issues found during validation, or "None")*

## Performance Metrics

- Cold start time: ___ seconds
- Frame rate: ___ fps (target: 60)
- APK size: ___ MB
- Memory usage: ___ MB

## Recommendation

[ ] **APPROVED** — Phase 1 complete, ready for Phase 2  
[ ] **CONDITIONAL** — Minor issues, can proceed with caution  
[ ] **REJECTED** — Critical issues, must fix before proceeding  

## Notes

*(Any additional observations or recommendations)*
```

**Fill out this document after completing all tests**

**Commit:** `docs: create validation summary for Phase 1`

---

## Success Criteria

- [ ] All screens tested and rendering correctly
- [ ] Riverpod providers verified (navigation, state persistence)
- [ ] Supabase integration confirmed (data fetches, consistency)
- [ ] Android release build succeeds
- [ ] iOS release build succeeds (or documented why not)
- [ ] ROLLBACK.md comprehensive and tested
- [ ] VALIDATION-SUMMARY.md completed with results
- [ ] No critical blockers identified
- [ ] Performance acceptable (60fps, <3s cold start)

## Verification Steps

1. **Screen coverage check:**
   - Manually navigate to every screen
   - Confirm each renders without errors
   - Screenshot key screens for documentation

2. **Provider stress test:**
   - Switch tabs 20+ times rapidly
   - Change periods multiple times
   - Open/close forms repeatedly
   - Monitor console for errors

3. **Backend verification:**
   - Check Supabase dashboard for recent queries
   - Verify data matches between app and database
   - Test offline mode (if implemented)

4. **Build artifacts:**
   ```bash
   ls -lh divi/build/app/outputs/flutter-apk/app-release.apk
   # Should exist and be <50MB typically
   ```

5. **Documentation review:**
   - Read ROLLBACK.md — are steps clear?
   - Test rollback procedure on copy of repo
   - Verify VALIDATION-SUMMARY.md is complete

## Dependencies

- **Depends on:** Plan 01-01 (Flutter SDK Upgrade) — must be complete
- **Depends on:** Plan 01-02 (Forui Integration) — should be complete for full validation
- Can partially execute after 01-01 (test SDK upgrade alone)
- Full validation requires both 01-01 and 01-02 complete

## Notes

- This is the gate before Phase 2 — don't skip validation
- If issues found, fix them before marking Phase 1 complete
- Document everything for future reference
- Take screenshots of working app for comparison with Phase 2
- If iOS build not possible (no Mac), document limitation
