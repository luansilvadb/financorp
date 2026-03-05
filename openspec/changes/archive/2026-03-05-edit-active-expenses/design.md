## Context

O aplicativo utiliza uma arquitetura modular baseada em Riverpod e Supabase. As operações de escrita são concentradas em Repositórios que utilizam o método `upsert` do Supabase. Atualmente, os formulários de adição são abertos via Bottom Sheets, mas não possuem lógica para receber dados pré-existentes ou identificar se a operação é de criação ou atualização.

## Goals / Non-Goals

**Goals:**
- Implementar edição de despesas e compras de cartão reutilizando componentes existentes.
- Garantir que a edição não quebre os vínculos de pagamentos (histórico).
- Melhorar a UX das abas de listagem adicionando botões de ação contextuais.

**Non-Goals:**
- Implementar histórico de auditoria de alterações (quem mudou o quê).
- Implementar edição em massa.
- Mudar a lógica de seleção de período (mês/ano) durante a edição.

## Decisions

### 1. Reuso de Bottom Sheets com Construtor Opcional
**Decisão**: Adicionar um parâmetro opcional (ex: `Despesa? expense`) aos construtores de `AddExpenseSheet` e `AddPurchaseSheet`.
- **Racional**: Evita duplicação de código de UI e lógica de validação. O Flutter permite inicializar `TextEditingController` no `initState` com base nesses parâmetros.
- **Alternativa**: Criar `EditExpenseSheet` separado. Rejeitado por aumentar a dívida técnica e dificultar manutenções futuras na UI.

### 2. Uso de IDs Existentes para Upsert
**Decisão**: Passar o `id` original do objeto para o modelo antes de chamar o provider de gravação.
- **Racional**: Os repositórios já usam `upsert`, que no Supabase/Postgres atualiza o registro se o ID (PK) estiver presente no payload.
- **Alternativa**: Criar métodos `updateX` específicos nos repositórios. Rejeitado pois o `saveX` atual já é idempotente via upsert.

### 3. Layout de Ações no Card Expandido
**Decisão**: Utilizar `Row` com `Expanded` para botões de ação secundária (Editar/Excluir) na parte inferior do card expandido.
- **Racional**: Mantém os botões em uma área de fácil alcance e visualmente equilibrada, sem competir com as ações primárias de pagamento que ficam no topo da expansão.

## Risks / Trade-offs

- **[Risco] Perda de integridade se o ID for alterado** → **Mitigação**: O campo `id` nos modelos é `final` (ou não editável via UI), garantindo que o `upsert` atinja o registro correto.
- **[Trade-off] UX de data em compras de cartão** → Ao editar uma compra, a data original será preservada (já que não há seletor de data no formulário atual). Decidimos não adicionar seletor de data agora para manter o escopo focado.
