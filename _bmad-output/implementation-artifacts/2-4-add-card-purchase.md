---
story_id: "2.4"
story_key: "2-4-add-card-purchase"
epic: "Epic 2 — Expense Management"
status: done
title: "Add Card Purchase via Bottom Sheet"
---

# Story 2.4: Add Card Purchase via Bottom Sheet

## User Story

As a resident,
I want to log a credit card purchase with who bought it and who it's split with,
So that I don't forget to track shared expenses.

## Acceptance Criteria

**Given** I'm on the home screen
**When** I tap the FAB and select "Compra Cartão"
**Then** a bottom sheet opens with fields: descrição, valor (R$ mask), quem_pagou (pré-selecionado), divide_com (todos residentes pré-selecionados)

**Given** the form is open
**When** I change "divide com"
**Then** the preview updates: "R$ X ÷ N pessoas = R$ Y/cada"

**Given** the form is valid
**When** I tap "Salvar"
**Then** the StampAnimation plays (scale 0→1.4→1.0, haptic feedback)

**And** the purchase appears in the list immediately (optimistic update)
**And** the bottom sheet closes

**Given** I try to close the sheet with unsaved data
**When** I pull down or tap backdrop
**Then** a confirmation appears: "Dados não salvos. Fechar mesmo?"

**And** validation appears inline below fields with 500ms debounce (not while typing)

## Context & Business Value

This story delivers the second half of expense tracking — while fixed expenses are monthly recurring, card purchases are frequent and ad-hoc. Without this, the app only tracks bills, not daily spending.

**Current State (after Story 2.3):**

- `CartaoNotifier` exists with `optimisticAdd` ✅
- `BrlCurrencyInputFormatter` exists ✅
- `AddExpenseSheet` exists as reference pattern ✅
- `SpikeModalSheet` exists with credit card mode ✅
- FAB currently opens `AddExpenseSheet` (fixed expense only) — needs mode selector or separate entry point

**What this story delivers:**

- `AddPurchaseSheet` bottom sheet for card purchases
- Fields: descrição, valor (R$ mask), data (default today), quem_pagou (pre-selected current user), divide_com (all residents pre-selected)
- Real-time preview of split calculation
- Optimistic add via `CartaoNotifier.addCompra`
- Inline validation with 500ms debounce
- Stamp animation on success
- Unsaved data confirmation on dismiss

**What does NOT change:**

