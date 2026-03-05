# Specifications: Period Navigation

## ADDED Requirements

### Requirement: Navegação de Mês Infinita
O sistema MUST ajustar automaticamente o ano ao navegar entre Dezembro e Janeiro através das abas de seleção de mês.

#### Scenario: Avançar de Dezembro para Janeiro
- **WHEN** o mês selecionado é "Dezembro/2026"
- **THEN** ao clicar na aba "Janeiro" (Próximo), o sistema altera o período para "Janeiro/2027"

#### Scenario: Voltar de Janeiro para Dezembro
- **WHEN** o mês selecionado é "Janeiro/2027"
- **THEN** ao clicar na aba "Dezembro" (Anterior), o sistema altera o período para "Dezembro/2026"

### Requirement: Navegação de Ano Explícita
O sistema SHALL exibir controles de navegação (setas) para incrementar ou decrementar o ano de exibição sem alterar o mês selecionado.

#### Scenario: Incrementar o ano
- **WHEN** o período atual é "Março/2026" e o usuário clica na seta de avançar ano
- **THEN** o período é alterado para "Março/2027"

### Requirement: Atalho para Período Atual (Hoje)
O sistema MUST fornecer um atalho para retornar ao mês e ano correntes do calendário do dispositivo.

#### Scenario: Retornar ao presente
- **WHEN** o período exibido é diferente do mês/ano atual (ex: "Janeiro/2028")
- **THEN** ao acionar o atalho "Hoje", o sistema redefine o período para o mês e ano do calendário atual
