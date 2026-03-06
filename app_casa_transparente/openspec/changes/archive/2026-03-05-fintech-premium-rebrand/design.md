# Design: Fintech Premium Rebrand

## Architecture
- Replace the current font with `GoogleFonts.interTextTheme()` inside the top-level `CasaApp` (`main.dart`).
- Switch any inline `fontFamily: 'Manrope'` overrides to use standard text style derivations to stick to the global theme.
- The `PhosphorIcons` package exposes distinct styles (`regular`, `fill`, `bold`, etc.).
  - Navigation inactive states: use `PhosphorIconsStyle.regular`.
  - Navigation active states: since Phosphor provides different styles as constructor arguments, we can switch `style` based on selection, e.g. `PhosphorIcons.receipt(PhosphorIconsStyle.fill)`.

## Data Models
- No backend/data model changes required.

## UI/UX Mapping
- Home/Header: `Icons.home_outlined` -> `PhosphorIcons.bank()`
- Despesas (Tab 1): `Icons.receipt_long` -> `PhosphorIcons.receipt()`
- Cartão (Tab 2): `Icons.credit_card` -> `PhosphorIcons.creditCard()`
- Resumo (Tab 3): `Icons.analytics` -> `PhosphorIcons.chartBar()`
- Actions:
  - Add: `Icons.add_rounded` -> `PhosphorIcons.plus()`
  - Edit: `Icons.edit_outlined` -> `PhosphorIcons.pencilSimple()`
  - Delete: `Icons.delete_outline` -> `PhosphorIcons.trash()`
  - Success/Check: `Icons.check_circle` -> `PhosphorIcons.checkCircle()`
  - Error/Cancel: `Icons.error` / `Icons.cancel` -> `PhosphorIcons.xCircle()` ou `warningCircle()`

## Integration Points
- Modification strictly relates to UI view layers (the `features/*/views/` and `shared/` directories). Logic in `providers` remains untouched.

## Security & Performance
- Fonts will be downloaded and cached by `google_fonts` automatically.
- Performance impact minimal as the `phosphor_flutter` pack relies on vector drawing similar to Cupertino/Material fonts.
