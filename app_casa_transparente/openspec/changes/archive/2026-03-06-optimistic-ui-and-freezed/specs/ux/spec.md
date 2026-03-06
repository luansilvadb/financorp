## ADDED Requirements

### Requirement: Zero-Loading Toggles
The system SHALL eliminate visible network loading indicators (spinners, overlay sheets, full list invalidation loaders) for common list item mutations.

#### Scenario: User toggles payment status on a debit item
- **WHEN** the user presses the payment checkmark status
- **THEN** the system immediately updates the layout locally and hides any loading indications normally associated with the mutation
