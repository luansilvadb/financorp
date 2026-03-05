# Implementation Tasks

## Preparation
- [x] 1. Scaffold a new Flutter project named `app_casa_transparente`.
- [x] 2. Setup Firebase/Supabase project in its console, integrate flutter plugin (`firebase_core`, `cloud_firestore` / `supabase_flutter`).
- [x] 3. Setup Riverpod for state management.

## Authentication
- [x] 4. Create Login UI (Email/Password or pre-defined magic link for 3 members).
- [x] 5. Hardcode or provision Auth Users: Luan, Luciana, Giovanna.

## Core Models & Providers
- [x] 6. Create Flutter models (classes) for `Expense` and `ExpenseSplit`.
- [x] 7. Create `DashboardProvider` that filters expenses of current month and aggregates total limits.

## Dashboard UI
- [x] 8. Implement Home Screen layout showing "My pending payments" (or Receivables).
- [x] 9. Show a list of Priority Expenses (Rent, Light, Water).

## Grocery Módulo
- [x] 10. Implement Grocery view: Total Month Budget vs Spent progress bar.
- [x] 11. Implement camera/image upload logic to Storage and "Add Grocery Expense" form.

## Shared Expenses Módulo
- [x] 12. Create "New Expense" screen (Fixed Expense vs Custom, auto-split logic by 3).
- [x] 13. Settle Debt logic (Mark as Paid button).

## Polish
- [x] 14. Adjust Push Notifications / Snackbars (App warnings).
- [x] 15. Make UI readable for non-tech-savvy users.
