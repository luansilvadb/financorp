## MODIFIED Requirements

### Requirement: Exibição Unificada de Despesas
O sistema SHALL exibir na aba principal (Despesas) uma lista consolidada contendo despesas fixas e compras de cartão do período selecionado, permitindo acesso a ações de edição.

#### Scenario: Visualização da lista mista
- **WHEN** o usuário abre a aba de Despesas
- **THEN** o sistema exibe tanto os cards de despesas fixas quanto as compras de cartão realizadas naquele mês
- **THEN** as compras de cartão devem ser identificadas visualmente (ex: ícone de cartão)

#### Scenario: Acesso à edição na lista unificada
- **WHEN** o usuário expande um card na lista unificada
- **THEN** o sistema deve exibir um botão "Editar" que abre o formulário de edição correspondente (Despesa ou Compra)
