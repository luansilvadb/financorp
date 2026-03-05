## Por que

Atualmente, as despesas de cartão de crédito e as despesas fixas estão em abas separadas, o que dificulta a visão consolidada do que cada morador gastou no mês. Os usuários precisam trocar de aba para ver seus gastos individuais no cartão, gerando uma experiência fragmentada. Unificar essas visões na aba principal de "Despesas" trará transparência imediata sobre o custo total de vida da casa no período selecionado.

## O que muda

- Unificação da lista de despesas na aba principal para exibir tanto as contas fixas (aluguel, luz, etc.) quanto as compras individuais no cartão.
- Adição de indicadores visuais (ícones/etiquetas) para diferenciar gastos de cartão de despesas fixas.
- Atualização do cálculo do "Total do Mês" exibido na aba de despesas para somar ambos os tipos de gastos.
- Implementação de um card específico para compras de cartão que mostre quem gastou e o status de devedor ao Luan.

## Capabilities

### New Capabilities
- `consolidated-expense-list`: Capacidade de exibir uma lista única mesclando diferentes fontes de dados (fixas e cartão) filtradas pelo período.
- `dynamic-tab-totals`: Atualização automática dos totais da aba baseada na soma de todas as despesas exibidas.

### Modified Capabilities
- `resumo-view`: Ajuste para suportar a visualização unificada em todas as telas de resumo.

## Impact

- `app_casa_transparente/lib/features/finance/views/despesas_tab.dart`: Principal local de mudança visual.
- `app_casa_transparente/lib/features/finance/providers/resumo_provider.dart`: Ajuste no `totalGeralProvider`.
- `app_casa_transparente/lib/features/finance/providers/finance_providers.dart`: Possível criação de um provider combinado.
