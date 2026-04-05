# Architecture Research - Forui.dev Integration

## Integration with Existing Architecture

### Root Level Changes

**Current Structure:**
```dart
void main() {
  runApp(
    ProviderScope(
      child: DiviApp(),
    ),
  );
}

class DiviApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(...), // Custom paper theme
      home: SplashScreen(),
    );
  }
}
```

**Required Changes:**
```dart
void main() {
  runApp(
    ProviderScope(
      child: DiviApp(),
    ),
  );
}

class DiviApp extends StatelessWidget {
  Widget build(BuildContext context) {
    final theme = FThemes.neutral.dark.touch; // Forui theme
    
    return MaterialApp(
      supportedLocales: FLocalizations.supportedLocales,
      localizationsDelegates: [...FLocalizations.localizationsDelegates],
      theme: theme.toApproximateMaterialTheme(),
      builder: (_, child) => FTheme(
        data: theme,
        child: FToaster(child: FTooltipGroup(child: child!)),
      ),
      home: SplashScreen(),
    );
  }
}
```

**Impact:** Minimal. FTheme wraps the app but doesn't interfere with ProviderScope or Riverpod.

### Theme System Integration

**Current Approach:**
- Custom paper theme defined in constants
- Google Fonts for typography
- Manual color definitions

**Migration Strategy:**
1. Choose Forui theme preset (neutral, zinc, slate, etc.)
2. Select variant (light/dark × touch/desktop)
3. Optionally create custom theme via `dart forui theme create`
4. Replace color constants with theme tokens

**Key Decision:** Adopt Forui's neutral theme for clean, minimal aesthetic (aligns with milestone goal).

### Component Layer Architecture

**Feature-First Structure Preserved:**
```
lib/features/finance/
├── views/
│   ├── ledger_screen.dart      → Migrate to Forui widgets
│   ├── archive_screen.dart     → Migrate to Forui widgets
│   └── widgets/
│       ├── summary_card.dart   → Replace CardSkeleton with FCard
│       └── expense_item.dart   → Replace with FCard + FItemGroup
```

**No architectural changes needed.** Forui widgets drop into existing feature structure.

### State Management Compatibility

**Riverpod Integration:** ✅ Fully Compatible

Forui widgets work seamlessly with Riverpod patterns:

```dart
// Before
class ExpenseCard extends ConsumerWidget {
  Widget build(BuildContext context, WidgetRef ref) {
    final expenses = ref.watch(expensesProvider);
    return CardSkeleton(...); // Custom widget
  }
}

// After
class ExpenseCard extends ConsumerWidget {
  Widget build(BuildContext context, WidgetRef ref) {
    final expenses = ref.watch(expensesProvider);
    return FCard(...); // Forui widget
  }
}
```

**No changes to provider architecture.** Only widget implementations change.

### Navigation Architecture

**Current Pattern:**
- Bottom nav with `_aba` index state
- IndexedStack to preserve tab state
- FAB triggers bottom sheet modal

**Migration Approach:**
- Replace PaperBottomNav with FBottomNavigationBar
- Keep IndexedStack pattern (works with Forui)
- Replace custom bottom sheets with FDialog or keep if Forui lacks equivalent

**Consideration:** Test FBottomNavigationBar performance with IndexedStack. May need to adjust if Forui's nav expects different state management.

### Data Flow Unchanged

```
Supabase Database
       ↓
Riverpod AsyncNotifier Provider
       ↓
Finance Engine (calculations)
       ↓
UI Widgets (ConsumerWidget) ← Only this layer changes
```

**Forui impacts only the presentation layer.** Data flow, providers, and engine remain identical.

## New Components vs Modified

### Pure Replacements (New Forui Widgets)
- FButton replaces custom buttons
- FCard replaces CardSkeleton
- FTextField replaces standard TextField
- FBottomNavigationBar replaces PaperBottomNav
- FAlert replaces custom toast notifications
- FAvatar replaces custom avatar implementation

### Modified Existing Widgets
- Bottom sheet modals: May need adaptation to FDialog pattern
- Currency inputs: FTextField + existing formatters
- Period navigation: Custom widget using Forui primitives
- Summary cards: FCard with custom layout inside

### Kept As-Is (No Changes)
- FinanceEngine (business logic)
- All Riverpod providers
- Supabase integration code
- Freezed models
- Navigation state management (IndexedStack)

## Suggested Build Order

### Phase 1: Foundation (Week 1)
1. Upgrade Flutter to 3.41.0+
2. Add Forui dependency
3. Update main.dart with FTheme wrapper
4. Create theme configuration
5. Verify app still runs

### Phase 2: Base Components (Week 1-2)
1. Migrate FButton (all action buttons)
2. Migrate FCard (all card components)
3. Migrate FTextField (all form inputs)
4. Migrate FAvatar (user avatars)
5. Test each component in isolation

### Phase 3: Navigation & Layout (Week 2)
1. Migrate FBottomNavigationBar
2. Update HomeScreen navigation logic
3. Migrate FAB to FButton
4. Test tab switching performance

### Phase 4: Forms & Modals (Week 2-3)
1. Migrate bottom sheets to FDialog (or keep custom)
2. Update form validation UI with FAlert
3. Migrate date pickers to FCalendar
4. Test all form flows end-to-end

### Phase 5: Screens & Polish (Week 3-4)
1. Migrate LedgerScreen completely
2. Migrate ArchiveScreen completely
3. Migrate all remaining screens
4. Performance optimization pass
5. Visual polish and consistency check

### Phase 6: Cleanup (Week 4)
1. Remove old UI dependencies
2. Delete deprecated custom widgets
3. Update documentation
4. Final regression testing

## Theme Migration Strategy

**Option A: Direct Adoption (Recommended)**
- Use Forui's neutral theme as-is
- Fastest migration path
- Clean, modern aesthetic
- Less maintenance burden

**Option B: Custom Theme**
- Create custom Forui theme matching brand
- More work upfront
- Maintains visual identity
- Ongoing theme maintenance

**Decision:** Option A - Adopt Forui neutral theme for speed and simplicity.

## Testing Strategy

### Unit Tests
- No changes needed (engine/providers unchanged)
- Add tests for new Forui widget configurations

### Widget Tests
- Update golden tests for new widget appearances
- Test Forui components in isolation
- Verify theme application

### Integration Tests
- Test complete user flows with Forui widgets
- Verify navigation transitions
- Test form submissions
- Validate responsive behavior

### Performance Tests
- Benchmark rebuild times (should improve)
- Measure widget tree depth reduction
- Test scroll performance in lists
- Monitor memory usage

---

*Research completed: 2026-04-05*
*Sources: forui.dev docs, Flutter architecture best practices*
