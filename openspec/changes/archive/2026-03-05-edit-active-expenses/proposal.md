## Why

Atualmente, o sistema permite apenas a criação e exclusão de despesas e gastos no cartão. Não há uma forma direta de corrigir erros de digitação ou atualizar valores de despesas ativas sem ter que excluí-las e criá-las novamente, o que prejudica a experiência do usuário e a agilidade na gestão financeira.

## What Changes

- Adição da capacidade de editar despesas fixas (aba Despesas).
- Adição da capacidade de editar gastos individuais de cartão (aba Cartão).
- Refatoração dos Bottom Sheets de adição (`AddExpenseSheet` e `AddPurchaseSheet`) para suportarem o modo de edição.
- Inclusão de botões de "Editar" na interface de cards expandidos.
- Implementação de validação básica nos formulários (nome obrigatório, valor maior que zero).

## Capabilities

### New Capabilities
- `edit-finance-records`: Capacidade de modificar registros financeiros existentes (despesas e compras) preservando integridade de vínculos (como pagamentos).

### Modified Capabilities
- `consolidated-expense-list`: A lista agora deve suportar a trigger para edição de cada item.
- `ui-bottom-sheets`: Os bottom sheets de formulário agora devem suportar o estado de edição (preenchimento prévio e alteração de títulos/botões).

## Impact

- **Features**: `finance`, `cartao`.
- **UI Components**: `DespesasTab`, `CartaoTab`, `AddExpenseSheet`, `AddPurchaseSheet`.
- **Models**: `Despesa`, `CompraCartao` (sem mudanças estruturais, apenas uso dos métodos existentes).
- **Providers**: `DespesasNotifier`, `CartaoNotifier` (adição de métodos de atualização ou uso aprimorado do `save`).
