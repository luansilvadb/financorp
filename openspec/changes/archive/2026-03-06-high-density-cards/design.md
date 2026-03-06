# Design: High-Density Expense Cards

## Architecture Context
Currently, the application uses `DespesaCard` and `CartaoCard` built as `ConsumerStatefulWidget`s to manage an internal `isExpanded` state. This state conditionally renders the action buttons (Pagamento, Editar, Excluir) below the main details. This pattern decreases vertical density in the list and causes sudden layout shifts (accordion effect) during user interactions.

## Technical Design
1. **Remove Local Expansion State**:
   - Refactor `DespesaCard` and `CartaoCard` to eliminate the `isExpanded` state. 
   - Extract the action logic to separate visual components to clean up the card's build methods.

2. **One-Tap Action (Trailing Checkmark Target)**:
   - The rightmost area of the card (trailing), which currently only displays the status icon (`PhosphorIcons.checkCircle(fill)` or `warningCircle(fill)`), will become an interactive touch target (`InkWell`).
   - Tapping this localized trailing area will directly trigger the `togglePayment` logic originally bound to the internal row button.
   - `HapticFeedback.lightImpact()` will be injected into the tap callback before the state is updated to signal the instant `optimistic` change.

3. **Detail Bottom Sheet (Card Body Target)**:
   - Create new widgets: `DespesaDetailsSheet` and `CartaoDetailsSheet`.
   - Wrap the main body of the card in a gesture detector that displays the relevant Bottom Sheet via `showModalBottomSheet(context: context, builder: (_) => ...)`.
   - The sheet itself will follow our established modal aesthetic (circular top radius) and will house the `Editar` and `Excluir` large buttons, as well as a more detailed and spaced-out view of the transaction.

## UI / Visual Tuning
- **Hierarchy Refinement**: Adopt standard ListTile dimensions but optimized for our content. Use the Inter font weight variations to prioritize readability: Description (SemiBold) and Value (Bold) will pop, while Name/Date (Regular, greyish) step back.
- **No Layout Shift**: Tapping to expand a card is replaced completely; lists will now scroll smoothly and uniformly.

## Trade-offs and Risks
- **Fat-finger Error**: A user might try to tap to see details but accidentally hit the toggle payment action instead. Ensuring the trailing touch target is well-sized but bounded to the icon's immediate padding minimizes this risk. The `HapticFeedback` confirms the action taken transparently.
- **Discoverability**: Tapping the center of the list item to see "more actions" (edit/delete) must feel natural. By making the list item physically distinct and perhaps giving it a slight active color touch effect on tap, users will instinctively explore it without needing explicit `[More]` buttons.
