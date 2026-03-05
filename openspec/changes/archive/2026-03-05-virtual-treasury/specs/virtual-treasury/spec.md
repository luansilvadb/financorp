## ADDED Requirements

### Requirement: Balanço de Tesouraria Virtual
O sistema SHALL exibir um sumário da saúde financeira da casa, consolidando quanto das despesas totais do mês já foram "arrecadadas" (marcadas como pagas por qualquer um dos 3 moradores).

#### Scenario: Visualização do progresso de arrecadação da casa
- **WHEN** qualquer usuário abre a aba "Resumo"
- **THEN** o sistema exibe o "Status do Pote da Casa" com o valor total arrecadado vs o total das despesas fixas cadastradas

### Requirement: Cota do Administrador (Luan)
O sistema SHALL permitir que o usuário Luan marque suas próprias cotas de 1/3 como pagas, integrando sua participação no fundo comum.

#### Scenario: Luan garante sua parte no aluguel
- **WHEN** Luan clica no toggle de pagamento sob seu próprio nome em uma despesa
- **THEN** o valor arrecadado da Tesouraria Virtual aumenta em 1/3 daquela despesa
- **THEN** o card de resumo do Luan mostra que ele está em dia com a Casa

### Requirement: Separação de Dívidas (Casa vs Cartão)
O sistema SHALL distinguir explicitamente nos cards de moradores o que é devido à "Casa" (contas fixas) e o que é devido ao "Cartão Luan" (compras pessoais).

#### Scenario: Luciana verifica seus débitos
- **WHEN** Luciana olha seu card de resumo
- **THEN** ela vê uma linha específica para "Casa" (suas fatias de 1/3 pendentes)
- **THEN** ela vê uma linha específica para "Cartão" (suas compras individuais)
- **THEN** o total exibido é a soma de ambos os valores
