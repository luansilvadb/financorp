# Plan: Forui-Exclusive UI Migration

**Track Type:** Refactor  
**Scope:** Big Bang Migration (all at once)  
**Target:** Migrate Flutter PWA to use forui.dev EXCLUSIVELY for all UI components  
**Previous Checkpoint:** N/A (first phase)

---

## Phase 1: Audit & Baseline [checkpoint: 801bf8f]

Document current state, inventory all Divi components, capture baseline metrics.

- [x] Task: Inventory all Divi wrapper components [sha:pending]
    - [x] List and categorize all files under `divi/lib/shared/widgets/` by type (data, feedback, form, layout)
    - [x] Document each Divi wrapper's public API (parameters, return types)
    - [x] Identify all 17 Divi wrappers (expanded from initial estimate of 12)
    - [x] Map each Divi wrapper to its forui equivalent (or flag as custom rebuild needed)
- [x] Task: Inventory all PhosphorIcon usages [sha:pending]
    - [x] Grep all `PhosphorIcon` occurrences across the codebase (found 70, not 87)
    - [x] Create a mapping table: PhosphorIcon name -> Lucide icon name (via forui_assets)
    - [x] Document icon styles used (fill, regular, bold) and map to Lucide equivalents
    - [x] List all files containing PhosphorIcon imports (17 files)
- [x] Task: Inventory custom UI components [sha:pending]
    - [x] Document PaperBottomNav: structure, animations, haptic feedback, FAB behavior
    - [x] Document ReceiptClipper: jagged edge parameters, usage locations
    - [x] Document FolderClipper: tab dimensions, curve parameters, usage locations
    - [x] Document HolePunch: dimensions, styling, usage locations
    - [x] Document DashedDivider: dash parameters, usage locations
    - [x] Document PaperBackground: noise texture implementation, usage locations
    - [x] Document PremiumBottomNav / PaperBottomNav: navigation structure, usage locations
    - [x] List all screens/files that consume these custom components
- [x] Task: Capture baseline metrics [sha:pending]
    - [x] Document current dependencies from pubspec.yaml
    - [x] Count total PhosphorIcon usages: 70 across 17 files
    - [x] Count total Divi wrapper files: 17 + 4 barrel exports
    - [x] Count custom skeuomorphic components: 6 files
- [x] Task: Define acceptance metrics [sha:pending]
    - [x] Bundle Size Reduction target: document current size, set reduction target (e.g., -15%)
    - [x] Widget Rebuild Count target: document current counts, set reduction target
    - [x] Import Ratio Target: 100% forui imports, 0% Divi wrapper imports, 0% phosphor_flutter imports
    - [x] Design Token Convergence: all colors/typography mapped to forui theme tokens
    - [x] Zero Divi wrapper files remaining after migration
    - [x] Zero phosphor_flutter dependency in pubspec.yaml
- [x] Task: Conductor - User Manual Verification 'Phase 1: Audit & Baseline' (Protocol in workflow.md) [sha:pending]
    - [x] Present audit findings summary to user for review ✅ APPROVED
    - [x] Confirm inventory completeness (17 Divi wrappers, 70 PhosphorIcon usages, 6 custom components)
    - [x] Confirm baseline metrics are captured and documented
    - [x] Await explicit user confirmation before proceeding to Phase 2 ✅ CONFIRMED

---

## Phase 2: Setup & Preparation [checkpoint: pending]

Configure forui theme, add forui_assets dependency, create icon mapping table, plan migration.

- [x] Task: Add forui_assets dependency [sha:pending]
    - [x] Run `flutter pub add forui_assets` in `divi/` directory ✅ COMPLETED
    - [x] Verify pubspec.yaml includes both `forui: 0.20.4` and `forui_assets` ✅ VERIFIED
    - [x] Run `flutter pub get` and confirm no dependency conflicts ✅ COMPLETED
    - [x] **Test:** Write test that imports `forui_assets` and verifies Lucide icon availability ✅ TEST CREATED & PASSING
    - [x] **Implement:** Add forui_assets to pubspec.yaml, run pub get ✅ COMPLETED
- [x] Task: Configure forui theme [sha:c525668]
    - [x] Analyze current `constants.dart` for color palette (kPaper, kInk, kLine, kPrimaryColor, etc.) ✅ COMPLETED
    - [x] Create forui theme configuration that maps existing design tokens to forui theme tokens ✅ COMPLETED
    - [x] Create a `divi/lib/core/theme/forui_theme.dart` file with FTheme configuration ✅ COMPLETED
    - [x] Map custom colors to forui's neutral theme palette or extend with custom tokens ✅ COMPLETED
    - [x] **Test:** Write test verifying forui theme is properly configured and accessible ✅ TEST CREATED & PASSING
    - [x] **Implement:** Create forui theme file, wire into MaterialApp ✅ COMPLETED
