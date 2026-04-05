# Migration Plan: Forui-Exclusive UI Migration

## Migration Order

This document defines the file-by-file migration order to minimize merge conflicts and ensure systematic progress during the forui.dev exclusive UI migration.

## Dependency Graph Analysis

### Component Consumption Map

**Divi Wrappers Currently Used:**
- `divi_input.dart` → Used by: spike_modal_sheet.dart, add_expense_sheet.dart, add_purchase_sheet.dart
- `divi_radio.dart` → Used by: spike_modal_sheet.dart, add_purchase_sheet.dart
- `divi_avatar.dart` → Used by: person_summary_row.dart, resident_summary_card.dart, resumo_tab.dart, cartao_details_sheet.dart, cartao_card.dart
- `divi_toasts.dart` → Used by: spike_modal_sheet.dart, ledger_screen.dart, archive_screen.dart, statement_screen.dart

**PhosphorIcon Files (17 files):**
1. `splash_screen.dart` (1 icon)
2. `premium_bottom_nav.dart` (2 icon types)
3. `person_summary_row.dart` (2 icons)
4. `paper_bottom_nav.dart` (4 icons)
5. `despesa_card.dart` (2 icons)
6. `resident_summary_card.dart` (1 icon)
7. `add_expense_sheet.dart` (2 icons)
8. `receipt_item_card.dart` (1 icon)
9. `statement_screen.dart` (1 icon)
10. `pote_status_card.dart` (1 icon)
11. `folder_card.dart` (1 icon)
12. `ledger_screen.dart` (5 icons)
13. `despesa_details_sheet.dart` (6 icons)
14. `cartao_details_sheet.dart` (5 icons)
15. `cartao_card.dart` (4 icons)
16. `add_purchase_sheet.dart` (2 icons)
17. `spike_modal_sheet.dart` (already imported phosphor_flutter)

**Custom UI Components:**
- `paper_bottom_nav.dart` → Used by: HomeScreen (main.dart)
- `premium_bottom_nav.dart` → Referenced but not actively used
- `paper_background.dart` → Used by: main.dart (background layer)
- `skeuomorphic.dart` → ReceiptClipper, FolderClipper, HolePunch, DashedDivider
- `card_skeleton.dart` → Loading state placeholder
- `person_summary_row.dart` → Used in finance views

## File-by-File Migration Order

### Phase 1: Icon Migration (Phase 3 in plan.md)

**Priority: Replace all PhosphorIcon usages with Lucide icons**

**Order (by complexity - simplest first):**
1. `splash_screen.dart` - Single icon, isolated
2. `pote_status_card.dart` - Single icon, simple card
3. `folder_card.dart` - Single icon
4. `statement_screen.dart` - Single icon (back button)
5. `receipt_item_card.dart` - Single icon
6. `resident_summary_card.dart` - Single icon
7. `person_summary_row.dart` - 2 icons, shared widget
8. `despesa_card.dart` - 2 icons
9. `add_expense_sheet.dart` - 2 icons
10. `add_purchase_sheet.dart` - 2 icons
11. `premium_bottom_nav.dart` - Icon type definitions (PhosphorIconData)
12. `cartao_card.dart` - 4 icons
13. `paper_bottom_nav.dart` - 4 icons, complex navigation component
14. `ledger_screen.dart` - 5 icons, main finance screen
15. `cartao_details_sheet.dart` - 5 icons
16. `despesa_details_sheet.dart` - 6 icons, complex details sheet
17. `spike_modal_sheet.dart` - Already has phosphor import, modal form

**After all icons migrated:**
- Remove `phosphor_flutter` from pubspec.yaml
- Run `flutter pub get`
- Verify no remaining PhosphorIcon imports

### Phase 2: Custom Component Rebuild (Phase 4 in plan.md)

**Priority: Rebuild skeuomorphic components with forui primitives**

