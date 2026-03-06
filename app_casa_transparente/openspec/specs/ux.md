# Spec: UX Rebrand

## User Story
Como usuário gerindo despesas compartilhadas que afetam diretamente o meu bolso,
Eu quero que o app tenha um visual limpo, corporativo e com aura de banco premium,
Para que as interações de dívida e pagamentos transpareçam confiança e foco.

## Requirements
- Font Typography: A fonte principal do app deve mudar de fallback/Manrope para `Inter` via `GoogleFonts`.
- Navigation Icons:
  - Header (Ícone casa): `home` no header -> `PhosphorIcons.bank` (ou `buildings`).
  - Despesas Tab: `receipt_long` -> `PhosphorIcons.receipt`
  - Cartão Tab: `credit_card` -> `PhosphorIcons.creditCard`
  - Resumo Tab: `analytics` -> `PhosphorIcons.chartBar`
- Action & Action Modals:
  - Add FABs: `Icons.add_rounded` -> `PhosphorIcons.plus`
  - Status Indicators (Paid vs Pending): Substituir `check_circle` e `cancel` por equivalentes no Phosphor (`checkCircle`, `xCircle`)
  - Edit/Delete actions in expanded sheets: Replace standard Material line icons and filled icons inside rows.
- No Material Icons instances allowed anywhere to keep stroke width unified and minimalistic.
- Zero-Loading Toggles: The system SHALL eliminate visible network loading indicators (spinners, overlay sheets, full list invalidation loaders) for common list item mutations. Local state must update instantly.

## Edge Cases
- State Styling: Bottom Nav Selection states. Phosphor doesn't take standard fill amounts via Canvas color `fill`, instead, you call `PhosphorIcons.receipt(PhosphorIconsStyle.fill)` over `regular`. Custom conditional switches will be used depending on `selected` state instead of generic Material `.fill`.

## Acceptance Criteria
- [ ] Font rendering correctly changes from generic to Inter globally on UI start.
- [ ] Bottom navigation bar relies strictly on `PhosphorIcons`.
- [ ] List views update checkmarks and errors to `PhosphorIcons`.
- [ ] Action Modals (`AddExpenseSheet`, `AddPurchaseSheet`) adopt `PhosphorIcons` inputs.
- [ ] No `Icons.*` calls remain in the view layer codebase context except if fundamentally required by the framework text fields.
