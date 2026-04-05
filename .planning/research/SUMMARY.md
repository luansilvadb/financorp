# Research Summary - Forui.dev Migration

## Executive Summary

Migration from custom paper theme to Forui.dev is **feasible with moderate complexity**. Key findings indicate architectural compatibility with existing Riverpod/Supabase stack, but requires Flutter SDK upgrade and careful handling of bottom sheet modals.

---

## Stack Additions

**Primary Dependency:**
- `forui: ^0.18.0` - Main UI library (40+ widgets)

**Critical Requirement:**
- ⚠️ **Flutter 3.41.0+ required** (current: ^3.1.0)
- This is the biggest risk factor - must verify all dependencies compatible before upgrading

**Packages to Remove:**
- `google_fonts` → Replaced by Forui themes
- `phosphor_flutter` → Replaced by Forui Icons (bundled)
- `animations` → Replaced by Forui motion system

**Compatibility:** ✅ Riverpod, Supabase, Freezed all fully compatible

---

## Feature Table Stakes

### Must-Have Components (8 components)
1. **FButton** - All action buttons
2. **FCard** - Content grouping (replaces CardSkeleton)
3. **FTextField** - Form inputs
4. **FBottomNavigationBar** - Primary navigation
5. **FDialog** - Modals and confirmations
6. **FAlert** - Notifications/toasts
7. **FAvatar** - User representation
8. **FBadge** - Counts and status indicators

### Nice-to-Have Components (5 components)
1. **FAccordion** - Expandable expense details
2. **FAutocomplete** - Person/search fields
3. **FBreadcrumb** - Period navigation
4. **FCalendar** - Date selection in forms
5. **FToaster** - Non-blocking notifications

### Avoid
- Over-using decorative components
- Complex nested modals
- Custom animations beyond Forui's system

---

## Architecture Integration

### What Changes
- **Root widget:** Wrap MaterialApp with FTheme
- **Theme system:** Replace custom paper theme with FThemes.neutral
- **Components:** Drop-in replacement for most widgets
- **Localization:** Add FLocalizations delegates

### What Stays The Same
- ✅ Riverpod providers (no changes)
- ✅ Supabase integration (no changes)
- ✅ Finance Engine (no changes)
- ✅ Freezed models (no changes)
- ✅ Navigation state management (IndexedStack preserved)
- ✅ Feature-first architecture (structure unchanged)

### Build Order (Recommended)
1. Foundation (Flutter upgrade + FTheme setup)
2. Base Components (buttons, cards, inputs, avatars)
3. Navigation & Layout (bottom nav, FAB)
4. Forms & Modals (bottom sheets → FDialog)
5. Screens & Polish (complete screen migration)
6. Cleanup (remove old deps, optimize)

**Estimated Timeline:** 4 weeks for complete migration

---

## Watch Out For

### 🔴 High Severity Risks

1. **Flutter Version Incompatibility**
   - Forui requires 3.41.0+, current is 3.1.0
   - May break other dependencies
   - **Mitigation:** Test upgrade in branch first, have rollback plan

2. **Breaking Theme Assumptions**
   - Hardcoded colors/sizes will break
   - **Mitigation:** Audit all hardcoded values, map to Forui tokens

3. **Insufficient Testing Coverage**
   - Financial calculations must remain accurate
   - **Mitigation:** Write tests BEFORE migration, comprehensive QA per phase

### 🟡 Medium Severity Risks

4. **Bottom Sheet Modal Regression**
   - Current SpikeModalSheet may not map cleanly to FDialog
   - **Mitigation:** Test thoroughly, keep custom implementation if needed

5. **Performance Regression in Lists**
   - Different performance characteristics than custom widgets
   - **Mitigation:** Profile before/after, optimize widget structure

6. **Contract Violations**
   - Breaking widget APIs violates "preserve contracts" requirement
   - **Mitigation:** Use adapter pattern, maintain same public API

### 🟢 Low Severity Risks

7. **Riverpod Provider Conflicts** - Unlikely, but test FTheme placement
8. **Localization Breakage** - Merge delegates carefully
9. **Icon System Conflicts** - Migrate to Forui Icons exclusively
10. **Bundle Size Increase** - ~200-300KB increase acceptable

---

## Critical Success Factors

### Technical
- ✅ Flutter upgrade successful without breaking dependencies
- ✅ FTheme properly integrated with ProviderScope
- ✅ All Forui components render correctly
- ✅ Performance equal or better than current implementation
- ✅ No regressions in financial calculations

### Process
- ✅ Incremental migration (not big bang)
- ✅ Comprehensive testing at each phase
- ✅ Rollback strategy documented and tested
- ✅ Stakeholder approval on visual changes
- ✅ Documentation updated

### User Experience
- ✅ No disruption to core user flows
- ✅ Visual consistency across app
- ✅ Performance perceived as same or better
- ✅ Accessibility maintained or improved

---

## Recommendation

**Proceed with migration** using incremental approach outlined in ARCHITECTURE.md.

**Key Decisions:**
1. Adopt Forui neutral theme (don't create custom theme)
2. Maintain adapter pattern for contract preservation
3. Keep custom bottom sheet if FDialog insufficient
4. Prioritize testing over speed
5. Plan for 4-week timeline with buffer

**Go/No-Go Criteria:**
- ✅ If Flutter 3.41.0+ upgrade succeeds in test branch → GO
- ❌ If critical dependency incompatible with Flutter 3.41+ → NO-GO (reconsider)
- ⚠️ If bottom sheet migration fails → Partial adoption (hybrid approach)

---

## Next Steps

1. **Immediate:** Test Flutter 3.41.0+ upgrade in separate branch
2. **If successful:** Define detailed requirements based on research
3. **Create roadmap:** Break migration into 6 phases with clear deliverables
4. **Begin Phase 1:** Foundation work (Flutter upgrade + FTheme setup)

---

*Synthesized: 2026-04-05*
*Sources: STACK.md, FEATURES.md, ARCHITECTURE.md, PITFALLS.md*