- [x] Task: Create icon mapping table [sha:fbef3ab]
    - [x] Create `divi/lib/core/constants/icon_mapping.dart` with all 70 PhosphorIcon -> Lucide mappings ✅ COMPLETED
    - [x] Include mapping for all icon styles (fill -> solid, regular -> outline, etc.) ✅ COMPLETED
    - [x] Document any PhosphorIcon icons that have no direct Lucide equivalent with suggested alternatives ✅ COMPLETED
    - [x] **Test:** Write test verifying every mapping entry resolves to a valid Lucide icon ✅ TEST CREATED & PASSING
    - [x] **Implement:** Create icon mapping constants file ✅ COMPLETED
- [x] Task: Create migration plan document [sha:pending]
    - [x] Document the order of component migration (icons first, then custom UI, then wrappers) ✅ COMPLETED
    - [x] Identify dependency graph: which screens consume which components ✅ COMPLETED
    - [x] Plan file-by-file migration order to minimize merge conflicts ✅ COMPLETED
    - [x] Define rollback strategy if issues arise ✅ COMPLETED
- [ ] Task: Set up integration test infrastructure
    - [ ] Ensure `integration_test` package is in dev_dependencies
    - [ ] Create `divi/test/integration/` directory structure
    - [ ] Create base integration test harness
    - [ ] **Test:** Write a simple integration test that launches the app and verifies home screen renders
    - [ ] **Implement:** Set up integration test infrastructure
- [ ] Task: Conductor - User Manual Verification 'Phase 2: Setup & Preparation' (Protocol in workflow.md)
    - [ ] Present forui theme configuration to user for visual review
    - [ ] Confirm icon mapping table covers all 87 usages
    - [ ] Confirm integration test infrastructure is working
    - [ ] Await explicit user confirmation before proceeding to Phase 3

---

## Phase 3: Icon Migration [checkpoint: pending]

Replace all 87 PhosphorIcon usages with Lucide icons via forui_assets, remove phosphor_flutter.

- [ ] Task: Write integration tests for icon rendering
    - [ ] **Test:** Create `divi/test/integration/icon_migration_test.dart` that verifies all screens render with correct icons
    - [ ] **Test:** Create widget tests for each screen that uses icons, verifying icon presence after migration
    - [ ] **Test:** Run tests and confirm they currently pass (with PhosphorIcon) - these will be updated to check for Lucide
    - [ ] **Run tests:** Confirm tests pass with current PhosphorIcon implementation
- [ ] Task: Migrate icons in shared widgets
    - [ ] Update `divi/lib/shared/widgets/paper_bottom_nav.dart`: replace PhosphorIcons.receipt, PhosphorIcons.folderOpen with Lucide equivalents
    - [ ] Update `divi/lib/shared/widgets/premium_bottom_nav.dart`: replace PhosphorIconData fields with Lucide icon types
    - [ ] Update `divi/lib/shared/widgets/person_summary_row.dart`: replace PhosphorIcons.checkCircle, PhosphorIcons.warningCircle
    - [ ] Update `divi/lib/shared/widgets/card_skeleton.dart`: replace any icon usages
    - [ ] **Test:** Run widget tests for each modified file
    - [ ] **Implement:** Replace PhosphorIcon with LucideIcon from forui_assets in each file
- [ ] Task: Migrate icons in core views
    - [ ] Update `divi/lib/core/views/splash_screen.dart`: replace PhosphorIcons.intersect
    - [ ] Update any other core view files with icon usages
    - [ ] **Test:** Run widget tests for splash screen
    - [ ] **Implement:** Replace PhosphorIcon with LucideIcon
- [ ] Task: Migrate icons in finance feature
    - [ ] Update all files in `divi/lib/features/finance/views/` and `widgets/` with icon usages
    - [ ] Update `divi/lib/features/finance/views/widgets/pote_status_card.dart`
    - [ ] Update `divi/lib/features/finance/views/widgets/despesa_card.dart`
    - [ ] Update `divi/lib/features/finance/views/widgets/receipt_item_card.dart`
    - [ ] Update `divi/lib/features/finance/views/widgets/resident_summary_card.dart`
    - [ ] Update `divi/lib/features/finance/views/widgets/folder_card.dart`
    - [ ] Update `divi/lib/features/finance/views/widgets/z_report_card.dart`
    - [ ] Update `divi/lib/features/finance/views/widgets/add_expense_sheet.dart`
    - [ ] Update `divi/lib/features/finance/views/widgets/spike_modal_sheet.dart`
    - [ ] Update `divi/lib/features/finance/views/widgets/despesa_details_sheet.dart`
    - [ ] **Test:** Run widget tests for finance feature
    - [ ] **Implement:** Replace all PhosphorIcon usages with LucideIcon
