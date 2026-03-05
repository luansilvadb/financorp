## 1. Setup

- [x] 1.1 Add `currency_text_input_formatter` (or standard `intl`) to `pubspec.yaml`
- [x] 1.2 Run `flutter pub get` to install the dependency

## 2. Implementation

- [x] 2.1 Create `CurrencyUtils` to handle string-to-double parsing and sanitization for Brazilian Real (BRL)
- [x] 2.2 Update the "Valor total" input in the Despesas view to use `CurrencyTextInputFormatter`
- [x] 2.3 Update the purchase value input in the Cartão view to use `CurrencyTextInputFormatter`
- [x] 2.4 Update the `onChanged` / saving logic in both forms to properly parse the formatted string using `CurrencyUtils` before storing as `double`

## 3. Testing and Validation

- [x] 3.1 Verify entering amounts works naturally (e.g. typing "1500" translates to "1.500,00" in field)
- [x] 3.2 Verify calculations still work correctly after string-to-double parsing (e.g., auto-splitting fixed expenses splits the parsed total without throwing parsing exceptions)
