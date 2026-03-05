## Context

Atualmente, o app exibe apenas despesas fixas na aba principal, enquanto os gastos de cartão ficam isolados em outra aba. Isso gera a sensação de que as despesas do cartão não estão sendo contabilizadas.

## Goals / Non-Goals

**Goals:**
- Unificar visualmente despesas fixas e gastos de cartão na `DespesasTab`.
- Atualizar o `totalGeralProvider` para refletir a soma de todos os gastos do mês (fixas + cartão).
- Criar um componente de card de despesa (ou estender o existente) que suporte os dois tipos de gastos de forma clara.

**Non-Goals:**
- Unificar os formulários de adição (continuarão em suas abas respectivas para evitar erros de entrada).
- Mudar a lógica de rateio do cartão (continua 100% para o devedor vs Luan).

## Decisions

- **Unificação no Provider**: Criaremos um novo `combinedExpensesProvider` ou ajustaremos a `DespesasTab` para ouvir tanto `despesasProvider` quanto `cartaoProvider`.
- **UI Consistency**: O card de cartão na aba de despesas será visualmente semelhante ao card de despesa fixa, mas com:
  - Ícone de cartão (💳).
  - Texto "Gasto de [Pessoa]".
  - Indicação de que o valor é devedor ao Luan, sem os botões de 1/3.
- **Total do Mês**: O provider `totalGeralProvider` no `resumo_provider.dart` será modificado para:
  `Soma(despesasFixas.valor) + Soma(comprasCartao.valor)`.

## Risks / Trade-offs

- [Risco] Lista ficar muito longa. → [Mitigação] Manteremos o scroll suave e a possibilidade de expansão apenas quando necessário.
- [Risco] Confusão sobre o que é rateado. → [Mitigação] Usaremos cores e ícones distintos para diferenciar o que é 1/3 (casa) do que é 100% (cartão).
