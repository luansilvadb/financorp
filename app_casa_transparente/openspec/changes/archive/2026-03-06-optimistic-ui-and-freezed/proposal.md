## Why

The current app relies on `ref.invalidateSelf()` to refresh data from Supabase after each mutation (e.g., marking a card item as paid). This causes a visible network loading delay (~300ms) which detracts from the premium "FinTech" feel. Furthermore, our current state models (`Despesa`, `CompraCartao`) are mutable and lack built-in robust deep-copy features, making complex local state manipulation risky.

Introducing **Freezed** and **Riverpod Generator** will provide dense, boilerplate-free immutable data models. This solid architectural foundation instantly unlocks the ability to implement **Optimistic UI**, where the app updates immediately (0ms latency visually) and syncs with the database in the background.

## What Changes

- Add `freezed`, `freezed_annotation`, and `json_annotation` dependencies.
- Add `build_runner` and `riverpod_generator` as dev dependencies.
- Migrate `Despesa`, `CompraCartao`, and `Pagamento` models to Freezed classes.
- Remove manual `toMap`/`fromMap` boilerplate and use Generated JSON Serialization.
- Update `finance` and `cartao` providers to perform **Optimistic Updates** (mutate state locally and fast-revert on failure) instead of triggering full list invalidations (`ref.invalidateSelf()`).
- Add visual feedback for sync errors (e.g., standard snackbar).

## Capabilities

### New Capabilities
- `optimistic-ux`: Specifications for immediate user feedback on mutations (Optimistic Updates) and rollback behavior.

### Modified Capabilities
- `ux`: Requirement change to eliminate visible loading screens for common, high-frequency actions such as toggling payment status.

## Impact

- **Models**: All data models in `lib/shared/models/` will be rewritten using Freezed syntax.
- **Providers**: `despesasProvider`, `cartaoProvider`, and their respective actions will be rewritten to optimistic patterns.
- **Dependencies**: New code generation tools added to the project, modifying the dev flow (requires `dart run build_runner build` on model changes).
- **UX**: The app response time moves to instantaneous, drastically improving user perception.
