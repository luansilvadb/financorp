## MODIFIED Requirements

### Requirement: Formulário Dinâmico de Registro Financeiro
O sistema SHALL exibir um formulário em bottom sheet para entrada de dados, adaptando-se para criação ou edição.

#### Scenario: Visualização em modo de adição
- **WHEN** o usuário clica no botão "+" (FAB)
- **THEN** o título exibido é "Nova Despesa" ou "Novo Gasto"
- **THEN** os campos de texto iniciam vazios

#### Scenario: Visualização em modo de edição
- **WHEN** o usuário clica no botão "Editar" em um item existente
- **THEN** o título exibido é "Editar Despesa" ou "Editar Gasto"
- **THEN** os campos de texto são preenchidos com os dados atuais do item selecionado
- **THEN** o botão de ação principal exibe "Salvar Alterações" ou similar
