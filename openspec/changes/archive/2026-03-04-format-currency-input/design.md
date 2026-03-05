## Context

Currently, the application value input fields (for "Despesas" and "Cartão") allow only plain text numeric entry. Users cannot type currency in the Brazilian real format (e.g., "1.500,00"), which makes amount entry less intuitive and prone to errors.

## Goals / Non-Goals

**Goals:**
- Mask the input real-time as the user types to reflect BRL formatting (e.g., `1.500,00`).
- Seamlessly convert the string back to a `double` for calculation and saving logic.

**Non-Goals:**
- Implementing multi-currency support.
- Refactoring the entire forms structure or styling.

## Decisions

We will add a dependency on a standard Flutter package that handles currency input (e.g., `currency_text_input_formatter` or `intl`).
The text input controller will use this formatter. When the value is submitted or saved, the string (which will look like "1.500,00") will be sanitized (removing dots and parsing commas as decimals) so that it can be stored as a `double` in the `valor` field of `Despesa` and `CompraCartao`.

## Risks / Trade-offs

- [Risk] Parsing the masked text back to `double` might crash if not sanitized properly. -> Mitigation: Implement a robust sanitization function that replaces `,` with `.` and removes `.` grouping separators before calling `double.parse()`.
