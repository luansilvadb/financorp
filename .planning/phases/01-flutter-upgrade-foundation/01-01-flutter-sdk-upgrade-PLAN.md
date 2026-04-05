---
phase: 01
plan: 01-01
wave: 1
autonomous: true
gap_closure: false
objective: "Upgrade Flutter SDK from ^3.1.0 to 3.41.0+ and resolve any breaking changes or dependency conflicts"
files_modified:
  - divi/pubspec.yaml
  - divi/pubspec.lock
task_count: 6
created: 2026-04-05
status: pending
---

# Plan 01-01: Flutter SDK Upgrade

## Objective

Upgrade Flutter SDK constraint from ^3.1.0 to 3.41.0+ in pubspec.yaml, resolve dependency conflicts, fix any breaking changes, and verify the app still compiles and runs with existing UI components.

This is the foundation step — must complete successfully before adding Forui.dev.

## Tasks

### Task 1: Update SDK Constraint

**Action:** Modify `divi/pubspec.yaml` environment section to require Flutter 3.41.0+

```yaml
environment:
  sdk: ^3.41.0  # Changed from ^3.1.0
```

**Commit:** `chore(infra): upgrade Flutter SDK constraint to 3.41.0+`

---

### Task 2: Resolve Dependencies

**Action:** Run dependency resolution and check for conflicts

```bash
cd divi
flutter clean
flutter pub get
```

**Expected outcome:** All dependencies resolve without errors

**If conflicts occur:**
- Check `flutter pub outdated` for available updates
- Update incompatible dependencies incrementally
- Test after each update

**Commit:** `chore(deps): resolve dependencies for Flutter 3.41.0+`

---

### Task 3: Static Analysis

**Action:** Run Flutter analyzer to identify deprecated APIs and issues

```bash
flutter analyze
```

**Expected outcome:** No errors (warnings acceptable if non-critical)

**If errors found:**
- Fix deprecated API usage (e.g., `WillPopScope` → `PopScope`)
- Update code to match new Flutter conventions
- Re-run analyze until clean

**Commit:** `refactor: fix deprecated APIs for Flutter 3.41.0+`

---

### Task 4: Compilation Test

**Action:** Verify app compiles in debug mode

```bash
flutter build apk --debug    # Android
# OR
flutter build ios --debug    # iOS (Mac only)
```

**Expected outcome:** Build succeeds without errors

**If build fails:**
- Review error messages carefully
- Fix compilation issues
- May need to update platform-specific configs (Gradle, Podfile)

**Commit:** `build: verify debug compilation with Flutter 3.41.0+`

---

### Task 5: Runtime Verification

**Action:** Run app on emulator/device and test core functionality

```bash
flutter run -d <device_id>
```

**Test checklist:**
- [ ] App launches without crashes
- [ ] SplashScreen shows and transitions to HomeScreen
- [ ] Bottom navigation works (switch between Ledger and Archive tabs)
- [ ] Data loads from Supabase (verify expenses display)
- [ ] Period navigation works (change month/year)
- [ ] Bottom sheet forms open (tap FAB button)
- [ ] Hot reload works (make small change, press 'r')

**Expected outcome:** All core features work as before

**Commit:** `test: verify runtime functionality after SDK upgrade`

---

### Task 6: Create Restore Point

**Action:** Create git tag for easy rollback if needed

```bash
git tag v1.0-pre-forui
git push origin v1.0-pre-forui  # If remote configured
```

**Also document:** Add rollback note to phase directory

Create file: `.planning/phases/01-flutter-upgrade-foundation/ROLLBACK.md`

```markdown
# Rollback Instructions

If issues occur after Flutter SDK upgrade:

```bash
git checkout v1.0-pre-forui
cd divi
flutter clean
flutter pub get
flutter run
```

This restores the app to pre-upgrade state with Flutter ^3.1.0.
```

**Commit:** `docs: create restore point and rollback documentation`

---

## Success Criteria

- [ ] pubspec.yaml has `sdk: ^3.41.0`
- [ ] `flutter pub get` completes without errors
- [ ] `flutter analyze` shows no errors
- [ ] App compiles in debug mode (Android or iOS)
- [ ] App runs on emulator/device without crashes
- [ ] All core features functional (navigation, data loading, forms)
- [ ] Hot reload works correctly
- [ ] Git tag `v1.0-pre-forui` created
- [ ] ROLLBACK.md documented

## Verification Steps

1. **Check SDK version:**
   ```bash
   grep "sdk:" divi/pubspec.yaml
   # Should show: sdk: ^3.41.0
   ```

2. **Verify dependencies resolved:**
   ```bash
   cd divi && flutter pub get
   # Should complete without errors
   ```

3. **Run static analysis:**
   ```bash
   flutter analyze
   # Should show 0 errors
   ```

4. **Manual smoke test:**
   - Launch app on emulator
   - Navigate between tabs
   - Verify data displays
   - Open bottom sheet form
   - Confirm no console errors

5. **Check git tag:**
   ```bash
   git tag -l | grep v1.0-pre-forui
   # Should show the tag
   ```

## Dependencies

- None (this is Wave 1, first plan to execute)

## Notes

- Keep google_fonts, phosphor_flutter, animations dependencies — they will be removed in Phase 8
- Don't add Forui yet — that's Plan 01-02
- Focus on making sure existing app works with new SDK
- If critical issues found, use rollback procedure before proceeding to Plan 01-02
