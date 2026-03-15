## MODIFIED Requirements

### Requirement: Exibição Unificada de Despesas
O sistema SHALL exibir na aba principal (Despesas) uma lista consolidada contendo despesas fixas e compras de cartão do período selecionado, permitindo acesso a ações de edição. Cada item da lista SHALL exibir o avatar unificado (DiviAvatar) do responsável.

#### Scenario: Visualização da lista mista
- **WHEN** o usuário abre a aba de Despesas
- **THEN** o sistema exibe tanto os cards de despesas fixas quanto as compras de cartão realizadas naquele mês
- **THEN** as compras de cartão devem ser identificadas visualmente (ex: ícone de cartão)
- **THEN** cada card exibe o DiviAvatar do responsável com sua inicial e cor temática

#### Scenario: Acesso à edição na lista unificada
- **WHEN** o usuário expande um card na lista unificada
- **THEN** o sistema deve exibir um botão "Editar" que abre o formulário de edição correspondente (Despesa ou Compra)

### Requirement: Identificação de Responsável por Gasto de Cartão
O card de compra de cartão SHALL exibir claramente quem realizou o gasto, o valor total devido ao Luan e o avatar unificado do responsável.

#### Scenario: Detalhe de compra no cartão por Luciana
- **WHEN** uma compra de cartão da Luciana aparece na lista de despesas
- **THEN** o card mostra "Mercado (Luciana)" e o valor integral
- **THEN** o card indica que o valor é 100% devedor ao Luan
- **THEN** o card exibe o DiviAvatar da Luciana com a inicial "L"

### Requirement: Controle de Pagamento em Gasto de Cartão (Sync from change: pagamento-cartao)
O card de compra de cartão SHALL exibir claramente quem realizou o gasto e permitir que o administrador (ou a própria pessoa) marque o item como pago.

#### Scenario: Visualização do status de pagamento no card
- **WHEN** uma compra de cartão é exibida na lista de lançamentos
- **THEN** o card deve indicar visualmente se o item já foi pago (ex: ícone de check ou borda destacada)
- **THEN** se o item não estiver pago, o valor deve ser contabilizado no balanço de dívidas
- **THEN** o card exibe o DiviAvatar do responsável

#### Scenario: Marcar compra como paga
- **WHEN** o usuário clica no botão de pagamento dentro do card expansível de uma compra de cartão
- **THEN** o status do item muda para "Pago" (ícone verde/check)
- **THEN** o valor desta compra deixa de ser contabilizado como dívida pendente no resumo
