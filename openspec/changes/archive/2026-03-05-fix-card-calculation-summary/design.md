## Context

Atualmente, o `resumoProvider` calcula o `totalGeral` de cada morador de forma inconsistente. Para Luciana e Giovanna, o total deveria ser a soma de suas dívidas da casa e do cartão, mas a lógica atual do `totalGeral` estava ignorando o cartão. Para o Luan, o total mostra apenas o que ele deve para a casa, sem considerar o crédito que ele tem a receber das outras pelo uso do cartão. Isso gera uma visão distorcida da saúde financeira individual.

## Goals / Non-Goals

**Goals:**
- Unificar o cálculo de `totalGeral` para todos os moradores, incluindo obrigações da casa e do cartão.
- Refletir o balanço de créditos/débitos do Luan (Recebíveis - Dívida da Casa).
- Garantir que a UI na `ResumoTab` suporte a exibição clara desses valores consolidados.

**Non-Goals:**
- Alterar o sistema de "Pote da Casa" (arrecadação total de despesas fixas).
- Implementar fluxo de liquidação (marcar que a dívida do cartão foi paga).

## Decisions

- **Ajuste na Lógica do `PersonSummary`**:
  - O `totalGeral` para não-administradores (Luciana/Giovanna) será `pendenteCasa + pendenteCartao`.
  - O `totalGeral` para o administrador (Luan) será `pendenteCasa - pendenteCartao`. Um valor negativo indicará saldo credor (crédito a receber).
  
- **Visualização Reativa**:
  - A `ResumoTab` continuará usando o `fmt()` do `formatters.dart`, mas o label "TOTAL A PAGAR" poderá ser dinâmico ou contextualizado para o Luan se o valor for negativo (ex: "TOTAL A RECEBER" ou simplesmente manter o valor negativo para indicar saldo).

## Risks / Trade-offs

- [Risco] Confusão ao ver um valor negativo no card do Luan. → [Mitigação] O label ou a cor do valor podem ser ajustados se o total for negativo para indicar clareza.
- [Risco] Regressão no cálculo do Pote da Casa. → [Mitigação] Não alteraremos o `arrecadadoCasaProvider` nem o `totalGeralProvider` (que mede o custo total da casa), focando apenas no `resumoProvider`.
