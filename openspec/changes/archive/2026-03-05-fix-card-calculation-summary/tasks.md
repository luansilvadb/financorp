## 1. Refatoração da Lógica de Cálculo

- [x] 1.1 Ajustar o `resumoProvider` em `resumo_provider.dart` para incluir o cartão no `totalGeral`.
- [x] 1.2 Implementar lógica de balanço para o administrador (Luan), onde `totalGeral = pendenteCasa - pendenteCartao`.
- [x] 1.3 Garantir que para os demais (Luciana/Giovanna), o `totalGeral = pendenteCasa + pendenteCartao`.

## 2. Ajustes na Interface (UI)

- [x] 2.1 Atualizar `ResumoTab` em `resumo_tab.dart` para exibir valores negativos corretamente para o Luan.
- [x] 2.2 Alterar o label ou a cor do "TOTAL A PAGAR" no card do Luan caso o valor seja negativo (indicando crédito a receber).

## 3. Validação

- [x] 3.1 Verificar se os totais na aba de Resumo batem com as dívidas reais somadas nas outras abas.
- [x] 3.2 Confirmar se o "Status do Pote da Casa" permanece inalterado e correto.
