# Technical Design: Rebrand to DIVI

## Context
The application currently identifies as "Casa Transparente" or "Financorp". While the architecture is solid (FinancorpEngine), the brand lacks a cohesive and memorable identity. We are transitioning to **DIVI**, focusing on the tagline "Divida sem Dívida".

## Goals
- Update all user-facing strings to "DIVI".
- Implement the "Divida sem Dívida" slogan.
- Refresh the Splash Screen and Header UI.
- Update project documentation (Memory Bank).

## Non-Goals
- Major layout restructuring (the current High-Density cards and Gooey Nav are retained).
- Database schema changes (Postgres tables can keep current names).

## Implementation Details

### 1. Global Rebranding
- **App Title**: Change the `MaterialApp` title to "DIVI".
- **Header**: Update the `_buildHeader` method in `HomeScreen` or the specific tabs to show "DIVI" as the primary brand.

### 2. Splash Screen Refinement
- Update `lib/features/splash/splash_screen.dart` (or `SplashScreen` widget in `main.dart` depending on current structure) to show the new "DIVI" logo.
- Add the slogan "Divida sem Dívida" below the logo with a smooth fade-in animation.

### 3. Engine & Logic Naming
- Rename `FinancorpEngine` to `DiviEngine` and `financeEngineProvider` to `diviEngineProvider` for consistency.
- Update all references to the engine in the domain and presentation layers.

### 4. Color Palette
- Retain the **Navy Blue** background (`0xFF111621`) and **Electric Blue** (`0xFF195de6`) primary color, but consider adding a **Mint Green** accent for success/paid states to reinforce the "balanced" feeing.

## Risks / Trade-offs
- **Internal Consistency**: Renaming the core engine might require thorough find-and-replace to avoid breaking Riverpod `select` listeners.
- **Cache Persistence**: Cached data on user devices might still reference "Financorp" until refreshed.
