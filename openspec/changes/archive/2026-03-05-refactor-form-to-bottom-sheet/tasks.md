## 1. Componentização e Preparação

- [x] 1.1 Extrair o formulário de `despesas_tab.dart` para o novo widget `AddExpenseSheet` em `lib/features/finance/views/widgets/add_expense_sheet.dart`.
- [x] 1.2 Extrair o formulário de `cartao_tab.dart` para o novo widget `AddPurchaseSheet` em `lib/features/cartao/views/widgets/add_purchase_sheet.dart`.
- [x] 1.3 Garantir que os novos widgets herdem de `ConsumerStatefulWidget` para acessar os providers do Riverpod.
- [x] 1.4 Implementar o design do Bottom Sheet com cantos arredondados e handle visual em ambos os componentes.

## 2. Refatoração da Aba de Despesas

- [x] 2.1 Remover o estado `showForm` e o método `_scrollToForm` de `despesas_tab.dart`.
- [x] 2.2 Atualizar o `FloatingActionButton` para chamar `showModalBottomSheet` com `AddExpenseSheet`.
- [x] 2.3 Remover a injeção condicional de `_buildNovaDespesaForm()` do `ListView`.
- [x] 2.4 Limpar imports e métodos privados que não são mais necessários na tela principal.

## 3. Refatoração da Aba de Cartão

- [x] 3.1 Remover o estado `showForm` e o método `_scrollToForm` de `cartao_tab.dart`.
- [x] 3.2 Atualizar o `FloatingActionButton` para chamar `showModalBottomSheet` com `AddPurchaseSheet`.
- [x] 3.3 Remover a injeção condicional de `_buildForm()` do `ListView`.
- [x] 3.4 Limpar imports e métodos privados que não são mais necessários na tela principal.

## 4. UX e Ajustes Finais

- [x] 4.1 Implementar o ajuste de `viewInsets.bottom` para que o Bottom Sheet suba com o teclado.
- [x] 4.2 Adicionar o fechamento automático (`Navigator.pop`) após o sucesso da operação de salvar em ambos os formulários.
- [x] 4.3 Testar o fluxo completo de adição de despesa e compra de cartão para validar a persistência e atualização da UI.
