# Specifications: Core App Logic

## Features & Scenarios

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
### Feature: Settle Debt (Pagamento Direto)
- Giovanna clicks on "Luz: Pagar minha parte (R$ 100)".
- She claims "Paid". This sends a notification to Luan.
- Luan approves or just trusts the status. (For MVP: Trust-based button that marks it as PAID).

## Non-Functional
- Offline: Not critical, Firebase cache works.
- Security: Requires only 3 users login.
- Persistence: Data is persisted in Supabase (PostgreSQL) for remote synchronization.
- State Management: Riverpod providers handle global state and synchronization between tabs.

## Requisitos de Arquitetura (Sync from change: refactor-modular-supabase-riverpod)
### Requirement: Persistência no Supabase
O sistema deve salvar todas as operações de escrita no banco de dados remoto para garantir que os dados sobrevivam ao reinício do aplicativo.
- **GIVEN** O aplicativo está conectado à internet.
- **WHEN** O usuário adiciona uma despesa ou compra de cartão.
- **THEN** O dado deve ser persistido imediatamente no PostgreSQL do Supabase.

### Requirement: Sincronização de Estado (Riverpod)
O estado das abas deve ser gerenciado por providers para evitar inconsistência de dados entre as visualizações (Despesas vs Resumo).
- **GIVEN** Uma despesa marcada como paga na aba de Despesas.
- **WHEN** O usuário navega para a aba de Resumo.
- **THEN** O valor pendente da pessoa deve estar atualizado refletindo o pagamento.

### Requirement: Filtro por Período
A navegação por mês e ano MUST filtrar todos os dados (despesas, compras e pagamentos) de forma consistente e oferecer inteligência de transição.
- **GIVEN** O seletor de mês está em um determinado período.
- **WHEN** O usuário navega entre as abas.
- **THEN** Apenas os dados referentes ao mês/ano selecionado devem ser exibidos.
- **THEN** Transições entre Dezembro e Janeiro devem ajustar o ano automaticamente.
- **THEN** Atalhos para o período atual (mês/ano de hoje) devem estar disponíveis.

#### Scenario: Filtro Consistente
- **WHEN** O seletor de mês está em "Março/2026"
- **THEN** Apenas despesas, compras e status de pagamento de Março/2026 são exibidos.

#### Scenario: Virada de Ano Automática
- **WHEN** O período está em "Dezembro/2026" e o usuário clica em "Janeiro" (Próximo)
- **THEN** O app altera para "Janeiro/2027"

#### Scenario: Atalho Hoje
- **WHEN** O usuário clica no atalho "Hoje"
- **THEN** O app retorna ao mês e ano do calendário oficial.

## Cenários de Teste Adicionais
### Cenário: Adição de Compra no Cartão
- **WHEN** Adiciono uma compra de "Farmácia" no valor de R$ 50,00 para "Luciana".
- **THEN** O Supabase deve conter o novo registro e o Resumo da Luciana deve aumentar a dívida de cartão em R$ 50,00.

### Cenário: Status de Pagamento em Compras de Cartão (Sync from change: pagamento-cartao)
O sistema SHALL permitir que cada registro de compra no cartão possua um status booleano indicando se o valor já foi reembolsado ao Luan.
- **WHEN** uma nova compra no cartão é cadastrada
- **THEN** o status `pago` deve ser definido como `FALSE` por padrão
- **THEN** o registro deve ser persistido no Supabase com este valor inicial

### Cenário: Toggle de Pagamento
- **WHEN** Marco "Luan" como pago na despesa "Aluguel".
- **THEN** O Status do Pote da Casa na aba Resumo deve progredir proporcionalmente ao valor (1/3 do aluguel).

## Error Handling
- Upload failing for receipts -> Must show snackbar.
- Cannot insert blank amounts.

## Currency Formatting

### Requirement: Currency Formatting
Input fields for monetary values MUST format user input as Brazilian Real (BRL) currency in real-time as they type.

#### Scenario: User enters a valid monetary amount
- **WHEN** the user types "1500" in the "Valor total" or purchase value input field
- **THEN** the input field displays "1.500,00"
- **THEN** the underlying saved value is `1500.0`

#### Scenario: User saves a formatted amount
- **WHEN** the user saves an expense with value "R$ 1.500,00" (or "1.500,00")
- **THEN** it is internally stored and calculated correctly as 1500.0 without crash

## Layout UI

### Requirement: Layout Uniforme dos Cartões de Resumo
O sistema MUST exibir os cartões de resumo por usuário ("Luan", "Luciana", "Giovanna") na aba de Despesas preenchendo toda a largura da tela de forma igualmente distribuída.

#### Scenario: Visualização dos cartões em dispositivo de tela larga
- **WHEN** o usuário abre o aplicativo na aba "Despesas"
- **THEN** os três cartões de usuário são renderizados numa única linha horizontal
- **THEN** cada cartão obtém uma fração idêntica do espaço livre disponível e a linha não possui margem extensa à direita