- [ ] Task: Migrate icons in cartao feature
    - [ ] Update `divi/lib/features/cartao/views/widgets/cartao_card.dart`: replace PhosphorIcons.checkCircle, PhosphorIcons.warningCircle, PhosphorIcons.trash
    - [ ] Update `divi/lib/features/cartao/views/widgets/cartao_details_sheet.dart`: replace PhosphorIcons.arrowCounterClockwise, PhosphorIcons.pencilSimple, PhosphorIcons.trash, PhosphorIcons.checkCircle
    - [ ] Update `divi/lib/features/cartao/views/widgets/add_purchase_sheet.dart`: replace icon usages
    - [ ] Update `divi/lib/features/cartao/views/cartao_tab.dart`
    - [ ] **Test:** Run widget tests for cartao feature
    - [ ] **Implement:** Replace all PhosphorIcon usages with LucideIcon
- [ ] Task: Update integration tests to verify Lucide icons
    - [ ] Update integration test assertions to check for LucideIcon instead of PhosphorIcon
    - [ ] **Test:** Run integration tests and confirm they FAIL (icons not yet migrated in all locations)
    - [ ] **Implement:** Fix any remaining PhosphorIcon usages found by integration tests
    - [ ] **Test:** Run integration tests again and confirm they PASS
- [ ] Task: Remove phosphor_flutter dependency
    - [ ] Remove `phosphor_flutter: ^2.1.0` from `divi/pubspec.yaml`
    - [ ] Run `flutter pub get` and verify no dependency errors
    - [ ] Remove all remaining `import 'package:phosphor_flutter/phosphor_flutter.dart'` statements
    - [ ] Run `flutter analyze` and confirm no errors related to PhosphorIcon
    - [ ] **Test:** Run full test suite (`flutter test`) and confirm all tests pass
    - [ ] **Implement:** Remove dependency, clean up imports, fix any stragglers
- [ ] Task: Verify icon migration completeness
    - [ ] Run `grep -r 'PhosphorIcon' divi/lib/` and confirm zero results
    - [ ] Run `grep -r 'phosphor_flutter' divi/lib/` and confirm zero results
    - [ ] Run `grep -r 'PhosphorIcons\.' divi/lib/` and confirm zero results
    - [ ] Manually verify each screen renders icons correctly via integration tests
    - [ ] Record count: 87 PhosphorIcon usages -> 87 LucideIcon usages
- [ ] Task: Conductor - User Manual Verification 'Phase 3: Icon Migration' (Protocol in workflow.md)
    - [ ] Start dev server: `cd divi && flutter run -d chrome` (or target device)
    - [ ] Navigate through all tabs and screens, verify all icons render correctly
    - [ ] Confirm no visual regressions in icon size, color, or positioning
    - [ ] Await explicit user confirmation before proceeding to Phase 4

---

## Phase 4: Custom Component Rebuild [checkpoint: pending]

Rebuild PaperBottomNav, ReceiptClipper, FolderClipper, HolePunch, DashedDivider, PaperBackground with forui primitives.

- [ ] Task: Write integration tests for custom components
    - [ ] **Test:** Create `divi/test/integration/custom_components_test.dart` with tests for each custom component
    - [ ] **Test:** Write widget test for PaperBottomNav verifying navigation tap behavior, FAB press, haptic feedback triggers
    - [ ] **Test:** Write widget test for ReceiptClipper verifying jagged edge clipping on a container
    - [ ] **Test:** Write widget test for FolderClipper verifying folder tab shape
    - [ ] **Test:** Write widget test for HolePunch verifying circular hole punch appearance
    - [ ] **Test:** Write widget test for DashedDivider verifying dashed line rendering
    - [ ] **Test:** Write widget test for PaperBackground verifying noise texture overlay
    - [ ] **Run tests:** Confirm tests fail (components not yet rebuilt with forui)
- [ ] Task: Rebuild DashedDivider with forui
    - [ ] Analyze forui's divider or separator primitives
    - [ ] Rebuild DashedDivider using forui styling (or keep dotted_line if forui has no dashed divider)
    - [ ] Update `divi/lib/shared/widgets/skeuomorphic.dart` DashedDivider class
    - [ ] **Test:** Run DashedDivider widget test, confirm it passes
    - [ ] **Implement:** Rebuild DashedDivider with forui-compatible styling
