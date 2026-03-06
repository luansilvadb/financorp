# Proposal: High-Density Expense Cards

## Motivation
Currently, the app relies on expandable cards (`DespesaCard` and `CartaoCard`) to reveal secondary actions (Pay, Edit, Delete). This expandable state causes UI layout shifts, consumes excess vertical space, and requires multiple taps to perform the primary action of marking an item as paid/pending. By transitioning to a high-density "ListTile" style card, we can optimize screen real estate, closely align with our premium FinTech aesthetic (Inter font, PhosphorIcons), and make the app far more efficient for daily use without compromising accessibility for non-technical users.

## Proposed Change
1. **High-Density Compact Cards**: Remove the expandable nature of the cards. The card will act as a clean, compact row showing the description, the person, the date, the amount, and the current payment status.
2. **One-Tap Payment**: Transform the right-hand side of the card (the status icon ✅/❌) into an active touch target. Tapping it will instantly toggle the payment status with light haptic feedback.
3. **Detail Bottom Sheet**: Tapping anywhere on the main body of the card will slide up an elegant Bottom Sheet. This sheet will display the full details of the transaction alongside large, clear buttons for the secondary actions: `[ ✏️ Editar ]` and `[ 🗑️ Excluir ]`.

## Impact
- **UI/UX**: Smoother scrolling (no layout shifts). Increased information density per screen (users can see more items at once). Immediate, one-tap payment marking.
- **Affected Code**: 
  - `DespesaCard` and `CartaoCard` will be simplified. The expansion state logic will be removed.
  - New components `DespesaDetailsSheet` e `CartaoDetailsSheet` will be created to house the details, edit, and delete actions.
