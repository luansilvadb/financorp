## ADDED Requirements

### Requirement: Renderização de cartões em blocos granulares isolados
A renderização de cartões das listas (casa e cartão) DEVE ser baseada em `ConsumerWidget` onde o re-render ocorre apenas para o componente focado na alteração e não propaga a atualização para a aba mãe.

#### Scenario: Interação no toggle do pagamento
- **WHEN** o usuário marca como pago ou pendente um item do cartão de crédito ou uma das divisões de cota da casa
- **THEN** o card interagido muda seu visual e os resumos relacionados mudam, porém os outros itens desvinculados da mudança não disparam um re-render.

### Requirement: Atualização seletiva nos Resumos Consolidados
Os cartões miniaturizados com o status final DEVEM reagir de forma autônoma escutando apenas o próprio estado de interesse.

#### Scenario: Filtragem na renderização dos mini cards utilizando select
- **WHEN** os dados em `pagamentosProvider` mudam de forma que apenas afetam o balanço do usuário Luciana
- **THEN** apenas o mini-card da Luciana deve atualizar sua árvore de renderização para refletir essa alteração no balanço consolidado.
