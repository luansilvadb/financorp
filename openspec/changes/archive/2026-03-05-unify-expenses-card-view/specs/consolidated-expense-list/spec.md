## ADDED Requirements

### Requirement: Exibição Unificada de Despesas
O sistema SHALL exibir na aba principal (Despesas) uma lista consolidada contendo despesas fixas e compras de cartão do período selecionado.

#### Scenario: Visualização da lista mista
- **WHEN** o usuário abre a aba de Despesas
- **THEN** o sistema exibe tanto os cards de despesas fixas quanto as compras de cartão realizadas naquele mês
- **THEN** as compras de cartão devem ser identificadas visualmente (ex: ícone de cartão)

### Requirement: Identificação de Responsável por Gasto de Cartão
O card de compra de cartão SHALL exibir claramente quem realizou o gasto e o valor total devido ao Luan.

#### Scenario: Detalhe de compra no cartão por Luciana
- **WHEN** uma compra de cartão da Luciana aparece na lista de despesas
- **THEN** o card mostra "Mercado (Luciana)" e o valor integral
- **THEN** o card indica que o valor é 100% devedor ao Luan
