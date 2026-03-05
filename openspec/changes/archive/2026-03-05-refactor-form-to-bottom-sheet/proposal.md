## Why

A implementação atual dos formulários de "Nova Despesa" e "Nova Compra" é feita de forma integrada (inline) ao final da lista de itens. Isso causa alguns problemas de UX:
1. O usuário precisa fazer scroll até o final da lista para ver o formulário.
2. O formulário "empurra" o conteúdo, causando saltos visuais na interface.
3. Em listas longas, o Floating Action Button (FAB) apenas faz o scroll, o que é menos intuitivo que abrir uma interface dedicada.

Mudar para um **Bottom Sheet** traz mais elegância, segue padrões de design modernos (Material Design/iOS) e mantém o contexto da lista visível ao fundo.

## What Changes

- **Substituição do Formulário Inline**: Os formulários em `despesas_tab.dart` e `cartao_tab.dart` serão removidos da árvore de widgets principal do `ListView`.
- **Nova Interface de Entrada**: O Floating Action Button (FAB) agora abrirá um `ModalBottomSheet` contendo o formulário.
- **Componentização**: O código dos formulários será extraído para widgets independentes e reutilizáveis.
- **Melhoria na Navegação**: O estado `showForm` local das abas será removido, simplificando a lógica da tela principal.
- **Experiência de Teclado**: O Bottom Sheet será ajustado para subir automaticamente quando o teclado for exibido, evitando sobreposição dos campos.

## Capabilities

### New Capabilities
- `ui-bottom-sheets`: Definição de componentes de interface sobrepostos (Bottom Sheets) para entrada de dados.

### Modified Capabilities
- `core`: Os requisitos de "Add Fixed Expense" e "Add Grocery Expense" agora devem especificar a interface via Bottom Sheet em vez de inline.

## Impact

- **Arquivos Afetados**:
  - `lib/features/finance/views/despesas_tab.dart`
  - `lib/features/cartao/views/cartao_tab.dart`
- **Novos Arquivos**:
  - `lib/features/finance/views/widgets/add_expense_sheet.dart` (ou similar)
  - `lib/features/cartao/views/widgets/add_purchase_sheet.dart` (ou similar)
- **Dependências**: Nenhuma nova dependência, utilizaremos o `showModalBottomSheet` nativo do Flutter.
