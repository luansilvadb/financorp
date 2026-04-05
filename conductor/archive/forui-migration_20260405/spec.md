# Specification: forui.dev UI/UX Refactor

## Overview
Refactor the entire UI/UX of the PWA application to use **exclusively forui.dev** as the primary UI library. This is a clean break migration that will replace all existing UI components (Tailwind CSS + Headless UI) with forui.dev components, maximizing performance, visual cohesiveness, and logical density while ensuring backward compatibility with existing business logic and contracts.

## Functional Requirements

### 1. forui.dev Integration
- Install and configure forui.dev as the sole UI library
- Set up theming, tokens, and design system configuration
- Ensure compatibility with React 18+ and TypeScript
- Remove Headless UI dependency completely

### 2. Component Migration (All Categories)
Migrate ALL existing UI components to forui.dev equivalents:
- **Form Controls**: Inputs, selects, checkboxes, radio buttons, textareas, form validation UI
- **Layout & Navigation**: Headers, sidebars, footers, breadcrumbs, menus, navigation patterns
- **Feedback & Overlays**: Modals, dialogs, toasts, alerts, tooltips, loading spinners
- **Data Display**: Tables, cards, lists, avatars, badges, tabs

### 3. Clean Break Strategy
- Complete removal of old UI library patterns
- No wrapper layers or dual-library coexistence
- All components must use forui.dev natively
- Update all imports, styles, and component implementations

### 4. Backward Compatibility Preservation
- Maintain all existing component props/interfaces where consumed by business logic
- Preserve all API contracts, state management patterns (Zustand/Redux), and data flow
- Ensure all existing functionality continues to work identically
- No changes to backend services, APIs, or business logic

## Non-Functional Requirements

### Performance
- Maintain or improve Lighthouse PWA score (target: 90+)
- Ensure Time to Interactive remains < 3 seconds on 3G
- Optimize bundle size (forui.dev should not increase total bundle size by >10%)

### Code Quality
- Follow Conductor workflow (TDD approach)
- Maintain >80% code coverage
- Update all component tests to reflect new UI library
- Ensure type safety with TypeScript

### PWA Compatibility
- All forui.dev components must work with service workers
- Maintain offline-first capabilities
- Ensure installable PWA features continue working
- Test across iOS Safari, Android Chrome, and desktop browsers

## Acceptance Criteria

1. ✅ All UI components use forui.dev exclusively (no Headless UI remnants)
2. ✅ All existing tests pass with new component implementations
3. ✅ Code coverage remains >80%
4. ✅ Lighthouse PWA score ≥ 90
5. ✅ Time to Interactive ≤ 3 seconds on 3G
6. ✅ No regressions in existing functionality
7. ✅ All component props/interfaces preserved for backward compatibility
8. ✅ Documentation updated to reflect forui.dev usage
9. ✅ Bundle size within acceptable range (≤10% increase from baseline)

## Out of Scope

- Changes to backend services, APIs, or database schemas
- State management architecture changes (Zustand/Redux remain unchanged)
- Business logic modifications
- PWA infrastructure changes (service workers, manifest, etc.)
- Authentication flow changes
- Testing infrastructure changes (Jest, Playwright/Cypress remain)
