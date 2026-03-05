## Why

When entering values for expenses (e.g., "Valor total (R$)"), the user cannot freely type values in the Brazilian Real currency format (e.g., "1500,00"). The current input accepts numeric values but does not format them as currency (BRL), making it difficult and less intuitive to input monetary amounts correctly. 

## What Changes

- Update the total value input field in the fixed expense module ("Despesas") to automatically format the text as Brazilian Real currency typing (e.g., "1.500,00").
- Update the value input field in the credit card purchase module ("Cartão") to use the same currency formatting.
- Ensure the underlying data models `Despesa` and `CompraCartao` continue to parse the correctly formatted string back into a numeric `double` for calculation purposes.

## Capabilities

### New Capabilities
None

### Modified Capabilities
- `core`: Expense input fields (Fixed Expenses, Credit Card Purchases) must accept and properly format BRL currency amounts instead of raw numbers.

## Impact

- `lib/main.dart`: The input fields for `Valor total (R$)` in the "Despesas" tab and the value field in the "Cartão" tab will be modified. A text input formatter logic for Brazilian currency will be implemented or added as a project dependency.
- Value parsing logic will be updated where user input strings are converted to `double`s.
