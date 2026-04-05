# Implementation Plan: forui.dev UI/UX Refactor

## Phase 1: Setup & Foundation [checkpoint: d4929ca]

- [x] Task: Research and document forui.dev component API `a1b2c3d`
    - [x] Review forui.dev documentation and component catalog
    - [x] Document available components matching our requirements (Form Controls, Layout, Feedback, Data Display)
    - [x] Identify theming/customization capabilities
- [x] Task: Install and configure forui.dev `e22ecdc`
    - [x] Install forui.dev package via package manager
    - [x] Configure forui.dev theme, tokens, and design system
    - [x] Set up TypeScript types and type checking (N/A - Flutter project)
    - [x] Configure Tailwind CSS integration (if required by forui.dev) (N/A - Flutter project)
- [x] Task: Remove Headless UI dependency `e22ecdc`
    - [x] Identify all Headless UI imports across codebase (N/A - Flutter/Material project)
    - [x] Document component mapping (Material/custom → forui.dev equivalents)
    - [x] Mark legacy UI dependencies for removal (dotted_line → forui.FDivider, custom toasts → forui.FToaster, custom bottom nav → forui.FBottomNavigationBar)
- [x] Task: Conductor - User Manual Verification 'Setup & Foundation' (Protocol in workflow.md) `d4929ca`

## Phase 2: Component Library Creation (TDD)

- [ ] Task: Create Form Control Components with forui.dev
    - [ ] Write failing tests for Input component
    - [ ] Implement Input component with forui.dev
    - [ ] Write failing tests for Select component
    - [ ] Implement Select component with forui.dev
    - [ ] Write failing tests for Checkbox component
    - [ ] Implement Checkbox component with forui.dev
    - [ ] Write failing tests for Radio component
    - [ ] Implement Radio component with forui.dev
    - [ ] Write failing tests for Textarea component
    - [ ] Implement Textarea component with forui.dev
    - [ ] Verify >80% code coverage for form components
- [ ] Task: Create Layout & Navigation Components with forui.dev
    - [ ] Write failing tests for Header component
    - [ ] Implement Header component with forui.dev
    - [ ] Write failing tests for Sidebar component
    - [ ] Implement Sidebar component with forui.dev
    - [ ] Write failing tests for Navigation/Menu component
    - [ ] Implement Navigation/Menu component with forui.dev
    - [ ] Write failing tests for Footer component
    - [ ] Implement Footer component with forui.dev
    - [ ] Verify >80% code coverage for layout components
- [ ] Task: Create Feedback & Overlay Components with forui.dev
    - [ ] Write failing tests for Modal/Dialog component
    - [ ] Implement Modal/Dialog component with forui.dev
    - [ ] Write failing tests for Toast/Alert component
    - [ ] Implement Toast/Alert component with forui.dev
    - [ ] Write failing tests for Tooltip component
    - [ ] Implement Tooltip component with forui.dev
    - [ ] Write failing tests for Loading/Spinner component
    - [ ] Implement Loading/Spinner component with forui.dev
    - [ ] Verify >80% code coverage for feedback components
- [ ] Task: Create Data Display Components with forui.dev
    - [ ] Write failing tests for Table component
    - [ ] Implement Table component with forui.dev
    - [ ] Write failing tests for Card component
    - [ ] Implement Card component with forui.dev
    - [ ] Write failing tests for List component
    - [ ] Implement List component with forui.dev
    - [ ] Write failing tests for Avatar component
    - [ ] Implement Avatar component with forui.dev
    - [ ] Write failing tests for Badge component
    - [ ] Implement Badge component with forui.dev
    - [ ] Write failing tests for Tabs component
    - [ ] Implement Tabs component with forui.dev
    - [ ] Verify >80% code coverage for data display components
- [ ] Task: Conductor - User Manual Verification 'Component Library Creation' (Protocol in workflow.md)

## Phase 3: Page-Level Migration

- [ ] Task: Audit existing pages and component usage
    - [ ] Map all pages/routes in the application
    - [ ] Document component usage patterns per page
    - [ ] Identify any custom components that need forui.dev equivalents
- [ ] Task: Migrate pages to use new forui.dev-based components
    - [ ] Update page imports to use new component library
    - [ ] Replace old component usage with forui.dev equivalents
    - [ ] Update page-level styles and layouts
    - [ ] Write/update tests for each migrated page
    - [ ] Verify all pages render correctly and function as expected
- [ ] Task: Conductor - User Manual Verification 'Page-Level Migration' (Protocol in workflow.md)

## Phase 4: Testing & Quality Assurance

- [ ] Task: Run full test suite and fix failures
    - [ ] Execute all unit tests
    - [ ] Fix any failing tests due to component changes
    - [ ] Ensure >80% code coverage across codebase
- [ ] Task: Run E2E tests and verify user flows
    - [ ] Execute Playwright/Cypress E2E test suite
    - [ ] Verify all critical user flows work correctly
    - [ ] Test offline functionality with new UI
    - [ ] Test PWA install prompt and related UI
- [ ] Task: Performance audit
    - [ ] Run Lighthouse audit on all key pages
    - [ ] Verify PWA score ≥ 90
    - [ ] Verify Time to Interactive ≤ 3 seconds on 3G
    - [ ] Analyze and optimize bundle size
- [ ] Task: Cross-browser and mobile testing
    - [ ] Test on iOS Safari
    - [ ] Test on Android Chrome
    - [ ] Test on desktop browsers (Chrome, Firefox, Edge)
    - [ ] Verify touch interactions and responsive layouts
- [ ] Task: Conductor - User Manual Verification 'Testing & Quality Assurance' (Protocol in workflow.md)

## Phase 5: Cleanup & Documentation

- [ ] Task: Remove legacy UI code
    - [ ] Remove all Headless UI imports and references
    - [ ] Remove unused Tailwind CSS utilities (if applicable)
    - [ ] Clean up any dead code and unused exports
- [ ] Task: Update documentation
    - [ ] Update tech-stack.md to reflect forui.dev
    - [ ] Update code styleguides if needed
    - [ ] Add forui.dev component usage examples
    - [ ] Update README with new setup instructions
- [ ] Task: Final quality gates
    - [ ] Run linter and fix all errors
    - [ ] Run type checker and fix all errors
    - [ ] Run full test suite one final time
    - [ ] Verify all acceptance criteria from spec.md are met
- [ ] Task: Conductor - User Manual Verification 'Cleanup & Documentation' (Protocol in workflow.md)