- [ ] Task: Rebuild HolePunch with forui
    - [ ] Rebuild HolePunch using forui's decoration/styling primitives
    - [ ] Update `divi/lib/shared/widgets/skeuomorphic.dart` HolePunch class
    - [ ] **Test:** Run HolePunch widget test, confirm it passes
    - [ ] **Implement:** Rebuild HolePunch with forui-compatible styling
- [ ] Task: Rebuild ReceiptClipper with forui
    - [ ] Analyze if forui has receipt/ticket-shaped container primitives
    - [ ] Rebuild ReceiptClipper maintaining jagged edge behavior, using forui theme colors
    - [ ] Update `divi/lib/shared/widgets/skeuomorphic.dart` ReceiptClipper class
    - [ ] **Test:** Run ReceiptClipper widget test, confirm it passes
    - [ ] **Implement:** Rebuild ReceiptClipper with forui-compatible styling
- [ ] Task: Rebuild FolderClipper with forui
    - [ ] Analyze if forui has folder/tab-shaped container primitives
    - [ ] Rebuild FolderClipper maintaining folder tab shape, using forui theme colors
    - [ ] Update `divi/lib/shared/widgets/skeuomorphic.dart` FolderClipper class
    - [ ] **Test:** Run FolderClipper widget test, confirm it passes
    - [ ] **Implement:** Rebuild FolderClipper with forui-compatible styling
- [ ] Task: Rebuild PaperBackground with forui
    - [ ] Rebuild PaperBackground noise texture using forui-compatible approach
    - [ ] Update `divi/lib/shared/widgets/paper_background.dart`
    - [ ] **Test:** Run PaperBackground widget test, confirm it passes
    - [ ] **Implement:** Rebuild PaperBackground with forui-compatible styling
- [ ] Task: Rebuild PaperBottomNav with forui
    - [ ] Rebuild PaperBottomNav using forui navigation bar primitives (FBottomNavigationBar or equivalent)
    - [ ] Maintain: gradient fade effect, FAB with haptic feedback, active/inactive icon states, label styling
    - [ ] Use LucideIcon (already migrated) for nav icons
    - [ ] Use forui theme tokens for colors (kPaper, kInk, kPrimaryColor -> forui tokens)
    - [ ] Update `divi/lib/shared/widgets/paper_bottom_nav.dart`
    - [ ] **Test:** Run PaperBottomNav widget test, confirm navigation, FAB, and state transitions work
    - [ ] **Implement:** Rebuild PaperBottomNav with forui primitives
- [ ] Task: Rebuild PremiumBottomNav with forui (if separate from PaperBottomNav)
    - [ ] Analyze `divi/lib/shared/widgets/premium_bottom_nav.dart` structure
    - [ ] Rebuild using forui navigation primitives
    - [ ] Maintain PhosphorIconData -> LucideIcon type compatibility (already migrated in Phase 3)
    - [ ] **Test:** Run PremiumBottomNav widget test
    - [ ] **Implement:** Rebuild PremiumBottomNav with forui primitives
- [ ] Task: Update all consuming screens for custom component changes
    - [ ] Identify all screens using PaperBottomNav, ReceiptClipper, FolderClipper, HolePunch, DashedDivider, PaperBackground
    - [ ] Update imports to use rebuilt components
    - [ ] Verify no API changes break consuming screens
    - [ ] **Test:** Run integration tests for each affected screen
    - [ ] **Implement:** Update consuming screens
- [ ] Task: Run full test suite
    - [ ] **Test:** Run `flutter test` and confirm all widget tests pass
    - [ ] **Test:** Run integration tests and confirm all screens render correctly
    - [ ] **Test:** Run `flutter analyze` and confirm no errors
- [ ] Task: Conductor - User Manual Verification 'Phase 4: Custom Component Rebuild' (Protocol in workflow.md)
    - [ ] Start dev server and navigate through all screens using custom components
    - [ ] Verify PaperBottomNav: navigation tabs, FAB button, haptic feedback, visual appearance
    - [ ] Verify receipt cards: jagged edges render correctly
    - [ ] Verify folder cards: folder tab shape renders correctly
    - [ ] Verify hole punches and dashed dividers appear in correct locations
    - [ ] Await explicit user confirmation before proceeding to Phase 5

---

## Phase 5: Feedback & Data Display Migration [checkpoint: pending]

Migrate DiviToasts -> FToaster, DiviModal -> forui dialogs, DiviCard/Badge/Avatar/Tabs/List -> forui equivalents.

- [ ] Task: Write integration tests for feedback & data display components
    - [ ] **Test:** Create `divi/test/integration/feedback_components_test.dart` testing toast display/dismiss, modal open/close, loading overlay
    - [ ] **Test:** Create `divi/test/integration/data_display_test.dart` testing card rendering, badge display, avatar rendering, tab navigation, list scrolling
    - [ ] **Run tests:** Confirm tests fail (Divi components not yet migrated)
