# Specifications: UI Bottom Sheets

Esta especificação define o comportamento dos modais de entrada de dados (Bottom Sheets) utilizados no aplicativo.

## ADDED Requirements

### Requirement: Formulário Dinâmico de Registro Financeiro
O sistema SHALL exibir um formulário em bottom sheet para entrada de dados, adaptando-se para criação ou edição.

#### Scenario: Visualização em modo de adição
- **WHEN** o usuário clica no botão "+" (FAB)
- **THEN** o título exibido é "LANÇAR"
- **THEN** os campos de texto iniciam vazios

#### Scenario: Visualização em modo de edição
- **WHEN** o usuário clica no botão "Editar" em um item existente
- **THEN** o título exibido é "Editar"
- **THEN** os campos de texto são preenchidos com os dados atuais do item selecionado
- **THEN** o botão de ação principal exibe "Salvar Alterações" ou similar

### Requirement: Fechamento Automático após Sucesso
O sistema SHALL fechar o Bottom Sheet automaticamente após o salvamento bem-sucedido dos dados.

#### Scenario: Fechamento ao salvar lançamento
- **WHEN** o usuário preenche o formulário e clica no botão "Salvar" no Bottom Sheet
- **THEN** os dados são enviados para o Supabase
- **THEN** o Bottom Sheet é fechado e a lista principal é atualizada

### Requirement: Adaptação ao Teclado
O Bottom Sheet MUST ajustar sua position vertical para não ser coberto pelo teclado virtual do dispositivo.

#### Scenario: Foco em campo de texto
- **WHEN** o usuário toca em um campo de texto dentro do Bottom Sheet
- **THEN** o teclado virtual é exibido
- **THEN** o Bottom Sheet sobe proporcionalmente à altura do teclado, mantendo o campo visível
