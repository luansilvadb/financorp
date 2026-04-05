# Pitfalls Research - Forui.dev Migration

## Critical Pitfalls & Prevention Strategies

### 1. Flutter Version Incompatibility ⚠️ HIGH SEVERITY

**Pitfall:** Forui 0.18.0+ requires Flutter 3.41.0+, but project uses ^3.1.0. Upgrading Flutter can break other dependencies.

**Warning Signs:**
- `flutter pub get` fails with version conflicts
- Other packages incompatible with Flutter 3.41+
- Build errors after Flutter upgrade

**Prevention:**
1. Check all dependencies for Flutter 3.41+ compatibility BEFORE upgrading
2. Run `flutter pub outdated` to identify potential conflicts
3. Test upgrade in separate branch first
4. Have rollback plan (git branch backup)

**Recovery:** If upgrade breaks things:
- Pin Flutter to highest compatible version
- Consider Forui 0.17.x (may support older Flutter)
- Evaluate alternative UI libraries

**Phase to Address:** Phase 1 (Foundation) - before any Forui integration

---

### 2. Breaking Theme Assumptions ⚠️ HIGH SEVERITY

**Pitfall:** Forui's theme system differs significantly from custom paper theme. Hardcoded colors/sizes will break.

**Warning Signs:**
- Widgets render with wrong colors
- Spacing looks incorrect
- Typography inconsistent
- Dark mode doesn't work

**Prevention:**
1. Audit all hardcoded colors/sizes before migration
2. Map custom theme values to Forui theme tokens
3. Use Forui's theme system exclusively (no mixing)
4. Test both light and dark modes early

**Recovery:** 
- Create custom Forui theme if presets don't match needs
- Use theme overrides sparingly for edge cases

**Phase to Address:** Phase 1-2 (Foundation + Base Components)

---

### 3. Bottom Sheet Modal Regression ⚠️ MEDIUM-HIGH SEVERITY

**Pitfall:** Current app relies heavily on bottom sheet modals (SpikeModalSheet). Forui's FDialog may not replicate exact behavior.

**Warning Signs:**
- Modal animation feels wrong
- Gesture handling broken (swipe to dismiss)
- Keyboard interaction issues
- Content overflow in modal

**Prevention:**
1. Test FDialog thoroughly against current bottom sheet behavior
2. If FDialog insufficient, keep custom bottom sheet implementation
3. Hybrid approach: Forui widgets inside custom modal container
4. Document any UX differences for stakeholder approval

**Recovery:**
- Revert to custom bottom sheet for specific use cases
- File issue with Forui maintainers if bug

**Phase to Address:** Phase 4 (Forms & Modals)

---

### 4. Riverpod Provider Conflicts ⚠️ MEDIUM SEVERITY

**Pitfall:** Improper FTheme placement can interfere with ProviderScope or cause unnecessary rebuilds.

**Warning Signs:**
- Providers rebuild unexpectedly
- Theme changes don't propagate
- State lost during navigation
- Performance degradation

**Prevention:**
1. Place FTheme BELOW ProviderScope in widget tree
2. Use const constructors where possible
3. Avoid wrapping individual widgets with FTheme (use root level only)
4. Monitor rebuild count with Riverpod devtools

**Correct Structure:**
```dart
ProviderScope(
  child: MaterialApp(
    builder: (_, child) => FTheme(
      data: theme,
      child: child!,
    ),
  ),
)
```

**Recovery:** Refactor widget tree to correct FTheme placement

**Phase to Address:** Phase 1 (Foundation)

---

### 5. Performance Regression in Lists ⚠️ MEDIUM SEVERITY

**Pitfall:** Forui widgets may have different performance characteristics than custom widgets, especially in long lists.

**Warning Signs:**
- Scroll jank in expense lists
- Increased frame build time
- Memory usage spike
- Slow navigation between tabs

**Prevention:**
1. Profile list performance before and after migration
2. Use ListView.builder (not ListView) for dynamic lists
3. Keep widgets const where possible
4. Avoid deep nesting of Forui widgets
5. Test with realistic data volumes (100+ items)

**Recovery:**
- Optimize widget structure
- Consider keeping custom widgets for performance-critical lists
- Implement pagination if needed

**Phase to Address:** Phase 5 (Screens & Polish)

---

### 6. Localization Breakage ⚠️ MEDIUM SEVERITY

**Pitfall:** Adding FLocalizations delegates can conflict with existing localization setup or break if not configured properly.

**Warning Signs:**
- App crashes on launch
- Text displays as keys instead of translations
- Locale switching stops working

**Prevention:**
1. Review current localization setup
2. Merge FLocalizations delegates with existing delegates
3. Test all supported locales
4. Verify fallback locale works

**Recovery:** Fix delegate ordering or remove FLocalizations if not needed

**Phase to Address:** Phase 1 (Foundation)

---

### 7. Icon System Conflicts ⚠️ LOW-MEDIUM SEVERITY

**Pitfall:** Mixing phosphor_flutter icons with Forui Icons can cause inconsistency or bloat.

**Warning Signs:**
- Two icon packs in bundle (increased app size)
- Visual inconsistency between icon sets
- Icon rendering issues

