## Context

Atualmente, a lógica de agregação financeira está fragmentada em múltiplos providers (`resumoProvider`, `totalGeralProvider`, etc.) e nas próprias views. Isso resulta em loops repetitivos O(P*N) e rebuilds ineficientes. Além disso, o uso de classes `freezed` para estados de item de UI introduz um boilerplate desnecessário e consome recursos de build e memória.

## Goals / Non-Goals

**Goals:**
- Centralizar o processamento em um único `FinanceEngine` (O(N)).
- Utilizar Records do Dart 3 para eliminar classes de estado efêmeras.
- Garantir que widgets de itens individuais usem seletores indexados para reatividade O(1).
- Unificar a lógica de persistência (Optimistic UI) para reduzir duplicidade de código.

**Non-Goals:**
- Alterar o esquema do banco de dados no Supabase.
- Implementar autenticação de usuários (fora de escopo para esta otimização).
- Refatorar a navegação global do app.

## Decisions

### 1. Unified Finance Engine (Single-Pass)
Implementar um único `Provider` que consome todos os `AsyncValue` de dados e os reduz a um Record de estado consolidado.
- **Racional**: Reduz o custo computacional de O(M*N) (onde M é o número de providers/cálculos) para O(N).
- **Alternativa**: Manter múltiplos providers com cache individual. *Rejeitado* pois a interdependência dos dados (ex: pagamento afetando resumo e card ao mesmo tempo) exige sincronia que o motor único provê naturalmente.

### 2. View-Model Records vs Freezed
Substituir `DespesaItemState` e `CompraItemState` por Records posicionais ou nomeados.
- **Racional**: Records são tipos de valor nativos, sem necessidade de geração de código, e extremamente leves em memória.
- **Exemplo**: `typedef DespesaItem = (Despesa d, {int pagos, bool luanPago, double valorPorPessoa});`

### 3. Granular Selectors
Obrigar o uso de `ref.watch(engineProvider.select((s) => s.items[id]))` nos cards.
- **Racional**: Isola o contexto de reconstrução. Mudanças no resumo global não afetarão a renderização dos itens individuais se o dado indexado deles não mudar.

## Risks / Trade-offs

- [Risco] Complexidade no motor único → [Mitigação] Usar Dart Patterns (switch, records) para manter a lógica densa e legível.
- [Trade-off] Perda de métodos `copyWith` do freezed nos estados de UI → [Mitigação] Como os estados são derivados e imutáveis por natureza do motor, a necessidade de `copyWith` na camada de View é quase nula.