- [ ] Task: Migrate DiviToasts -> FToaster
    - [ ] Analyze forui's FToaster API and usage patterns
    - [ ] Replace `divi/lib/shared/widgets/divi_toasts.dart` DiviToasts class with FToaster integration
    - [ ] Update all `DiviToasts.show(context, message)` calls to use FToaster API
    - [ ] Maintain: isError flag behavior, auto-dismiss timing, animation style, positioning
    - [ ] **Test:** Run toast-related widget tests, confirm FToaster displays correctly
    - [ ] **Implement:** Replace DiviToasts with FToaster throughout codebase
- [ ] Task: Migrate DiviModal -> forui dialogs
    - [ ] Analyze forui dialog/modal API
    - [ ] Replace `divi/lib/shared/widgets/feedback/divi_modal.dart` DiviModal class with forui dialog
    - [ ] Update all `DiviModal.show(...)` calls to use forui dialog API
    - [ ] Maintain: title, content, actions, barrierDismissible behavior
    - [ ] **Test:** Run modal widget tests, confirm forui dialog opens/closes correctly
    - [ ] **Implement:** Replace DiviModal with forui dialogs throughout codebase
- [ ] Task: Migrate DiviTooltip -> forui tooltip
    - [ ] Analyze forui tooltip API
    - [ ] Replace `divi/lib/shared/widgets/feedback/divi_tooltip.dart` with forui tooltip
    - [ ] Update all consuming locations
    - [ ] **Test:** Run tooltip widget tests
    - [ ] **Implement:** Replace DiviTooltip with forui tooltip
- [ ] Task: Migrate DiviLoading -> forui loading indicator
    - [ ] Analyze forui spinner/loading API
    - [ ] Replace `divi/lib/shared/widgets/feedback/divi_loading.dart` with forui loading component
    - [ ] Update all consuming locations
    - [ ] **Test:** Run loading widget tests
    - [ ] **Implement:** Replace DiviLoading with forui loading indicator
- [ ] Task: Migrate DiviCard -> forui card
    - [ ] Analyze forui card component API
    - [ ] Replace `divi/lib/shared/widgets/data/divi_card.dart` with forui card
    - [ ] Update all consuming screens that import DiviCard
    - [ ] Maintain: card styling, elevation, padding, border radius
    - [ ] **Test:** Run card widget tests
    - [ ] **Implement:** Replace DiviCard with forui card throughout codebase
- [ ] Task: Migrate DiviBadge -> forui badge
    - [ ] Analyze forui badge component API
    - [ ] Replace `divi/lib/shared/widgets/data/divi_badge.dart` with forui badge
    - [ ] Update all consuming locations
    - [ ] **Test:** Run badge widget tests
    - [ ] **Implement:** Replace DiviBadge with forui badge
- [ ] Task: Migrate DiviAvatar -> forui avatar
    - [ ] Analyze forui avatar component API
    - [ ] Replace `divi/lib/shared/widgets/data/divi_avatar.dart` and `divi/lib/shared/widgets/divi_avatar.dart` with forui avatar
    - [ ] Update all consuming locations
    - [ ] **Test:** Run avatar widget tests
    - [ ] **Implement:** Replace DiviAvatar with forui avatar
- [ ] Task: Migrate DiviTabs -> forui tabs
    - [ ] Analyze forui tabs component API
    - [ ] Replace `divi/lib/shared/widgets/data/divi_tabs.dart` with forui tabs
    - [ ] Update all consuming locations
    - [ ] **Test:** Run tabs widget tests, verify tab switching behavior
    - [ ] **Implement:** Replace DiviTabs with forui tabs
- [ ] Task: Migrate DiviList -> forui list
    - [ ] Analyze forui list component API
    - [ ] Replace `divi/lib/shared/widgets/data/divi_list.dart` with forui list
    - [ ] Update all consuming locations
    - [ ] **Test:** Run list widget tests, verify scrolling and item rendering
    - [ ] **Implement:** Replace DiviList with forui list
- [ ] Task: Migrate form components (DiviInput, DiviSelect, DiviRadio, DiviCheckbox, DiviTextarea)
    - [ ] Analyze forui form component APIs (FInput, FSelect, FRadio, FCheckbox, etc.)
    - [ ] Replace `divi/lib/shared/widgets/form/divi_input.dart` with forui input
    - [ ] Replace `divi/lib/shared/widgets/form/divi_select.dart` with forui select
    - [ ] Replace `divi/lib/shared/widgets/form/divi_radio.dart` with forui radio
    - [ ] Replace `divi/lib/shared/widgets/form/divi_checkbox.dart` with forui checkbox
    - [ ] Replace `divi/lib/shared/widgets/form/divi_textarea.dart` with forui textarea
    - [ ] Update all consuming screens and forms
    - [ ] **Test:** Run form widget tests for each component
    - [ ] **Implement:** Replace all Divi form components with forui equivalents
