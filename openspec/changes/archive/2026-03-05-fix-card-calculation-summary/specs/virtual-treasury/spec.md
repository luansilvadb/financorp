## MODIFIED Requirements

### Requirement: Separação de Dívidas (Casa vs Cartão)
O sistema SHALL distinguir explicitamente nos cards de moradores o que é devido à "Casa" (contas fixas) e o que é devido ao "Cartão Luan" (compras pessoais). No caso do Luan, o sistema SHALL exibir o valor total que ele tem a receber das outras moradoras como crédito no seu resumo.

#### Scenario: Luciana verifica seus débitos
- **WHEN** Luciana olha seu card de resumo
- **THEN** ela vê uma linha específica para "Casa" (suas fatias de 1/3 pendentes)
- **THEN** ela vê uma linha específica para "Cartão" (suas compras individuais)
- **THEN** o total exibido é a soma de ambos os valores

#### Scenario: Luan verifica seu balanço de recebíveis
- **WHEN** Luan olha seu card de resumo
- **THEN** ele vê sua parte pendente da "Casa" (sua fatia de 1/3)
- **THEN** ele vê o valor total que Luciana e Giovanna devem a ele no "Cartão"
- **THEN** o total exibido reflete o balanço consolidado (o que ele deve pagar para a casa menos o que tem a receber, ou a soma das obrigações pendentes)
