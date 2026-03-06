## Why

O sistema atual realiza cálculos de estado e agregações de dados diretamente na camada de UI (Widgets) e durante o processo de construção da árvore, o que pode causar quedas de quadros (jank) em listas extensas. Além disso, a lógica de manipulação de estados assíncronos e transformações de dados utiliza padrões verbosos do Dart 2.x, dificultando a manutenção e reduzindo a densidade do código. Esta mudança visa otimizar a performance de renderização e a legibilidade do código através de padrões modernos do Dart 3 e Riverpod.

## What Changes

- Refatoração do `resumoProvider` e providers de despesas para utilizar **Dart 3 Patterns**, **Records** e **Switch Expressions**.
- Implementação de **Inscrição de Estado Granular** usando `.family` e `.select()` no Riverpod para isolar reconstruções de widgets.
- Centralização da lógica de agregação e cálculo (O(N)) na camada de Provider, expondo estados consolidados e leves para a UI.
- Introdução de extensões funcionais para operações comuns em coleções (ex: `sumBy`).

## Capabilities

### New Capabilities
- `granular-state-engine`: Novo motor de processamento de estado que mapeia despesas brutas para estados de UI consolidados (Calculated States) de forma eficiente.

### Modified Capabilities
- `performance-engine-optimization`: Requisitos de eficiência para o motor de cálculo de saldos e resumos.
- `list-rendering-optimization`: Padrões de consumo de estado para garantir 60fps em listas de alta densidade.

## Impact

- **Providers:** `resumo_provider.dart`, `finance_providers.dart` e `cartao_providers.dart`.
- **UI:** `ResumoTab`, `DespesasTab`, `CartaoTab` e seus respectivos Cards.
- **Modelos:** Possível introdução de Records e Sealed Classes para representar estados de agregação.
