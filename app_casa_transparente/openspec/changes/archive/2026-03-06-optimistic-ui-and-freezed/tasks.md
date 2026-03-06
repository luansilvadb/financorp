## 1. Setup & Code Generation

- [x] 1.1 Add `freezed_annotation` and `json_annotation` to `dependencies` in `pubspec.yaml`
- [x] 1.2 Add `build_runner`, `freezed`, and `json_serializable` to `dev_dependencies` in `pubspec.yaml`
- [x] 1.3 Run `flutter pub get` to fetch dependencies

## 2. Model Migration

- [x] 2.1 Refactor `Despesa` model (`lib/shared/models/despesa.dart`) to a Freezed annotated class
- [x] 2.2 Refactor `CompraCartao` model (`lib/shared/models/compra_cartao.dart`) to a Freezed annotated class
- [x] 2.3 Refactor `Pagamento` model (`lib/shared/models/pagamento.dart`) to a Freezed annotated class
- [x] 2.4 Run `dart run build_runner build -d` to generate `.freezed.dart` and `.g.dart` files

## 3. Data Layer Updates

- [x] 3.1 Update `SupabaseFinanceRepository` methods to use `.toJson()` instead of `.toMap()`, and `.fromJson()` instead of `.fromMap()` for `Despesa` and `Pagamento`
- [x] 3.2 Update `SupabaseCartaoRepository` methods to use `.toJson()` instead of `.toMap()`, and `.fromJson()` instead of `.fromMap()` for `CompraCartao`

## 4. Provider Layer Updates (Optimistic UI)

- [x] 4.1 Update `despesasProvider` in `finance_providers.dart`: Remove `ref.invalidateSelf()` from `addDespesa`, `updateDespesa`, `deleteDespesa`, and `togglePagamento`. Instead, mutate `state` locally first using `copyWith`, wait for network, and rollback state on error.
- [x] 4.2 Update `cartaoProvider` in `cartao_providers.dart`: Remove `ref.invalidateSelf()` from `addCompra`, `updateCompra`, `deleteCompra`, and `togglePago`. Mutate `state` locally first using `copyWith`, wait for network, and rollback state on error.
- [x] 4.3 Add a global SnackBar error handler utility (e.g. `scaffoldMessengerKey`) to properly surface network rollback failures to the user.

## 5. UI and View Updates

- [x] 5.1 Ensure `DespesasTab`, `CartaoTab` and bottom sheets map the updated Freezed model properties correctly (if previously accessed via dynamic map or slightly different syntax).
- [x] 5.2 Test toggling a payment in `CartaoCard` to verify the mutation updates instantly with 0ms visual latency and no loading indicator.
- [x] 5.3 Verify that the `resumoProvider` correctly calculates statistics using the newly updated `state` from optimistic lists instead of relying on a post-fetch invalidation.
