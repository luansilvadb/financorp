## Why

Melhorar a eficiência operacional e a densidade de informação do app, reduzindo a carga cognitiva e o número de cliques necessários para tarefas frequentes (como pagar contas e conferir dívidas por pessoa), elevando a qualidade para um padrão "FinTech Premium".

## What Changes

- **Gestos Nativos (Dismissible)**: Implementação de Swipe Actions em todos os cards de lista para ações rápidas de pagamento e exclusão.
- **Visualização Agrupada**: Refatoração da aba de Cartão para agrupar compras por pessoa com subtotais dinâmicos.
- **Otimização de Lógica**: Refatoração do `resumoProvider` para performance O(1) e introdução de Skeletons nativos para carregamento fluido.
- **Quick Pay Luan**: Atalho gestual específico para o pagador principal nas despesas fixas.

## Capabilities

### New Capabilities
- `gestural-shortcuts`: Implementação de ações via swipe (Dismissible) para pagar, estornar e excluir itens com feedback tátil.
- `hierarchical-card-view`: Agrupamento de lançamentos de cartão por pessoa com cabeçalhos de subtotal e colapsáveis.
- `performance-engine-optimization`: Otimização de algoritmos de resumo e implementação de carregamento visual estruturado (Skeletons).

### Modified Capabilities
- `consolidated-status-card`: O cálculo de status agora deve refletir as mudanças instantâneas dos gestos e suportar a nova hierarquia de dados.
- `list-rendering-optimization`: Expansão dos requisitos de performance para incluir Skeletons e debounce de cálculos pesados.

## Impact

- **UI/UX**: Mudança significativa na forma como o usuário interage com as listas (menos cliques, mais gestos).
- **Providers**: Refatoração profunda no `resumoProvider` e `cartaoProvider`.
- **Widgets**: `CartaoCard` e `DespesaCard` serão envolvidos em `Dismissible`.
- **Performance**: Redução no tempo de processamento de resumos e melhoria na percepção de velocidade de carregamento.
