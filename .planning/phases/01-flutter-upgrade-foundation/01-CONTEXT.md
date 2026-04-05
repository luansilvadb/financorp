# Phase 01: Flutter Upgrade & Foundation - Context

**Gathered:** 2026-04-05  
**Status:** Ready for planning  
**Source:** Interactive discussion with user

---

<domain>
## Phase Boundary

This phase focuses on upgrading the Flutter SDK from ^3.1.0 to 3.41.0+ and integrating Forui.dev as the UI foundation without breaking existing functionality. The goal is to establish a modern, clean design system while maintaining all current features operational.

**What's in scope:**
- Flutter SDK upgrade to 3.41.0+
- Forui.dev dependency integration (forui: ^0.18.0)
- FTheme configuration at app root (main.dart)
- FLocalizations setup for pt-BR
- Compatibility verification of all dependencies
- Rollback documentation and safety measures

**What's NOT in scope:**
- Migrating individual components or screens (Phase 2+)
- Removing old dependencies yet (done after full migration)
- Performance optimizations beyond what's needed for compatibility
- CI/CD pipeline updates (can be deferred if complex)

</domain>

---

<decisions>
## Implementation Decisions

### Theme Configuration
- **Base theme:** `neutral.dark.touch` — Use Forui's recommended dark theme for financial apps
- **Customization level:** None — Use the theme exactly as provided by Forui.dev, no custom colors or modifications
- **Rationale:** User wants a clean, modern look without spending time on theme customization. The neutral.dark.touch theme provides good readability and professional appearance suitable for financial management.

### Localization Strategy
- **Initial setup:** Portuguese (pt-BR) only
- **FLocalizations:** Configure delegates and supportedLocales for pt-BR
- **Future expansion:** Structure ready for additional languages but implement only pt-BR now
- **Rationale:** App is currently used by Portuguese-speaking households. Multi-language support can be added later when needed.

### Migration Approach
- **Strategy:** Incremental — Keep existing UI components working while adding Forui infrastructure
- **Testing:** Verify all screens still render correctly after FTheme wrapper is added
- **Hot reload:** Must work correctly after theme changes
- **Rollback:** Document process and test in separate branch before proceeding

### Dependency Management
- **Order:** Upgrade Flutter SDK first, then add Forui, verify compatibility, then proceed to component migration
- **Breaking changes:** Handle Flutter 3.41.0+ breaking changes before adding new dependencies
- **Old dependencies:** Keep google_fonts, phosphor_flutter, animations during Phase 1 (remove in Phase 8)

### Safety Measures
- **Branch strategy:** Create feature branch for migration work
- **Testing points:** After SDK upgrade, after FTheme addition, after each major change
- **Rollback plan:** Document steps to revert to previous state if critical issues found
- **CI/CD:** Can be updated later if it adds complexity to Phase 1

</decisions>

---

<specifics>
## Specific References & Preferences

### User Preferences Captured
- **"Sem Customizações"** — User explicitly chose to use Forui's neutral.dark.touch theme as-is, without any color or style modifications
- **"Apenas Português"** — User wants pt-BR localization configured but no other languages for now
- Prefers clean, modern aesthetic over skeuomorphic/paper design currently in use

### Technical Constraints
- Current app uses: Flutter ^3.1.0, Riverpod ^2.4.10, Supabase ^2.12.0
- Existing theme: Custom paper/skeuomorphic design with google_fonts (Inter), phosphor_flutter icons
- Navigation: Bottom nav with 2 tabs (Ledger, Archive) using IndexedStack
- State management: Riverpod providers must continue working after migration

### Code Patterns Observed
- Feature-First architecture with Clean Architecture (Simplified)
- Freezed for immutable models
- Centralized FinanceEngine for calculations
- Bottom sheet modals for forms
- High-density card-based information display

</specifics>

---

<deferred>
## Deferred Ideas

*(No deferred items from this discussion)*

</deferred>

---

## Notes for Downstream Agents

### For gsd-phase-researcher
- Research should focus on Flutter 3.41.0+ breaking changes and migration paths
- Investigate Forui.dev integration patterns, especially FTheme wrapper usage
- Look into FLocalizations setup for single-language (pt-BR) configuration
- Check compatibility of current dependencies (Riverpod, Supabase, Freezed) with Flutter 3.41.0+

### For gsd-planner
- Plans must include testing checkpoints after each major change
- Include rollback documentation as a specific task
- Don't plan component migration yet — that's Phase 2+
- Ensure FTheme is wrapped around MaterialApp, not individual screens
- Verify hot reload works after theme configuration

### Key Success Indicators
1. App compiles and runs with Flutter 3.41.0+
2. FTheme wrapper active in MaterialApp without console errors
3. neutral.dark.touch theme visually applied (verify colors and typography)
4. All existing screens still render (even with old widgets)
5. Riverpod providers continue functioning (test tab navigation)
6. Supabase integration operational (test data fetch)
7. Hot reload works after theme changes
8. Build release succeeds without critical warnings
9. Rollback documented and tested in separate branch

</file_content>