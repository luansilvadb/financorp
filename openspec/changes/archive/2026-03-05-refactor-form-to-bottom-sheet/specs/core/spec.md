## MODIFIED Requirements

### Requirement: Add Fixed Expense
- Luan clicks the Floating Action Button to open the "Nova Despesa" Bottom Sheet.
- Luan enters Light bill for "Março", R$ 300. 
- Type "FIXED". Division is divided by 3 unless specified.
- The UI automatically creates three split entries (R$ 100).
- Luan has `status` PAID (since he paid the whole).
- Luciana and Giovanna have `status` PENDING.
- **WHEN** user clicks "Adicionar Despesa" button inside the Bottom Sheet
- **THEN** it is internally stored and calculated correctly as 300.0 without crash
- **THEN** the Bottom Sheet is closed automatically

#### Scenario: Successful fixed expense addition via Bottom Sheet
- **WHEN** Luan fills the Light bill details in the Bottom Sheet and clicks "Adicionar Despesa"
- **THEN** three split entries of R$ 100 are created in Supabase
- **THEN** the Bottom Sheet disappears and the Despesas list reflects the new item

### Requirement: Add Grocery Expense
- Luciana clicks the Floating Action Button to open the "Nova Despesa" Bottom Sheet.
- Luciana goes to the bakery. Value R$ 50. Total grocery limit R$ 1200.
- She inputs R$ 50, selects Category "MERCADO", logs the receipt picture.
- It subtracts R$ 50 from the global Grocery Limit.
- Does not create per-person splits because grocery budget is paid upfront. 
- **WHEN** user clicks "Adicionar Despesa" button inside the Bottom Sheet
- **THEN** it is internally stored and calculated correctly as 50.0 without crash
- **THEN** the Bottom Sheet is closed automatically

#### Scenario: Successful grocery expense addition via Bottom Sheet
- **WHEN** Luciana fills the grocery expense details in the Bottom Sheet and clicks "Adicionar Despesa"
- **THEN** the value is subtracted from the global Grocery Limit in Supabase
- **THEN** the Bottom Sheet disappears and the Despesas list reflects the new item
