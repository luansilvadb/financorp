# Stack Research - Forui.dev Migration

## Recommended Stack Additions

### Core Dependencies
```yaml
dependencies:
  forui: ^0.18.0  # Main UI library (requires Flutter 3.41.0+)
```

**Rationale:** Forui 0.18.0+ is the current stable version providing 40+ minimal, beautifully designed widgets. Requires Flutter 3.41.0+ which may need upgrading from current ^3.1.0.

### Version Compatibility Check

**Current Stack:**
- Flutter: ^3.1.0 ❌ **NEEDS UPGRADE** to 3.41.0+
- Riverpod: ^2.4.10 ✅ Compatible
- Supabase: ^2.12.0 ✅ Compatible
- Freezed: ^2.5.2 ✅ Compatible

**Action Required:** Upgrade Flutter SDK before adding Forui.

### Packages to Remove/Replace

| Current Package | Replacement | Notes |
|----------------|-------------|-------|
| `google_fonts` | Forui themes | Forui has built-in theme system |
| `phosphor_flutter` | `forui_assets` | Forui Icons bundled with forui package |
| `animations` | Forui animations | Built-in motion system |
| `dotted_line` | Keep or replace | Check if Forui has equivalent |

### Integration Points

1. **Theme System:** Replace custom paper theme with FThemes
   - Forui provides predefined themes (neutral, etc.)
   - Supports light/dark variants
   - Touch/desktop adaptive theming

2. **Root Widget:** Wrap MaterialApp/CupertinoApp with FTheme
   ```dart
   MaterialApp(
     builder: (_, child) => FTheme(
       data: FThemes.neutral.dark.touch,
       child: FToaster(child: FTooltipGroup(child: child!)),
     ),
     // ... rest of config
   )
   ```

3. **Localization:** Add FLocalizations delegates
   ```dart
   supportedLocales: FLocalizations.supportedLocales,
   localizationsDelegates: [...FLocalizations.localizationsDelegates],
   ```

### What NOT to Add

- ❌ Separate icon packages (Forui Icons bundled)
- ❌ Additional animation libraries (Forui has built-in motion)
- ❌ Custom theme engines (use FThemes)

### Migration Path

1. Upgrade Flutter to 3.41.0+
2. Add `forui: ^0.18.0` to pubspec.yaml
3. Run `flutter pub upgrade forui --major-versions`
4. Update main.dart to wrap with FTheme
5. Migrate components incrementally (see ARCHITECTURE.md)
6. Remove old UI dependencies after full migration

---

*Research completed: 2026-04-05*
*Sources: forui.dev docs, pub.dev, web research*