**Order (by complexity):**
1. `card_skeleton.dart` - Simple loading placeholder
2. `skeuomorphic.dart` - DashedDivider, HolePunch (simple)
3. `skeuomorphic.dart` - ReceiptClipper, FolderClipper (complex clipers)
4. `paper_background.dart` - Noise texture background
5. `premium_bottom_nav.dart` - Alternative navigation (if still needed)
6. `paper_bottom_nav.dart` - Main navigation with FAB (highest complexity)

### Phase 3: Divi Wrapper Migration (Phase 5-6 in plan.md)

**Priority: Migrate Divi wrappers to direct forui usage**

**Order (by consumer count - least first):**
1. `divi_textarea.dart` - 0 known consumers (safe to start)
2. `divi_checkbox.dart` - 0 known consumers
3. `divi_select.dart` - 0 known consumers
4. `divi_radio.dart` - 2 consumers (spike_modal_sheet, add_purchase_sheet)
5. `divi_input.dart` - 3 consumers (spike_modal_sheet, add_expense_sheet, add_purchase_sheet)
6. `divi_avatar.dart` - 5 consumers (person_summary_row, resident_summary_card, resumo_tab, cartao_details_sheet, cartao_card)
7. `divi_toasts.dart` - 4 consumers (spike_modal_sheet, ledger_screen, archive_screen, statement_screen)
8. `divi_loading.dart` - Unknown consumers (need verification)
9. `divi_modal.dart` - Unknown consumers (need verification)
10. `divi_tooltip.dart` - Unknown consumers (need verification)
11. `divi_card.dart` - Unknown consumers (need verification)
12. `divi_badge.dart` - Unknown consumers (need verification)
13. `divi_list.dart` - Unknown consumers (need verification)
14. `divi_tabs.dart` - Unknown consumers (need verification)
15. `divi_header.dart` - Unknown consumers (need verification)
16. `divi_footer.dart` - Unknown consumers (need verification)
17. `divi_navigation.dart` - Unknown consumers (need verification)
18. `divi_sidebar.dart` - Unknown consumers (need verification)

## Rollback Strategy

### If Migration Issues Arise:

1. **Git-Based Rollback:**
   - Each phase is committed separately
   - To rollback: `git revert <phase_checkpoint_commit>`
   - All work is tracked in plan.md with checkpoint SHAs

2. **Feature Flag Approach:**
   - Keep phosphor_flutter dependency until Phase 3 complete
   - Keep Divi wrappers until Phase 6 complete
   - Gradual cutover, not all-at-once removal

3. **Backup Branch:**
   - Create `backup/pre-forui-migration` branch before starting
   - Can always return to this branch if needed

4. **Incremental Verification:**
   - Each file migrated is verified with tests
   - Integration tests run after each batch
   - Manual verification at end of each phase

### Emergency Stop Procedure:

1. Commit all completed work
2. Document current progress in plan.md
3. Note which files have been migrated vs which remain original
4. Create clear checkpoint commit message
5. User can resume later from this exact point

## Merge Conflict Minimization

### Strategy:
- Migrate **one file at a time** following the order above
- Commit after each file is fully migrated and tested
- This ensures small, atomic commits
- If working with others, coordinate to avoid editing same files

### Files Most Likely to Have Conflicts:
1. `paper_bottom_nav.dart` - Core navigation, frequently modified
2. `ledger_screen.dart` - Main feature screen
3. `spike_modal_sheet.dart` - Complex form with multiple Divi components
4. `pubspec.yaml` - Dependency changes (minimal risk)

### Recommendation:
- Complete icon migration (Phase 3) in single session if possible
- Complete custom component rebuild (Phase 4) in single session
- Complete wrapper migration (Phase 5-6) in single session
- This minimizes window for merge conflicts

## Success Criteria

### Phase Completion Indicators:
- ✅ All tests passing (unit + integration)
- ✅ No phosphor_flutter imports remaining
- ✅ No Divi wrapper imports remaining  
- ✅ forui.dev used exclusively for all UI
- ✅ Visual parity maintained (no regressions)
- ✅ Bundle size reduced (measurable improvement)
- ✅ Lighthouse PWA score ≥ 90 maintained
