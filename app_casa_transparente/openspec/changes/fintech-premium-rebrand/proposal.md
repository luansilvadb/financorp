# Proposal: Fintech Premium Rebrand

## Motivation
The app currently uses standard Material icons and the Manrope font. While clean, this gives a slightly generic appearance, resembling basic utility apps more than modern financial tools. To invoke a "FinTech Premium" or "Private Banking" vibe that feels authoritative, minimalistic, and hyper-clear for users tracking expenses, we need a corporate redesign. This will increase perceived value and make interacting with debts/payments feel more professional.

## Scope
- Pre-install `google_fonts` and `phosphor_flutter` dependencies (already completed in explore phase).
- Replace the app's global font setup to use `GoogleFonts.interTextTheme()` for sleek, precise labeling. We will use Inter for all text and numbers to provide a Stripe/Nubank-like minimalistic cleanliness.
- Replace default Material Icons in the `HomeScreen` Navigation Bar and header with sleek `phosphor_flutter` equivalents (e.g., `PhosphorIcons.receipt`, `PhosphorIcons.creditCard`, `PhosphorIcons.chartBar`).
- Adjust UI references to standard Material Icons in the tabs (`DespesasTab`, `CartaoTab`, `ResumoTab`) to use matching `PhosphorIcons`.

## Impact
- `pubspec.yaml` updated with new packages.
- `main.dart` theme initialization changed.
- Navigation items in `main.dart` updated.
- Icons such as `receipt_long`, `credit_card`, `analytics`, `home_outlined` replaced globally.
- Icon styles inside specific screens and Bottom Sheets updated to Phosphor.
