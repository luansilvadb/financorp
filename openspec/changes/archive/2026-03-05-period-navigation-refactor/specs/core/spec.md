## MODIFIED Requirements

### Requirement: Filtro por Período
A navegação por mês e ano MUST filtrar todos os dados (despesas, compras e pagamentos) de forma consistente e oferecer inteligência de transição.
- **GIVEN** O seletor de mês está em um determinado período.
- **WHEN** O usuário navega entre as abas.
- **THEN** Apenas os dados referentes ao mês/ano selecionado devem ser exibidos.
- **THEN** Transições entre Dezembro e Janeiro devem ajustar o ano automaticamente.
- **THEN** Atalhos para o período atual (mês/ano de hoje) devem estar disponíveis.

#### Scenario: Filtro Consistente
- **WHEN** O seletor de mês está em "Março/2026"
- **THEN** Apenas despesas, compras e status de pagamento de Março/2026 são exibidos.

#### Scenario: Virada de Ano Automática
- **WHEN** O período está em "Dezembro/2026" e o usuário clica em "Janeiro" (Próximo)
- **THEN** O app altera para "Janeiro/2027"

#### Scenario: Atalho Hoje
- **WHEN** O usuário clica no atalho "Hoje"
- **THEN** O app retorna ao mês e ano do calendário oficial.
