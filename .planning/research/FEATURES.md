# Features Research - Forui.dev Components

## Component Mapping: Current → Forui.dev

### Navigation Components

| Current Implementation | Forui Equivalent | Complexity |
|----------------------|------------------|------------|
| PaperBottomNav | FBottomNavigationBar | Medium |
| IndexedStack tabs | FScaffold + routing | Low |
| FAB for modals | FButton + modal system | Medium |

**Notes:** FBottomNavigationBar supports adaptive touch/desktop styles. Need to migrate from custom `_aba` index state to Forui's navigation pattern.

### Card Components

| Current Implementation | Forui Equivalent | Complexity |
|----------------------|------------------|------------|
| CardSkeleton base | FCard / FItemGroup | Low |
| Summary cards | FCard with custom content | Low-Medium |
| Expense cards | FCard + FItemGroup | Medium |
| Person cards | FCard + FAvatar | Medium |

**Notes:** Forui's FCard and FItemGroup provide flexible containers. High-density info display needs custom styling within Forui constraints.

### Form Components

| Current Implementation | Forui Equivalent | Complexity |
|----------------------|------------------|------------|
| SpikeModalSheet (bottom sheets) | FDialog / FModal | Medium-High |
| Currency input fields | FTextField + formatters | Medium |
| Date pickers | FCalendar | Low |
| Person selectors | FSelect / FDropdown | Medium |
| Validation toasts | FAlert + FToaster | Low |

**Notes:** Bottom sheet forms are critical UX pattern. Forui's modal system may differ from current implementation. Form validation integration with Riverpod needs testing.

### Data Display Components

| Current Implementation | Forui Equivalent | Complexity |
|----------------------|------------------|------------|
| Period navigation | FBreadcrumb / custom | Medium |
| Balance displays | Text + FBadge | Low |
| Transaction lists | FListView + FCard | Medium |
| Empty states | FAlert (info variant) | Low |
| Loading states | FSpinner / skeleton | Low |

### Interactive Components

| Current Implementation | Forui Equivalent | Complexity |
|----------------------|------------------|------------|
| Action buttons | FButton | Low |
| Swipe gestures | GestureDetector (keep) | Low |
| Pull-to-refresh | RefreshIndicator (keep) | Low |
| Confirmation dialogs | FDialog | Low |

## Table Stakes vs Differentiators

### Table Stakes (Must Have)
- ✅ FButton for all actions
- ✅ FCard for content grouping
- ✅ FTextField for inputs
- ✅ FBottomNavigationBar for navigation
- ✅ FDialog for modals/confirmations
- ✅ FAlert for notifications/toasts
- ✅ FAvatar for user representation
- ✅ FBadge for counts/status

### Differentiators (Nice to Have)
- 🎯 FAccordion for expandable expense details
- 🎯 FAutocomplete for person/search fields
- 🎯 FBreadcrumb for period navigation
- 🎯 FCalendar for date selection in forms
- 🎯 FToaster for non-blocking notifications

### Anti-Features (Avoid)
- ❌ Over-using decorative components (conflicts with minimal design)
- ❌ Complex nested modals (performance impact)
- ❌ Custom animations beyond Forui's motion system

## Complexity Analysis by Feature Area

### Low Complexity (Direct Replacement)
- Buttons (FButton)
- Basic cards (FCard)
- Text inputs (FTextField)
- Alerts/toasts (FAlert, FToaster)
- Avatars (FAvatar)

### Medium Complexity (Adaptation Needed)
- Bottom navigation (FBottomNavigationBar + state management)
- Bottom sheet modals (migration from custom to FDialog)
- Currency formatting (FTextField + intl integration)
- List rendering (FCard in ListView with Riverpod)

### High Complexity (Architectural Changes)
- Theme system migration (paper → Forui themes)
- Modal sheet patterns (custom → FDialog/FModal)
- Dense information cards (custom layout → FItemGroup)
- Gesture interactions (maintain while using Forui widgets)

## Dependencies on Existing Code

### Riverpod Integration
- All Forui widgets work with Riverpod (no conflicts)
- Use ConsumerWidget/ConsumerStatefulWidget as usual
- FTheme doesn't interfere with providers
- AsyncNotifiers continue working unchanged

### Supabase Integration
- No changes needed to data layer
- Forui is purely presentational
- Backend calls remain identical

### Finance Engine
- No impact on calculation logic
- Engine outputs feed into Forui widgets same as before
- Contract preservation ensures zero engine changes

## Performance Characteristics

### Forui Advantages
- Minimal widget tree depth (cleaner than Material)
- Built-in optimizations for lists/cards
- Efficient theme system (less rebuild overhead)
- Platform-adaptive rendering (touch vs desktop)

### Potential Concerns
- Initial bundle size increase (~200-300KB)
- Theme switching requires careful state management
- Custom styling within Forui constraints may add complexity

---

*Research completed: 2026-04-05*
*Sources: forui.dev component docs, pub.dev API reference*
