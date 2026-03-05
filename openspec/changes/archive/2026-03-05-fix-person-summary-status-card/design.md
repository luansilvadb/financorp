## Context

Atualmente, o widget `PersonSummaryRow` utiliza apenas o campo `pendenteCasa` do `PersonSummary` para determinar se um morador está "Em dia" ou se "Faltam" valores. Com a implementação da Tesouraria Virtual, o balanço real de cada pessoa é a combinação da Casa e do Cartão, que já está consolidada no campo `totalGeral` do provider.

## Goals / Non-Goals

**Goals:**
- Unificar o status visual dos mini-cards de resumo (`PersonSummaryRow`).
- Garantir que o valor exibido como pendente reflita o total real (Casa + Cartão).
- Manter a distinção visual (cores verde/vermelho) baseada no balanço consolidado.

**Non-Goals:**
- Alterar a lógica de cálculo no `resumoProvider` (ela já está correta).
- Adicionar novos campos ao modelo `PersonSummary`.

## Decisions

- **Uso do `totalGeral` para Status**:
  - A variável `ok` no widget será alterada para `summary.totalGeral <= 0`.
  - Isso garante que, se alguém pagou a casa mas deve o cartão, o status será "pendente" (vermelho).
  - Para o Luan, se o crédito do cartão superar sua dívida da casa, o status será "Em dia" (verde).

- **Mensagem de Pendência Dinâmica**:
  - O texto "Faltam ${fmt(pendCasa)}" será alterado para usar o `totalGeral`.
  - Exemplo: Se `totalGeral > 0`, exibe "⚠️ Faltam ${fmt(totalGeral)}".

## Risks / Trade-offs

- [Risco] Confusão se o usuário pagou a casa e ainda vê "Faltam" por causa do cartão. → [Mitigação] O card já exibe as linhas separadas de "Casa" e "Cartão", permitindo que o usuário entenda a origem da pendência.