**Prevention:**
1. Audit all icon usage
2. Map phosphor icons to Forui Icons equivalents
3. Remove phosphor_flutter dependency after migration
4. Use Forui Icons exclusively

**Recovery:** Keep phosphor_flutter temporarily during transition, remove after full migration

**Phase to Address:** Phase 2 (Base Components)

---

### 8. Contract Violations ⚠️ MEDIUM SEVERITY

**Pitfall:** Changing widget APIs during migration breaks callers, violating "preserve contracts" requirement.

**Warning Signs:**
- Compilation errors in calling code
- Runtime exceptions from missing parameters
- Broken widget compositions

**Prevention:**
1. Maintain same public API for migrated widgets
2. Use adapter pattern: custom widget wraps Forui widget internally
3. Update callers incrementally, not all at once
4. Comprehensive regression testing

**Example Adapter:**
```dart
// Before: CustomCard(title, subtitle, child)
// After: Still accepts same params, uses FCard internally
class CustomCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  
  Widget build(BuildContext context) {
    return FCard(
      child: Column(
        children: [
          Text(title),
          if (subtitle != null) Text(subtitle!),
          child,
        ],
      ),
    );
  }
}
```

**Recovery:** Revert breaking changes, implement proper adapters

**Phase to Address:** All phases (ongoing concern)

---

### 9. Bundle Size Increase ⚠️ LOW SEVERITY

**Pitfall:** Adding Forui increases app bundle size (~200-300KB).

**Warning Signs:**
- APK/IPA size grows significantly
- Download times increase
- Storage concerns for users

**Prevention:**
1. Measure bundle size before/after
2. Enable tree shaking (Flutter does this automatically)
3. Remove old UI dependencies promptly
4. Consider code splitting if available

**Recovery:** Usually acceptable tradeoff for better UX. If critical, optimize other assets.

**Phase to Address:** Phase 6 (Cleanup)

---

### 10. Insufficient Testing Coverage ⚠️ HIGH SEVERITY

**Pitfall:** Migrating without adequate tests leads to regressions in financial calculations or data display.

**Warning Signs:**
- Bugs found in production
- Manual testing misses edge cases
- Stakeholders report issues post-deployment

**Prevention:**
1. Write widget tests for critical screens BEFORE migration
2. Create golden tests for key UI components
3. Implement integration tests for core user flows
4. Perform manual QA on every phase
5. Beta test with real users before full rollout

**Critical Flows to Test:**
- Adding/editing expenses
- Payment processing
- Period navigation
- Archive access
- Card purchase management

**Recovery:** Emergency hotfixes, but prevention is far better

**Phase to Address:** All phases (testing parallel to development)

---

## Integration-Specific Pitfalls

### Riverpod + Forui Integration

**Issue:** None expected. Forui is purely presentational and doesn't interfere with state management.

**Verification:** Test that providers continue working after FTheme integration.

### Supabase + Forui Integration

**Issue:** None expected. Backend layer unaffected by UI changes.

**Verification:** Ensure all API calls work normally after migration.

### Finance Engine + Forui Integration

**Issue:** None expected. Engine outputs feed into widgets regardless of widget type.

**Verification:** Confirm calculations display correctly in Forui widgets.

---

## Rollback Strategy

If migration fails critically:

1. **Immediate Rollback:**
   - Revert to pre-migration git branch
   - Remove Forui dependency
   - Restore old UI dependencies

2. **Partial Rollback:**
   - Keep Forui for non-critical screens
   - Revert critical paths to old implementation
   - Plan phased re-migration

3. **Hybrid Approach:**
   - Use Forui for new features only
   - Keep old UI for existing features
   - Gradual migration over multiple milestones

---

## Testing Checklist Per Phase

### Phase 1 (Foundation)
- [ ] App launches successfully with FTheme
- [ ] Both light/dark modes work
- [ ] No console errors or warnings
- [ ] Existing screens still render (even with old widgets)

### Phase 2 (Base Components)
- [ ] All buttons render correctly
- [ ] Cards display with proper spacing
- [ ] Text inputs accept and validate data
- [ ] Avatars show user images/initials
- [ ] No visual regressions in mixed old/new UI

### Phase 3 (Navigation)
- [ ] Bottom nav switches tabs smoothly
- [ ] Tab state preserved (IndexedStack works)
- [ ] FAB triggers modal correctly
- [ ] No performance degradation in navigation

### Phase 4 (Forms & Modals)
- [ ] All forms open and close properly
- [ ] Input validation works
- [ ] Keyboard doesn't obscure inputs
- [ ] Form submission succeeds
- [ ] Error messages display correctly

### Phase 5 (Screens)
- [ ] LedgerScreen fully functional
- [ ] ArchiveScreen fully functional
- [ ] All data displays correctly
- [ ] Scroll performance acceptable
- [ ] No visual glitches or overflow

### Phase 6 (Cleanup)
- [ ] Old dependencies removed
- [ ] Bundle size acceptable
- [ ] No deprecated widget warnings
- [ ] All tests pass
- [ ] Production build succeeds

---

*Research completed: 2026-04-05*
*Sources: Flutter migration guides, Forui GitHub issues, community forums*
