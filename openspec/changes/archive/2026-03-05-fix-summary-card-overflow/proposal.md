## Why

The application currently throws a `RenderFlex overflowed by 1.00 pixels on the bottom` exception on the "Despesas" tab person summary cards. The hardcoded height constraint of 82.0 for the card container is too small by exactly 1 pixel for its contents (which sum up to 83.0 pixels), causing an overflow warning and clipping content. This needs to be fixed to ensure a clean, error-free UI.

## What Changes

- Modify the height constraint of the person summary card container in `lib/main.dart` to properly fit its children, either by increasing the hardcoded height (e.g., to 90.0 or 100.0) or removing the fixed height and letting the card size itself based on its padding and children.

## Capabilities

### New Capabilities
None

### Modified Capabilities
None (This is purely a bug fix / UI tweak, no spec behavior changes).

## Impact

- `lib/main.dart` (specifically the `_buildDespesasTab` -> person summary card generation).
- No APIs, dependencies, or system behaviors are affected.
