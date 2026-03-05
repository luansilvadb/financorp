## 1. Implementação Visual (UI)

- [x] 1.1 Atualizar a lógica da variável `ok` em `PersonSummaryRow` para considerar `summary.totalGeral <= 0`.
- [x] 1.2 Atualizar a mensagem de pendência em `PersonSummaryRow` para exibir o valor de `summary.totalGeral` quando o morador não estiver "Em dia".

## 2. Validação

- [x] 2.1 Verificar se morador que pagou a casa mas deve o cartão aparece como "pendente" (vermelho).
- [x] 2.2 Verificar se o Luan aparece como "Em dia" (verde) quando o saldo consolidado (casa - cartão) é favorável.
- [x] 2.3 Garantir que o "Total do Pote da Casa" (no cabeçalho da DespesasTab) permaneça correto, sem ser afetado por essa mudança visual dos cards individuais.