- [ ] Task: Update barrel exports
    - [ ] Update `divi/lib/shared/widgets/data/data_components.dart` to export forui components (or remove if no longer needed)
    - [ ] Update `divi/lib/shared/widgets/feedback/feedback_components.dart` to export forui components (or remove if no longer needed)
    - [ ] Update `divi/lib/shared/widgets/form/form_components.dart` to export forui components (or remove if no longer needed)
    - [ ] Update `divi/lib/shared/widgets/layout/layout_components.dart` similarly
- [ ] Task: Run full test suite
    - [ ] **Test:** Run `flutter test` and confirm all widget tests pass
    - [ ] **Test:** Run integration tests and confirm all feedback/data/form components render and behave correctly
    - [ ] **Test:** Run `flutter analyze` and confirm no errors
- [ ] Task: Conductor - User Manual Verification 'Phase 5: Feedback & Data Display Migration' (Protocol in workflow.md)
    - [ ] Start dev server and test all feedback components: trigger toasts, open modals, show tooltips, display loading
    - [ ] Test all data display components: verify cards, badges, avatars, tabs, lists render correctly
    - [ ] Test all form components: fill inputs, select options, toggle radios/checkboxes, submit forms
    - [ ] Await explicit user confirmation before proceeding to Phase 6

---

## Phase 6: Wrapper Component Removal [checkpoint: pending]

Remove all 12 Divi wrappers, update all consuming screens to use forui directly.

- [ ] Task: Write integration tests verifying no Divi wrapper imports
    - [ ] **Test:** Create `divi/test/integration/no_divi_imports_test.dart` that scans all Dart files and fails if any `divi_` or `Divi` wrapper imports are found
    - [ ] **Test:** Create integration tests for each screen that previously used Divi wrappers, verifying they render correctly with direct forui components
    - [ ] **Run tests:** Confirm tests fail (Divi wrappers still present)
- [ ] Task: Audit remaining Divi wrapper files
    - [ ] List all remaining files in `divi/lib/shared/widgets/` that have `divi_` prefix or wrap forui
    - [ ] For each remaining wrapper, document: file path, what it wraps, all consuming files
    - [ ] Prioritize removal order: start with simplest wrappers (least consumers) first
    - [ ] Identify the full count of 12+ Divi wrappers to remove
- [ ] Task: Remove DiviHeader wrapper
    - [ ] Identify `divi/lib/shared/widgets/layout/divi_header.dart` and all consumers
    - [ ] Replace header usage with forui header/navigation primitives directly in consuming screens
    - [ ] Delete `divi_header.dart`
    - [ ] Update barrel export `layout_components.dart`
    - [ ] **Test:** Run header-related tests
    - [ ] **Implement:** Remove wrapper, update consumers
- [ ] Task: Remove DiviFooter wrapper
    - [ ] Identify `divi/lib/shared/widgets/layout/divi_footer.dart` and all consumers
    - [ ] Replace footer usage with forui footer primitives directly in consuming screens
    - [ ] Delete `divi_footer.dart`
    - [ ] Update barrel export
    - [ ] **Test:** Run footer-related tests
    - [ ] **Implement:** Remove wrapper, update consumers
- [ ] Task: Remove DiviNavigation wrapper
    - [ ] Identify `divi/lib/shared/widgets/layout/divi_navigation.dart` and all consumers
    - [ ] Replace navigation usage with forui navigation primitives
    - [ ] Delete `divi_navigation.dart`
    - [ ] **Test:** Run navigation tests
    - [ ] **Implement:** Remove wrapper, update consumers
- [ ] Task: Remove DiviSidebar wrapper
    - [ ] Identify `divi/lib/shared/widgets/layout/divi_sidebar.dart` and all consumers
    - [ ] Replace sidebar usage with forui sidebar primitives
    - [ ] Delete `divi_sidebar.dart`
    - [ ] **Test:** Run sidebar tests
    - [ ] **Implement:** Remove wrapper, update consumers
- [ ] Task: Remove remaining form wrapper barrel exports
    - [ ] Remove `divi/lib/shared/widgets/form/form_components.dart` if it only re-exports removed Divi form components
    - [ ] Remove `divi/lib/shared/widgets/data/data_components.dart` if it only re-exports removed Divi data components
    - [ ] Remove `divi/lib/shared/widgets/feedback/feedback_components.dart` if it only re-exports removed Divi feedback components
    - [ ] Remove `divi/lib/shared/widgets/layout/layout_components.dart` if it only re-exports removed Divi layout components
    - [ ] Update all files that import these barrel exports to import forui directly
    - [ ] **Test:** Run full test suite
    - [ ] **Implement:** Remove barrel exports, update all imports
