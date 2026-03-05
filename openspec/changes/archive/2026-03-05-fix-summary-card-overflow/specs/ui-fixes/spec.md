## ADDED Requirements

### Requirement: Summary Card Layout Constraints
The system SHALL ensure the person summary card layout in the Despesas tab does not overflow horizontally or vertically on standard resolutions.

#### Scenario: Rendering the person summary card
- **WHEN** the UI renders the person summary card with name, despesas amount, cartao amount, and status text
- **THEN** the elements render cleanly without a RenderFlex overflow exception
