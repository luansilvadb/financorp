## Context

Atualmente, o app sofre de uma "UI gorda" (Fat UI), onde os widgets de lista calculam agregados (como `totalPago`) em tempo de renderização. Isso gera um custo O(N*M) na rolagem. Além disso, os providers usam padrões de verificação de tipo verbosos que aumentam o boilerplate.

## Goals / Non-Goals

**Goals:**
- Implementar o padrão **Granular State Subscription** para que cards só reconstruam se seus dados específicos mudarem.
- Centralizar o processamento de agregados em um **Motor de Estado Único** com complexidade O(N).
- Reduzir o código boilerplate nos providers em pelo menos 30% usando as novas capacidades do **Dart 3**.

**Non-Goals:**
- Alterar a lógica de persistência do Supabase ou a estrutura das tabelas no banco de dados.
- Mudar o design visual (UI/UX) - o foco é puramente estrutural e de performance.

## Decisions

### 1. Provider Granular (.family + .select)
**Racional:** Substituir a passagem do objeto completo `Despesa` pelo `id`. O card passará a escutar um `Provider.family` que retorna apenas o estado consolidado (`DespesaItemState`).
- **Alternativa:** Usar `ref.watch(provider.select(...))` dentro do card. Descartado porque polui o build do widget e dificulta o reaproveitamento do estado calculado.

### 2. Records para Agregações
**Racional:** Usar Records do Dart 3 para retornar múltiplos valores de operações de `fold`.
- **Exemplo:** `final (total, pago) = despesas.fold(...)`.
- **Alternativa:** Criar classes de dados intermediárias. Descartado por gerar boilerplate desnecessário para objetos que existem apenas dentro de um provider.

### 3. Switch Expressions para Gerenciamento de AsyncValue
**Racional:** Consolidar a verificação de múltiplos `AsyncValue` em uma única expressão switch.
- **Alternativa:** Múltiplos `if (data is AsyncData)` ou `state.when(...)` encadeados. Descartado por ser menos denso e mais propenso a erros de nulo.

### 4. Extensões de Coleção (sumBy)
**Racional:** Criar uma extensão genérica `sumBy` para `Iterable<T>` para tornar as somas de campos numéricos mais expressivas.

## Risks / Trade-offs

- **[Risco] Fragmentação de Providers** → Criar muitos providers granulares pode dificultar o rastreamento do fluxo de dados. 
  - **Mitigação:** Manter os providers granulares como privados ou dentro do mesmo arquivo do provider principal (`finance_providers.dart`).
- **[Trade-off] Memória vs CPU** → Manter estados calculados em memória (cache do Riverpod) consome mais RAM, mas libera a CPU para renderização suave. Dado o contexto de app mobile moderno, priorizamos a fluidez (CPU).