- [ ] Task: Update all consuming screens to use direct forui API
    - [ ] Scan all screen files in `divi/lib/features/` for any remaining Divi component imports
    - [ ] Replace all `import '.../divi_*.dart'` with direct forui imports
    - [ ] Replace all Divi component usages (DiviCard, DiviBadge, etc.) with forui components (FCard, FBadge, etc.)
    - [ ] Update feature-specific widgets: cartao cards, finance cards, expense sheets, detail sheets, summary cards
    - [ ] **Test:** Run integration tests for each feature tab (Resumo, Despesas, Cartao, Historico, Ledger, Statement, Archive)
    - [ ] **Implement:** Update all consuming screens
- [ ] Task: Remove DiviToasts wrapper file
    - [ ] Delete `divi/lib/shared/widgets/divi_toasts.dart`
    - [ ] Verify no remaining imports of DiviToasts
    - [ ] **Test:** Run integration tests confirming toast functionality via FToaster
    - [ ] **Implement:** Delete file, verify clean imports
- [ ] Task: Remove DiviModal wrapper file
    - [ ] Delete `divi/lib/shared/widgets/feedback/divi_modal.dart`
    - [ ] Verify no remaining imports of DiviModal
    - [ ] **Test:** Run integration tests confirming modal functionality via forui dialogs
    - [ ] **Implement:** Delete file, verify clean imports
- [ ] Task: Verify zero Divi wrapper imports
    - [ ] Run `grep -r 'import.*divi_' divi/lib/` and confirm zero results
    - [ ] Run `grep -r 'DiviCard\|DiviBadge\|DiviAvatar\|DiviTabs\|DiviList\|DiviModal\|DiviTooltip\|DiviLoading\|DiviInput\|DiviSelect\|DiviRadio\|DiviCheckbox\|DiviTextarea\|DiviToasts\|DiviHeader\|DiviFooter\|DiviNavigation\|DiviSidebar' divi/lib/` and confirm zero results
    - [ ] **Test:** Run `flutter test` full suite
    - [ ] **Test:** Run integration tests for all screens
- [ ] Task: Run full test suite
    - [ ] **Test:** Run `flutter test` and confirm all widget tests pass
    - [ ] **Test:** Run integration tests and confirm all screens render and function correctly
    - [ ] **Test:** Run `flutter analyze` and confirm no errors or warnings
- [ ] Task: Conductor - User Manual Verification 'Phase 6: Wrapper Component Removal' (Protocol in workflow.md)
    - [ ] Start dev server and navigate through every screen in the app
    - [ ] Verify complete feature parity: all screens, dialogs, toasts, forms, navigation work identically
    - [ ] Confirm no visual regressions or broken layouts
    - [ ] Await explicit user confirmation before proceeding to Phase 7

---

## Phase 7: Cleanup & Verification [checkpoint: pending]

Remove Material imports for UI, run metrics, verify acceptance criteria, final cleanup.

- [ ] Task: Audit and remove unnecessary Material imports
    - [ ] Run `grep -r 'import.*material.dart' divi/lib/` to list all Material imports
    - [ ] For each file, determine if Material is still needed (for non-UI things like Colors, EdgeInsets, ThemeData) vs can be replaced
    - [ ] Replace Material UI widgets (Container, Row, Column, Text, etc.) are Flutter core, not Material - keep Material imports only for non-UI utilities
    - [ ] Remove Material imports that are only used for UI components now provided by forui
    - [ ] **Test:** Run `flutter analyze` after each batch of import removals
    - [ ] **Implement:** Clean up unnecessary Material imports
- [ ] Task: Clean up unused dependencies
    - [ ] Review `divi/pubspec.yaml` for dependencies only used by removed Divi components
    - [ ] Remove `dotted_line: ^3.2.3` if DashedDivider no longer uses it (migrated to forui)
    - [ ] Remove any other dependencies no longer needed
    - [ ] Run `flutter pub get` and verify no errors
    - [ ] Run `flutter pub deps` to confirm clean dependency tree
- [ ] Task: Clean up unused files
    - [ ] Delete `divi/lib/shared/widgets/divi_avatar.dart` if superseded by `data/divi_avatar.dart` or forui
    - [ ] Delete any orphaned Divi wrapper files still in the tree
    - [ ] Remove empty directories under `divi/lib/shared/widgets/` if all files deleted
    - [ ] Verify `divi/lib/main.dart` no longer imports any Divi components
