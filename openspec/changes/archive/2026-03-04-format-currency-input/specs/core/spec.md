## ADDED Requirements

### Requirement: Currency Formatting
Input fields for monetary values MUST format user input as Brazilian Real (BRL) currency in real-time as they type.

#### Scenario: User enters a valid monetary amount
- **WHEN** the user types "1500" in the "Valor total" or purchase value input field
- **THEN** the input field displays "1.500,00"
- **THEN** the underlying saved value is `1500.0`

#### Scenario: User saves a formatted amount
- **WHEN** the user saves an expense with value "R$ 1.500,00" (or "1.500,00")
- **THEN** it is internally stored and calculated correctly as 1500.0 without crash
