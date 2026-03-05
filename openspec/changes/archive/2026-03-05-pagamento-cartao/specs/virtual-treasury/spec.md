## MODIFIED Requirements

### Feature: Separação de Dívidas (Casa vs Cartão)
O sistema SHALL distinguir explicitamente nos cards de moradores o que é devido à "Casa" (contas fixas) e o que é devido ao "Cartão Luan" (compras pessoais). No caso do Luan, o sistema SHALL exibir o valor total que ele tem a receber das outras moradoras como crédito no seu resumo, considerando apenas itens não pagos.

#### Scenario: Luciana verifica seus débitos após pagamento parcial
- **GIVEN** Luciana tem duas compras de cartão de R$ 50 cada (Total R$ 100)
- **WHEN** ela marca uma compra como paga
- **THEN** o card de resumo dela mostra apenas R$ 50 pendentes em "Cartão"
- **THEN** o total exibido reflete a soma da "Casa" + apenas a compra pendente do "Cartão"

#### Scenario: Luan verifica seu balanço de recebíveis atualizado
- **GIVEN** Luciana deve R$ 100 de cartão ao Luan
- **WHEN** Luciana marca R$ 50 como pagos
- **THEN** o resumo do Luan atualiza para mostrar que ele tem apenas R$ 50 a receber de cartão
- **THEN** o balanço consolidado do Luan (Recebíveis - O que ele deve à Casa) é atualizado instantaneamente
