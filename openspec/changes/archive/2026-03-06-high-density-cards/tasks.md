# Tasks: High-Density Expense Cards

## Implementation Steps

1. [x] **Create Detail Sheets**
   - Create `DespesaDetailsSheet` at `lib/features/finance/views/widgets/despesa_details_sheet.dart` to house the `Editar` and `Excluir` buttons, passing the `Despesa` object.
   - Create `CartaoDetailsSheet` at `lib/features/cartao/views/widgets/cartao_details_sheet.dart` to house the `Editar` and `Excluir` buttons, passing the `CompraCartao` object.

2. [x] **Simplify DespesaCard**
   - Remove `isExpanded` state and transformation logic from `DespesaCard` (found in `lib/features/finance/views/widgets/despesa_card.dart`).
   - Extract the `togglePayment` logic mapping to a dedicated trailing touch target in the row. Include `HapticFeedback.lightImpact();` in the callback.
   - Refactor the card's body to wrap in an `InkWell` or `GestureDetector` that calls `showModalBottomSheet(context: context, builder: (context) => DespesaDetailsSheet(despesa: despesa))`.
   - Update typography to follow the high-density layout constraints (Inter font weight refinement).

3. [x] **Simplify CartaoCard**
   - Remove `isExpanded` state and transformation logic from `CartaoCard` (found in `lib/features/cartao/views/widgets/cartao_card.dart`).
   - Extract the `togglePayment` logic mapping to a dedicated trailing touch target in the row. Include `HapticFeedback.lightImpact();` in the callback.
   - Refactor the card's body to wrap in an `InkWell` or `GestureDetector` that calls `showModalBottomSheet(context: context, builder: (context) => CartaoDetailsSheet(compra: compra))`.
   - Update typography to follow the high-density layout constraints (Inter font weight refinement).

4. [x] **Testing & QA**
   - Verify that lists scroll flawlessly with the new static heights.
   - Validate that tapped areas appropriately route: (A) Body goes to Sheet; (B) Right Icon triggers Payment Toggle.
   - Confirm haptic feedback fires confidently.
   - Validate that deleting from the Bottom Sheet appropriately removes the item and instantly updates Riverpod state, while correctly dismissing the sheet with `Navigator.pop(context)`.

5. [x] **Update Memory Bank Document**
   - Refresh the `memory-bank` with the knowledge regarding the newly simplified components and interaction model (Optimistic UI trailing taps vs Modal Detail Sheets).
