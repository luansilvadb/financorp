## ADDED Requirements

### Requirement: Interface de Entrada via Bottom Sheet
O sistema MUST fornecer uma interface de entrada de dados (Bottom Sheet) que se sobrepõe à lista de itens atual.

#### Scenario: Abertura do Bottom Sheet de Nova Despesa
- **WHEN** o usuário clica no Floating Action Button na aba de Despesas
- **THEN** o sistema exibe um Modal Bottom Sheet contendo o formulário de cadastro de despesa

#### Scenario: Abertura do Bottom Sheet de Nova Compra
- **WHEN** o usuário clica no Floating Action Button na aba de Cartão
- **THEN** o sistema exibe um Modal Bottom Sheet contendo o formulário de cadastro de compra

### Requirement: Fechamento Automático após Sucesso
O sistema SHALL fechar o Bottom Sheet automaticamente após o salvamento bem-sucedido dos dados.

#### Scenario: Fechamento ao salvar despesa
- **WHEN** o usuário preenche o formulário e clica no botão "Salvar" no Bottom Sheet
- **THEN** os dados são enviados para o Supabase
- **THEN** o Bottom Sheet é fechado e a lista principal é atualizada

### Requirement: Adaptação ao Teclado
O Bottom Sheet MUST ajustar sua posição vertical para não ser coberto pelo teclado virtual do dispositivo.

#### Scenario: Foco em campo de texto
- **WHEN** o usuário toca em um campo de texto dentro do Bottom Sheet
- **THEN** o teclado virtual é exibido
- **THEN** o Bottom Sheet sobe proporcionalmente à altura do teclado, mantendo o campo visível
