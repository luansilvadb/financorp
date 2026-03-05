## MODIFIED Requirements

### Feature: Controle de Pagamento em Gasto de Cartão
O card de compra de cartão SHALL exibir claramente quem realizou o gasto e permitir que o administrador (ou a própria pessoa) marque o item como pago.

#### Scenario: Visualização do status de pagamento no card
- **WHEN** uma compra de cartão é exibida na lista de lançamentos
- **THEN** o card deve indicar visualmente se o item já foi pago (ex: ícone de check ou borda destacada)
- **THEN** se o item não estiver pago, o valor deve ser contabilizado no balanço de dívidas

#### Scenario: Marcar compra como paga
- **WHEN** o usuário clica no botão de pagamento dentro do card expansível de uma compra de cartão
- **THEN** o status do item muda para "Pago" (ícone verde/check)
- **THEN** o valor desta compra deixa de ser contabilizado como dívida pendente no resumo