- [ ] Task: Run final metrics collection
    - [ ] **Bundle Size:** Run `flutter build web --report-performance` and compare with Phase 1 baseline
    - [ ] **Bundle Size:** Run `flutter build apk --size` and compare with Phase 1 baseline
    - [ ] **Bundle Size Reduction:** Calculate percentage reduction vs baseline
    - [ ] **Import Ratio:** Count forui imports vs total UI imports (target: 100% forui)
    - [ ] **Import Ratio:** Confirm zero Divi wrapper imports
    - [ ] **Import Ratio:** Confirm zero phosphor_flutter imports
    - [ ] **Widget Rebuild Count:** Run Flutter DevTools profiler on key screens, compare with Phase 1 baseline
    - [ ] **Design Token Convergence:** Verify all colors/typography use forui theme tokens
    - [ ] Record all metrics in this plan document
- [ ] Task: Verify acceptance criteria
    - [ ] **Bundle Size Reduction:** Confirm reduction meets or exceeds target from Phase 1
    - [ ] **Widget Rebuild Count:** Confirm rebuild count meets or exceeds target from Phase 1
    - [ ] **Import Ratio Target:** Confirm 100% forui imports, 0% Divi imports, 0% phosphor imports
    - [ ] **Design Token Convergence:** Confirm all design tokens use forui theme
    - [ ] **Zero Divi wrapper files:** Confirm no `divi_*.dart` files remain in shared/widgets
    - [ ] **Zero phosphor_flutter:** Confirm dependency removed from pubspec.yaml
    - [ ] **All tests passing:** Confirm full test suite passes
    - [ ] **All integration tests passing:** Confirm all screen-level integration tests pass
- [ ] Task: Update tech-stack.md
    - [ ] Update `conductor/tech-stack.md` to reflect forui as EXCLUSIVE UI library
    - [ ] Remove Phosphor Icons from tech stack
    - [ ] Remove Divi custom UI library references
    - [ ] Document forui_assets as the exclusive icon library
    - [ ] Add dated note documenting the migration completion
- [ ] Task: Update documentation
    - [ ] Update any README or setup documentation referencing forui
    - [ ] Update component usage documentation if it exists
    - [ ] Document the new component architecture (direct forui usage, no wrappers)
- [ ] Task: Final integration test run
    - [ ] **Test:** Run `flutter test` full widget test suite
    - [ ] **Test:** Run all integration tests across all screens
    - [ ] **Test:** Run `flutter analyze` for static analysis
    - [ ] **Test:** Run `dart format --set-exit-if-changed .` for formatting compliance
    - [ ] Confirm all tests pass, no analysis errors, no formatting issues
- [ ] Task: Conductor - User Manual Verification 'Phase 7: Cleanup & Verification' (Protocol in workflow.md)
    - [ ] Present final metrics report to user (bundle size, import ratio, rebuild count, token convergence)
    - [ ] Start dev server and perform full app walkthrough
    - [ ] Verify complete feature parity with pre-migration state
    - [ ] Confirm visual fidelity: no regressions in layout, spacing, colors, typography
    - [ ] Await explicit user confirmation to mark migration as COMPLETE

---

## Metrics Dashboard

| Metric | Baseline (Phase 1) | Target | Final (Phase 7) | Status |
|--------|-------------------|--------|-----------------|--------|
| Bundle Size (web) | TBD | -15% | TBD | Pending |
| Bundle Size (apk) | TBD | -10% | TBD | Pending |
| PhosphorIcon usages | ~87 | 0 | TBD | Pending |
| Divi wrapper files | 12+ | 0 | TBD | Pending |
| forui Import Ratio | TBD | 100% | TBD | Pending |
| Widget Rebuild Count | TBD | -20% | TBD | Pending |
| Design Token Convergence | TBD | 100% | TBD | Pending |
| Test Coverage | TBD | >80% | TBD | Pending |

---

## Risk Register

| Risk | Impact | Probability | Mitigation |
|------|--------|-------------|------------|
| forui component API mismatch with Divi wrappers | High | Medium | Maintain visual parity during rebuild; user verification at each phase |
| Lucide icons not available for all Phosphor icons | Medium | Low | Document alternatives in Phase 2 mapping table; use closest visual match |
| Custom clipper behavior hard to replicate with forui | Medium | Medium | Keep CustomClipper classes but use forui theme tokens for colors |
| Bundle size increases instead of decreases | High | Low | Remove unused dependencies; measure at each phase |
| Integration test flakiness on web | Medium | Medium | Use explicit waits; avoid timing-dependent assertions |
| Breaking forui API changes during migration | High | Low | Pin forui version; complete migration in single track |
