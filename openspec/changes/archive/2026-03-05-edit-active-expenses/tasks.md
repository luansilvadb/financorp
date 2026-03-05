## 1. Refatoração de Bottom Sheets (Formulários)

- [x] 1.1 Atualizar `AddExpenseSheet` para aceitar `Despesa? expense` no construtor.
- [x] 1.2 Inicializar `TextEditingController` em `AddExpenseSheet` com dados da despesa (se houver).
- [x] 1.3 Adicionar lógica de título e botão dinâmico ("Nova" vs "Editar") em `AddExpenseSheet`.
- [x] 1.4 Atualizar `AddPurchaseSheet` para aceitar `CompraCartao? purchase` no construtor.
- [x] 1.5 Inicializar controllers e campo de pessoa em `AddPurchaseSheet` com dados da compra (se houver).
- [x] 1.6 Adicionar lógica de título dinâmico em `AddPurchaseSheet`.

## 2. Validação e Persistência

- [x] 2.1 Adicionar validação de nome e valor (não vazio/não zero) em `AddExpenseSheet`.
- [x] 2.2 Garantir que o `id` original da despesa seja passado ao modelo no `onSave`.
- [x] 2.3 Adicionar validação de descrição e valor em `AddPurchaseSheet`.
- [x] 2.4 Garantir que o `id` e `data` originais da compra sejam preservados ao editar.

## 3. UI de Listagem (Despesas)

- [x] 3.1 Adicionar botão "Editar" ao lado do "Excluir" no card expandido de `DespesasTab`.
- [x] 3.2 Implementar a chamada ao `showModalBottomSheet` passando o objeto selecionado.

## 4. UI de Listagem (Cartão)

- [x] 4.1 Reorganizar botões no card expandido de `CartaoTab` para incluir "Editar Gasto".
- [x] 4.2 Implementar a chamada ao `showModalBottomSheet` passando a compra selecionada.

## 5. Testes e Validação

- [x] 5.1 Verificar se a edição de uma despesa fixa atualiza o valor no resumo (Resumo Tab).
- [x] 5.2 Verificar se a edição de um gasto de cartão atualiza as dívidas por pessoa.
- [x] 5.3 Confirmar que o status de pagamento (pago/pendente) não é afetado pela edição dos campos.
