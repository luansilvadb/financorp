# Specification: UI/UX Refactoring to Exclusive forui.dev

## Overview
Refactor the entire UI/UX of the project to use **EXCLUSIVELY forui.dev** as the main UI Library, removing all other UI libraries (phosphor_flutter, custom Material-based wrappers) to maximize performance, coesão, and logical density, ensuring low coupling and preservation of existing contracts (backward compatibility).

## Current State Analysis
- **Icon System**: 87 usages of `PhosphorIcon` across 15+ files
- **Custom Wrappers**: 12 Divi wrapper components (DiviInput, DiviSelect, DiviRadio, DiviCheckbox, DiviTabs, DiviModal, DiviLoading, DiviTooltip, DiviCard, DiviList, DiviBadge, DiviAvatar)
- **Skeuomorphic Components**: PaperBottomNav (with FAB), ReceiptClipper, FolderClipper, HolePunch, DashedDivider
- **Custom Feedback**: DiviToasts, custom modal flows
- **Foundation**: Already uses forui for form components (FTextFormField, FRadio, FCheckbox) and theme infrastructure (FTheme, FToaster, FTooltipGroup)

## Functional Requirements

### FR-1: Icon System Migration
- Map all 87 PhosphorIcon usages to Lucide icon equivalents via forui_assets
- Accept visual differences where exact 1:1 matches don't exist
- Remove phosphor_flutter dependency completely from pubspec.yaml
- Update all icon references across 15+ files

### FR-2: Custom Component Rebuild
- Rebuild skeuomorphic components (PaperBottomNav, ReceiptClipper, FolderClipper, HolePunch, DashedDivider) using forui primitives
- Accept some visual differences in recreation
- Maintain brand identity through forui-compatible design patterns

### FR-3: Direct Forui API Adoption
- Replace all 12 Divi wrapper components with direct forui component usage
- Update all consuming feature screens to use forui API directly
- Maintain functional equivalence for all user-facing behaviors
- No backward compatibility wrapper preservation

### FR-4: Feedback Components Migration
- Migrate DiviToasts to FToaster (already wired in main.dart)
- Migrate DiviModal to forui dialog/sheet patterns
- Migrate DiviLoading to forui loading indicators
- Migrate DiviTooltip to FTooltipGroup patterns

### FR-5: Data Display Components
- Replace DiviCard, DiviBadge, DiviAvatar with forui equivalents
- Replace DiviTabs with forui tab patterns or custom forui-based implementation
- Replace DiviList with forui list primitives

## Non-Functional Requirements

### NFR-1: Performance Metrics
- **Bundle Size**: Measure web bundle size before/after using `flutter build web --analyze-size`. Target: measurable reduction from removing phosphor_flutter
- **Widget Rebuild Count**: Use Flutter DevTools to track rebuild counts on LedgerScreen and StatementScreen. Target: no regression vs baseline
- **Import Ratio**: Achieve 100% forui/forui.dart imports for UI components (0% flutter/material.dart for UI, 0% phosphor_flutter)
- **Design Token Convergence**: Reduce unique color values, border radius values, and spacing values. Target: convergence toward consistent design token set

### NFR-2: PWA Requirements
- Maintain Lighthouse PWA score ≥ 90
- Maintain time-to-interactive < 3 seconds on 3G
- Maintain offline functionality for core user journeys
- Maintain installation conversion rate > 25%

### NFR-3: Code Quality
- All tests passing (integration tests for critical flows)
- Code coverage > 80% for new/modified code
- No linting or static analysis errors
- Code follows forui.dev best practices and patterns

## Acceptance Criteria
1. ✅ Zero phosphor_flutter imports remaining in codebase
2. ✅ All 87 icon usages migrated to Lucide via forui_assets
3. ✅ All 12 Divi wrapper components removed, replaced with direct forui usage
4. ✅ All custom skeuomorphic components rebuilt using forui primitives
5. ✅ Bundle size measured and documented (before/after comparison)
6. ✅ Widget rebuild counts documented for critical screens
7. ✅ Import ratio audit confirms 100% forui for UI components
8. ✅ Design token convergence metrics documented
9. ✅ Integration tests pass for all critical user flows
10. ✅ Lighthouse PWA score ≥ 90 maintained
11. ✅ Time-to-interactive < 3s on 3G maintained
12. ✅ Manual visual verification completed for all screens

## Out of Scope
- Backend/Supabase integration changes
- State management (Riverpod) architecture changes
- Business logic modifications
- Localization/internationalization changes (FLocalizations remains unchanged)
- Routing/Navigation architecture changes (only UI component implementation changes)
- Color palette/token values (existing kPaper, kInk, kPrimaryColor, kPaid, etc. preserved, just mapped into forui theme)
- Custom clipper artistic intent (visual approximation acceptable, exact pixel match not required)
