# UI Spec: High-Density Expense Cards

## Visual Architecture
All `DespesaCard` and `CartaoCard` instances must behave as high-density list items.

### Card Anatomy
- **Leading / Identity**: (Optional) Emphasized textual avatar initial or icon (e.g. `[🛒]`) denoting the item class.
- **Title (Main Body)**: The description (e.g. 'Supermercado Condor') formatted with `Inter`, `SemiBold`, `Size 16`, dark/text primary color.
- **Subtitle (Main Body)**: The person's name and the date (e.g. 'Luan • 15/Dez') formatted with `Inter`, `Regular`, `Size 13`, subtext grey.
- **Trailing Text**: The monetary value (e.g. `R$ 150,00`) formatted with `Inter`, `Bold`, `Size 16`.
- **Trailing Action (Touch Target)**: 
  - Paid (`pago == true`): `PhosphorIcons.checkCircle(fill)` in `success_green`
  - Pending (`pago == false`): `PhosphorIcons.warningCircle(fill)` in `alert_red`
  - *Must be wrapped in an `InkWell` or `IconButton` with padded boundaries to prevent fat-finger issues, invoking `HapticFeedback` upon interaction.*

### Detailed Bottom Sheet Interaction
When a user taps the body of the card (anywhere outside the trailing status action), a `ModalBottomSheet` ascends.
The modal contains:
1. **Header**: The title and value of the expense prominently displayed.
2. **Details**: Date, Responsible Person, Month/Year context.
3. **Actions Container**:
   - `[ ✏️ Editar ]`: Primary-styled or Outline button invoking the existing Edit Form.
   - `[ 🗑️ Excluir ]`: Destructive-styled button invoking deletion logic (with confirmation if required).
   
## Transitions
- The cards themselves feature no internal dimensional changes. Smooth vertical scrolling is maintained.
- The Bottom Sheet ascends with the standard Flutter bottom-sheet transition, offering a swipe-down-to-dismiss feature.
- Marking an item as Paid/Pending visually updates the trailing icon instantly, without moving the card vertically.

## Accessibility & Error Prevention
- **Haptic Confirmations**: Ensure that any state mutation (toggling payment) provides a tactile response.
- **Hit Boxes**: The trailing checkbox area must be `kMinInteractiveDimension` (usually 48x48 points) structurally, even if the icon is physically smaller.
- **Touch Target Overlap**: The card body's `InkWell` (to open the sheet) and the trailing's `InkWell` (for payment status) must have distinct non-overlapping boundaries.
