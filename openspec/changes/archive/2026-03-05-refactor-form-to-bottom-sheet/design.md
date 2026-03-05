## Context

Atualmente, o aplicativo `app_casa_transparente` utiliza formulários integrados (`inline`) nas abas de Despesas e Cartão. O estado de exibição é controlado por um booleano `showForm` e o Floating Action Button (FAB) apenas faz o scroll até o final da lista onde o formulário é injetado. Esta abordagem torna a interface poluída e a navegação menos fluida à medida que a lista de itens cresce.

## Goals / Non-Goals

**Goals:**
- Desacoplar os formulários das telas de listagem (`despesas_tab.dart` e `cartao_tab.dart`).
- Implementar a abertura de formulários via `ModalBottomSheet` com design moderno.
- Garantir que o formulário seja responsivo ao teclado (não seja coberto).
- Manter a paridade de funcionalidades (validação, salvamento no Supabase, etc).

**Non-Goals:**
- Alterar a lógica de negócio ou os schemas do banco de dados.
- Implementar novos campos ou mudar o fluxo de dados do Riverpod.
- Criar um sistema de design de Bottom Sheets genérico para todo o app (foco apenas nestes dois casos).

## Decisions

1. **Componentização Modular**:
   - Criar `AddExpenseSheet` em `lib/features/finance/views/widgets/add_expense_sheet.dart`.
   - Criar `AddPurchaseSheet` em `lib/features/cartao/views/widgets/add_purchase_sheet.dart`.
   - *Rationale*: Melhora a manutenção e separa a lógica de entrada de dados da lógica de visualização da lista.

2. **Uso de `showModalBottomSheet` com `isScrollControlled: true`**:
   - *Rationale*: O parâmetro `isScrollControlled: true` é necessário para que o Bottom Sheet possa ocupar mais de 50% da tela se necessário e para que o teclado funcione corretamente dentro dele usando o `Padding` do `viewInsets`.

3. **Estilização Visual**:
   - `borderRadius: BorderRadius.vertical(top: Radius.circular(32))`.
   - Inclusão de um `Container` de "Handle" no topo para indicação visual de fechamento.
   - Uso das constantes `kPrimaryColor` e `kSlate` para manter a identidade visual.

4. **Remoção do Estado `showForm`**:
   - O FAB nas telas principais passará a chamar uma função que abre o Bottom Sheet, eliminando a necessidade de gerenciar o estado `showForm` e `_scrollToForm`.

## Risks / Trade-offs

- **[Risco] Teclado cobrindo campos**: Em dispositivos menores, o Bottom Sheet pode não ter espaço suficiente.
  - *Mitigação*: Envolver o conteúdo do sheet em um `SingleChildScrollView` e usar `Padding` com `MediaQuery.of(context).viewInsets.bottom`.
- **[Trade-off] Perda de visibilidade imediata**: O usuário não vê mais o formulário ao final da lista.
  - *Mitigação*: O FAB centralizado e destacado compensa essa mudança, tornando a ação de adicionar muito mais clara.
- **[Risco] Contexto do Provider**: Ao extrair o widget, é necessário garantir que ele tenha acesso aos providers necessários.
  - *Mitigação*: Os novos widgets serão `ConsumerStatefulWidget` ou `ConsumerWidget` para acessar o Riverpod.
