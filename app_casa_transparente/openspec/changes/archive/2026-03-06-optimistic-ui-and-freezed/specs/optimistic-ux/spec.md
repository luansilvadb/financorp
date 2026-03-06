## ADDED Requirements

### Requirement: Instant Mutation Feedback (Optimistic UI)
The system SHALL provide instantaneous visual feedback (0ms latency visually) for data mutations, specifically toggling payment status, adding, editing, or deleting items.

#### Scenario: Toggling a payment status successfully
- **WHEN** the user taps the payment toggle button on a card
- **THEN** the UI immediately reflects the new state (e.g., changes to green/paid) without showing a loading indicator
- **WHEN** the background network request succeeds
- **THEN** the UI remains in the requested state silently without full list invalidation

#### Scenario: Toggling a payment status with network failure
- **WHEN** the user taps the payment toggle button on a card causing an optimistic update
- **THEN** the UI immediately reflects the new state
- **WHEN** the background network request fails
- **THEN** the UI reverts to the original state
- **THEN** the system displays an error message explaining the failure

### Requirement: Immutable Data Models
The system SHALL utilize formal immutable data models for `Despesa`, `CompraCartao`, and `Pagamento` to safely support optimistic local state modifications.

#### Scenario: Deep copying state
- **WHEN** a provider needs to update a single item in a list optimistically
- **THEN** it generates a deeply-copied version of the item with the modification using the generated `copyWith` method
