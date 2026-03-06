## Context

The current `app_casa_transparente` state management architecture leverages Riverpod together with hand-written model classes. When mutations occur (e.g., toggling a payment to "paid"), the app performs a full list fetch using `ref.invalidateSelf()` inside the providers. This triggers the global `AsyncLoading` state, causing a visual flash that feels sluggish given network latencies to Supabase. This undermines the requested "FinTech Premium" UX and causes unnecessary data ingress/egress.

To implement instantaneous, Optimistic Updates, we need robust deep-copy mechanisms to modify local state without waiting for the server, accompanied by rollback logic in the event of failure.

## Goals / Non-Goals

**Goals:**
- Eliminate visible loading states on state mutations (e.g., payment toggles) across `despesasProvider` and `cartaoProvider`.
- Introduce `freezed` and `json_annotation` for creating robust, immutable model classes.
- Ensure state reversions (rollbacks) are executed seamlessly if Supabase network calls fail.

**Non-Goals:**
- Offline-first persistence via SQLite/Hive (data is still required to be online for reading).
- Generating fully new architectural layers (sticking to the currently established `data/`, `providers/`, `views/`).

## Decisions

**1. Using the `freezed` package**
- *Decision*: Introduce the `freezed` package along with `build_runner`.
- *Rationale*: Freezed generates `copyWith`, equality overrides (Deep-Equality), and JSON serialize/deserialize methods, which are paramount for optimistic updates and preserving optimal Riverpod caching. 
- *Why over alternatives?*: Hand-writing `copyWith` and `Equatable` is error-prone and verbose. `freezed` provides compile-time safety.

**2. Optimistic UI inside Notifiers**
- *Decision*: Repurpose action methods in Riverpod `AsyncNotifier`s to modify `state` before making the network request.
- *Rationale*: 
  ```dart
  // Example update logic inside Riverpod Notifier:
  final previousState = state;
  state = state.whenData((list) => list.map((item) => item.id == id ? item.copyWith(pago: newStatus) : item).toList());
  try {
    await repository.update(...); // Network call
  } catch (err) {
    state = previousState; // Rollback
    // Emit UI Error somehow, like via a global SnackBar service or throwing an error caught by the view.
  }
  ```
  This skips `ref.invalidateSelf()` and the resulting loading frame.

**3. Error Handling for Rollbacks**
- *Decision*: When a rollback happens, the UI needs to reflect why the change was undone.
- *Rationale*: We'll throw an exception from the notifier after replacing the local state, allowing the caller (the Widget via button press) to catch it and display a `ScaffoldMessenger.showSnackBar()`.

## Risks / Trade-offs

- **[Risk]** Increasing app build times and IDE sluggishness during dev.
  - *Mitigation*: Run `dart run build_runner watch -d` during active model development, and only when models change.
- **[Risk]** Race conditions if multiple optimistic updates happen concurrently and one fails.
  - *Mitigation*: Given the app's scope (3 users, mostly single-device usage context), collisions are rare. We will accept slight de-synchronization in the rare event of concurrent contradictory failure, falling back to a pull-to-refresh if needed.

## Migration Plan
1. Add dependencies to `pubspec.yaml`
2. Update `Despesa`, `CompraCartao`, and `Pagamento` classes to use `@freezed` syntax and run `build_runner`.
3. Fix all compiler errors resulting from the old `.toMap()` / `.fromMap()` usages in the UI and repository layers.
4. Update provider mutation methods (`add`, `delete`, `togglePayment`) to use the new Optimistic UI pattern.
