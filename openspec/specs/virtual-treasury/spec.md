# Specifications: Virtual Treasury

Esta especificação define o funcionamento da Tesouraria Virtual da casa, onde todos os moradores (incluindo o administrador central) possuem compromissos de 1/3 das contas fixas.

## Features & Scenarios

### Feature: Balanço de Tesouraria Virtual
O sistema SHALL exibir um sumário da saúde financeira da casa, consolidando quanto das despesas totais do mês já foram "arrecadadas" (marcadas como pagas por qualquer um dos 3 moradores).

#### Scenario: Visualização do progresso de arrecadação da casa
- **WHEN** qualquer usuário abre a aba "Resumo"
- **THEN** o sistema exibe the "Status do Pote da Casa" com o valor total arrecadado vs o total das despesas fixas cadastradas

### Feature: Cota do Administrador (Luan)
O sistema SHALL permitir que o usuário Luan marque suas próprias cotas de 1/3 como pagas, integrando sua participação no fundo comum.

#### Scenario: Luan garante sua parte no aluguel
- **WHEN** Luan clica no toggle de pagamento sob seu próprio nome em uma despesa
- **THEN** o valor arrecadado da Tesouraria Virtual aumenta em 1/3 daquela despesa
- **THEN** o card de resumo do Luan mostra que ele está em dia com a Casa

### Feature: Separação de Dívidas (Casa vs Cartão) (Sync from change: pagamento-cartao)
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
