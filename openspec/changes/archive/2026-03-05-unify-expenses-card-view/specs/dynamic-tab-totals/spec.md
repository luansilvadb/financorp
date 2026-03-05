## ADDED Requirements

### Requirement: Cálculo de Totais Consolidados
O sistema SHALL atualizar o valor de "Total" exibido no topo da aba de Despesas para somar todas as despesas fixas e compras de cartão do mês selecionado.

#### Scenario: Atualização de total após adicionar compra de cartão
- **WHEN** o usuário adiciona um novo gasto no cartão
- **THEN** o valor do "Total" na aba principal de Despesas deve aumentar pelo valor integral da compra

### Requirement: Independência do Status do Pote da Casa
A inclusão de gastos de cartão na lista de despesas SHALL NÃO interferir no cálculo do "Pote da Casa" (que deve considerar apenas a soma de 1/3 de cada despesa fixa).

#### Scenario: Verificação de progresso da casa
- **WHEN** uma despesa de cartão é adicionada
- **THEN** o "Status do Pote da Casa" permanece inalterado, refletindo apenas a arrecadação das contas fixas
