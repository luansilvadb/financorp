## Context

A navegação de período atual no app é baseada em um `Notifier` que trata mês e ano como estados independentes em termos de ações (`setMes`, `setAno`). A UI utiliza um seletor de 3 abas (Anterior, Atual, Próximo) que apenas rotaciona o índice do mês (0-11) sem lógica de transporte para o ano. Isso causa inconsistência na virada de ano.

## Goals / Non-Goals

**Goals:**
- Unificar a lógica de transição de período no `PeriodNotifier`.
- Corrigir o bug de virada de ano (transição Dez/Jan).
- Implementar controles de navegação de ano e atalho para o mês atual.
- Garantir que todos os providers dependentes (`pagamentosProvider`, `cartaoProvider`) continuem funcionando reativamente.

**Non-Goals:**
- Alterar como os dados são filtrados no banco de dados (o filtro por mes/ano nos repositórios já existe e é correto).
- Implementar um calendário completo (DatePicker).

## Decisions

### 1. Refatoração do `PeriodNotifier`
Em vez de apenas `setMes` e `setAno`, adicionaremos métodos que lidam com a continuidade temporal:
- `nextMonth()` / `prevMonth()`: Calculam o novo mês e ajustam o ano se necessário.
- `nextYear()` / `prevYear()`: Incrementam/decrementam o ano mantendo o mês.
- `resetToToday()`: Define o estado para o `DateTime.now()` atual.

**Racional:** Centralizar a lógica de "transporte" (carry over) no provider evita que a UI tenha que fazer cálculos de data, seguindo o padrão de separação de interesses.

### 2. UI: Header Inteligente
O widget `_monthYearSelector` será atualizado para:
- Adicionar botões de navegação de ano `<` e `>` ao redor do texto do ano.
- Incluir um botão "Hoje" (ícone ou texto curto) que só aparece/ativa se o período selecionado for diferente do atual.
- Atualizar `_monthBtn` para usar o novo método de transição inteligente.

### 3. Detecção de "Hoje"
O `PeriodNotifier` ou um provider derivado fornecerá um booleano `isCurrentMonth` para destacar visualmente na UI qual mês é o presente real.

## Risks / Trade-offs

- **[Risco]** Loop de atualização infinita se o `Period` for recriado incorretamente.
  - **Mitigação:** Usar classes imutáveis e garantir que o `copyWith` funcione corretamente.
- **[Trade-off]** Adicionar mais botões pode poluir o cabeçalho em telas pequenas.
  - **Mitigação:** Usar ícones compactos (`Material Symbols`) e manter o espaçamento balanceado.
