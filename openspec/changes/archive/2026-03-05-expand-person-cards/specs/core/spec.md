## ADDED Requirements

### Requirement: Layout Uniforme dos Cartões de Resumo
O sistema MUST exibir os cartões de resumo por usuário ("Luan", "Luciana", "Giovanna") na aba de Despesas preenchendo toda a largura da tela de forma igualmente distribuída.

#### Scenario: Visualização dos cartões em dispositivo de tela larga
- **WHEN** o usuário abre o aplicativo na aba "Despesas"
- **THEN** os três cartões de usuário são renderizados numa única linha horizontal
- **THEN** cada cartão obtém uma fração idêntica do espaço livre disponível e a linha não possui margem extensa à direita
