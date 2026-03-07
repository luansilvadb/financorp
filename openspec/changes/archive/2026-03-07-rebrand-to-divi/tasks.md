# Tasks: Rebrand to DIVI

## 1. Global Setup & Documentation
- [x] 1.1 Update `MaterialApp` title in `lib/main.dart` to "DIVI"
- [x] 1.2 Update project memory-bank files (`projectbrief.md`, `productContext.md`, `activeContext.md`) with the new name and slogan: "Divida sem Dívida"

## 2. UI Rebranding
- [x] 2.1 Update `lib/core/views/splash_screen.dart` to show the "DIVI" logo and "Divida sem Dívida" slogan
- [x] 2.2 Update `HomeScreen._buildHeader` in `lib/main.dart` to replace "Gestão Financeira" with "DIVI" and include branding elements

## 3. Core Engine Refactor
- [x] 3.1 Rename `FinancorpEngine` to `DiviEngine` in `lib/core/finance_engine.dart`
- [x] 3.2 Rename `financeEngineProvider` to `diviEngineProvider` in `lib/core/finance_engine.dart`
- [x] 3.3 Update all files using the old engine/provider names (Perform a global find-and-replace)

## 4. Verification & Polish
- [x] 4.1 Verify the splash screen transition is smooth and animations align with the new branding
- [x] 4.2 Run the app to ensure all user-facing instances of "Casa Transparente" are replaced
