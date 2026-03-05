# Specifications: Core App Logic

## Features & Scenarios

### Feature: Add Fixed Expense
- Luan enters Light bill for "Março", R$ 300. 
- Type "FIXED". Division is divided by 3 unless specified.
- The UI automatically creates three split entries (R$ 100).
- Luan has `status` PAID (since he paid the whole).
- Luciana and Giovanna have `status` PENDING.

### Feature: Add Grocery Expense
- Luciana goes to the bakery. Value R$ 50. Total grocery limit R$ 1200.
- She inputs R$ 50, selects Category "MERCADO", logs the receipt picture.
- It subtracts R$ 50 from the global Grocery Limit.
- Does not create per-person splits because grocery budget is paid upfront. 

### Feature: Settle Debt (Pagamento Direto)
- Giovanna clicks on "Luz: Pagar minha parte (R$ 100)".
- She claims "Paid". This sends a notification to Luan.
- Luan approves or just trusts the status. (For MVP: Trust-based button that marks it as PAID).

## Non-Functional
- Offline: Not critical, Firebase cache works.
- Security: Requires only 3 users login.

## Error Handling
- Upload failing for receipts -> Must show snackbar.
- Cannot insert blank amounts.
