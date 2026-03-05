## Why

A navegação atual por mês e ano no cabeçalho possui um bug lógico onde a transição entre Dezembro e Janeiro não altera o ano automaticamente (ex: Dez/2026 -> Jan/2026). Além disso, não há uma forma rápida de navegar entre anos ou voltar para o mês atual, o que prejudica a experiência de planejamento financeiro a longo prazo.

## What Changes

- **Correção de Transição de Mês**: A lógica de navegação nas abas de meses passará a ser "infinita", incrementando ou decrementando o ano automaticamente ao cruzar a fronteira Dezembro/Janeiro.
- **Navegação de Ano Explícita**: Adição de controles de navegação de ano (setas `<` e `>`) no cabeçalho para permitir saltos anuais diretos.
- **Atalho "Hoje"**: Inclusão de um botão ou ícone de ação rápida para retornar instantaneamente ao mês e ano correntes do calendário.
- **Inteligência de Estado**: O `periodProvider` será refatorado para suportar transições complexas de data de forma centralizada.

## Capabilities

### New Capabilities
- `period-navigation`: Nova lógica e componentes de UI para navegação inteligente de períodos (mês/ano).

### Modified Capabilities
- `core`: Atualização dos requisitos de "Filtro por Período" para incluir o comportamento inteligente de navegação.

## Impact

- `lib/shared/providers/month_year_provider.dart`: Refatoração do Notifier para lógica de data mais robusta.
- `lib/main.dart`: Reestilização do widget `_monthYearSelector` e `_monthBtn` no `HomeScreen`.
- Sincronização de dados: Todos os providers que dependem do `periodProvider` (`pagamentosProvider`, `cartaoProvider`) se beneficiarão da navegação corrigida.
