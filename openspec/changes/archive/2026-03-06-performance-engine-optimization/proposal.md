## Why

O sistema atual apresenta redundâncias de processamento (O(P*N)) e overhead de memória devido ao uso excessivo de classes `freezed` para estados de UI. Com o crescimento do volume de dados, a reatividade global ineficiente (rebuilds em cascata) compromete a fluidez da experiência do usuário e a densidade do código no core.

## What Changes

- **Motor Unificado**: Implementação do `FinancorpEngine` para processamento single-pass (O(N)) de todas as métricas e estados de itens.
- **Densidade via Records**: Substituição de modelos de estado `freezed` por Records do Dart 3 para reduzir boilerplate e consumo de memória.
- **Reatividade Cirúrgica**: Refatoração da forma como os widgets consomem dados, utilizando seletores granulares (O(1)) para isolar rebuilds.
- **Abstração Optimistic**: Centralização da lógica de persistência e rollback para eliminar repetição de código nos Notifiers.

## Capabilities

### New Capabilities
- `unified-finance-engine`: Motor central de processamento denso e reatividade granular para dados financeiros e de cartão.

### Modified Capabilities
- `performance-engine-optimization`: Atualização dos requisitos de motor para incluir indexação O(1) e processamento O(N) como padrão mandatório.

## Impact

- **Core**: `lib/core/engine` será criado como o novo cérebro do app.
- **Features**: `finance` e `cartao` serão simplificadas, removendo lógicas de agrupamento e resumo locais.
- **Shared**: Modelos de estado `freezed` (ItemState) serão depreciados em favor de Records.
- **Performance**: Redução drástica de rebuilds e latência de processamento em dispositivos de entrada.