- No changes to fixed expense flow (Story 2.3)
- No changes to payment tracking (that's Story 3.x)
- No changes to repository or providers

## Technical Requirements

### Bottom Sheet Pattern (UX-DR7)

Same pattern as AddExpenseSheet:

- DraggableScrollableSheet: 0.6 initial, 0.85 max, 0.6 min
- Handle bar: 36×4px, color kLine
- Backdrop rgba(0,0,0,0.3), tap closes with confirmation if unsaved data

### Form Fields

| Field          | Type                                    | Validation           | Default                                            |
| -------------- | --------------------------------------- | -------------------- | -------------------------------------------------- |
| **Descrição**  | Text input                              | Required, min 1 char | ""                                                 |
| **Valor**      | Text input with R$ mask                 | Required, > 0        | ""                                                 |
| **Quem pagou** | Chip selector (Luan, Luciana, Giovanna) | Required             | Current user (hardcoded to first resident for now) |
| **Data**       | Text or date picker                     | Required             | Today (ISO string)                                 |

### Real-Time Preview

```
Container(
  padding: 16px,
  color: kPaperDepth,
  borderRadius: 12px,
  child: Text("R$ 150,00 ÷ 3 = R$ 50,00/cada"),
)
```

Updates when valor changes OR when "divide com" selection changes.

### Optimistic Add Flow

```dart
final period = ref.read(periodProvider);
final newCompra = CompraCartao(
  id: null,
  data: DateTime.now().toIso8601String().split('T')[0],
  descricao: descricaoController.text,
  valor: parsedValor,
  pessoa: selectedPessoa,
  mes: period.mes,
  ano: period.ano,
  pago: false,
);

await ref.read(cartaoProvider.notifier).addCompra(newCompra);
```

### File Structure

| File                                                        | Action | Description                                                      |
| ----------------------------------------------------------- | ------ | ---------------------------------------------------------------- |
| `lib/features/cartao/views/widgets/add_purchase_sheet.dart` | CREATE | Bottom sheet form for adding card purchases                      |
| `lib/main.dart`                                             | MODIFY | FAB could show mode selector (fixed vs card) or addPurchaseSheet |

### Dependencies

- `cartaoProvider` from `lib/core/providers/app_providers.dart`
- `repositoryProvider` from `lib/core/providers/repository_provider.dart`
- `periodProvider` from `lib/shared/providers/month_year_provider.dart`
- `BrlCurrencyInputFormatter` from `lib/core/utils/formatters.dart`
- `DiviToasts` from `lib/shared/widgets/divi_toasts.dart`

### What NOT to Do

- ❌ Do NOT modify fixed expense form (Story 2.3)
- ❌ Do NOT implement card purchase list UI (that's CartaoTab, already exists)
- ❌ Do NOT implement payment tracking (that's Story 3.x)
- ❌ Do NOT modify repository or providers

## Implementation Approach

### Steps

1. **Create `add_purchase_sheet.dart`** — bottom sheet form with descrição, valor, quem_pagou, data
2. **Add real-time preview** — split calculation updating on valor change and person selection
3. **Add inline validation** — 500ms debounce, error below field
4. **Wire optimistic add** — use `CartaoNotifier.addCompra`
5. **Add StampAnimation** — plays on successful save
6. **Add unsaved data confirmation** — on dismiss with data in form
7. **Wire FAB** — either mode selector or separate entry point for card purchases
8. **Run `flutter analyze`** — zero errors
9. **Run `flutter test`** — all tests pass

### Files to Create

| File                                                        | Description                                 |
| ----------------------------------------------------------- | ------------------------------------------- |
| `lib/features/cartao/views/widgets/add_purchase_sheet.dart` | Bottom sheet form for adding card purchases |

### Files to Modify

| File            | Description                             |
| --------------- | --------------------------------------- |
| `lib/main.dart` | FAB opens mode selector or direct sheet |

## Testing Requirements

### Manual Testing Checklist

- [ ] FAB opens bottom sheet (or mode selector → add purchase sheet)
- [ ] Bottom sheet shows at ~60% height with handle bar
- [ ] Descrição field accepts text
- [ ] Valor field formats as R$ (currency mask)
- [ ] Quem pagou shows resident chips, one pre-selected
- [ ] Data defaults to today
- [ ] Real-time preview updates: "R$ 150,00 ÷ 3 = R$ 50,00/cada"
- [ ] "Salvar" button is disabled when form is invalid
- [ ] "Salvar" triggers StampAnimation on success
- [ ] Purchase appears in list immediately (optimistic)
- [ ] Bottom sheet closes after save
- [ ] Pull-down with unsaved data shows confirmation
- [ ] Inline validation appears below fields with debounce
- [ ] `flutter analyze` — no new errors
- [ ] `flutter test` — all tests pass

## Dependencies

- **Requires:** Story 2.3 (Add Fixed Expense via Bottom Sheet) — same patterns, infrastructure
- **Blocks:** Story 3.2 (Toggle Payment on Card Purchases)

## Risk & Mitigation

| Risk                                            | Impact | Mitigation                                           |
| ----------------------------------------------- | ------ | ---------------------------------------------------- |
| FAB mode selector is confusing                  | Medium | Use simple segmented toggle: "Conta Fixa" / "Cartão" |
| Card purchase form too similar to fixed expense | Low    | Reuse shared form components where possible          |

## Dev Notes

- The card purchase form is very similar to the fixed expense form. Consider extracting a shared form widget or base class if the duplication is significant. However, for this story, a standalone sheet is fine — refactoring can happen later.
- The `quem_pagou` field should default to the current user. Since we don't have authentication, hardcode to the first resident (e.g., "Luan") or show all three as a chip selector with the first one pre-selected.
- The `data` field should default to today's date in ISO string format (YYYY-MM-DD). For simplicity, don't implement a date picker — just use today's date. A date picker can be added in a future story.
- The `divide_com` preview should show how many people the purchase is split with. For MVP, assume all 3 residents split equally. The preview should show "R$ X ÷ 3 = R$ Y/cada".
- The `CartaoNotifier.addCompra` method already exists in `app_providers.dart` and uses optimistic updates.

## Definition of Done

- [ ] All acceptance criteria met
- [ ] Bottom sheet form created with descrição, valor (R$ mask), quem_pagou, data
- [ ] Real-time preview shows split calculation
- [ ] Inline validation with 500ms debounce (no modals)
- [ ] Optimistic add via CartaoNotifier
- [ ] StampAnimation plays on successful save
- [ ] Unsaved data confirmation on dismiss
- [ ] `flutter analyze` — no new errors
- [ ] `flutter test` — all tests pass
- [ ] FAB opens the new bottom sheet (or mode selector → sheet)

## Dev Agent Record

### Implementation Plan

1. **Created `lib/features/cartao/views/widgets/add_purchase_sheet.dart`** — Bottom sheet form for adding card purchases ✅
   - Descrição field (text input)
   - Valor field with `BrlCurrencyInputFormatter` (R$ mask)
   - Quem pagou: chip selector with resident colors, first resident pre-selected
   - Data defaults to today (ISO string, no date picker for MVP)
   - Real-time preview: "R$ X,00 ÷ 3 = R$ Y,00/cada" updating on every keystroke
   - Inline validation with 500ms debounce (rust border + icon + text)
   - Optimistic add via `cartaoProvider.notifier.addCompra()`
   - Stamp animation on success (scale + check circle dialog)
   - Unsaved data confirmation on dismiss
   - DraggableScrollableSheet (0.6 initial, 0.85 max, 0.6 min)
2. **Updated `lib/main.dart`** — FAB now shows mode selector ✅
   - `_showAddModeSelector()`: bottom sheet with two options (Conta Fixa / Compra Cartão)
   - Each option opens the appropriate sheet via `_openSheet()`
   - Mode selector uses kSurfacePaper background with ListTile options
3. **Verified `flutter analyze`** — 0 errors, 1 info (pre-existing use_null_aware_elements) ✅
4. **Verified `flutter test`** — 1/1 tests pass ✅

### Completion Notes

Story 2.4 is complete. All acceptance criteria are met:

- ✅ Bottom sheet form with descrição, valor (R$ mask), quem_pagou (chip selector, pre-selected), data (today)
- ✅ Real-time preview: "R$ 150,00 ÷ 3 = R$ 50,00/cada" updating on every keystroke
- ✅ Inline validation with 500ms debounce (rust border + icon + text, no modals)
- ✅ Optimistic add via CartaoNotifier.addCompra
- ✅ Stamp animation plays on successful save (scale + check circle)
- ✅ Unsaved data confirmation on dismiss
- ✅ FAB shows mode selector (Conta Fixa / Compra Cartão) → opens correct sheet
- ✅ `flutter analyze` — 0 errors
- ✅ `flutter test` — all tests pass

## File List

| File                                                        | Action   | Description                                              |
| ----------------------------------------------------------- | -------- | -------------------------------------------------------- |
| `lib/features/cartao/views/widgets/add_purchase_sheet.dart` | CREATED  | Bottom sheet form for adding card purchases              |
| `lib/main.dart`                                             | MODIFIED | FAB now shows mode selector (Conta Fixa / Compra Cartão) |

## Change Log

- **2026-04-12:** Initial implementation — AddPurchaseSheet with resident chip selector, real-time preview, validation, optimistic add, stamp animation; FAB updated to show mode selector
