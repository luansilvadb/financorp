## 1. Lógica de Cálculos e Estado

- [x] 1.1 Atualizar o método `pendente(String p)` para voltar a calcular dívida de casa para o Luan também (remover o short-circuit `if (p == "Luan") return 0`).
- [x] 1.2 Criar métodos auxiliares `pendenteCasa(String p)` e `pendenteCartao(String p)` para permitir a quebra visual nos cards.
- [x] 1.3 Garantir que para o Luan, `pendenteCartao` retorne o valor (a ser interpretado como crédito) para ser usado na UI de "A Receber".

## 2. UI: Cards de Resumo dos Moradores (Topo e Aba Resumo)

- [x] 2.1 Alterar o layout do Person Card para exibir duas linhas de detalhamento: "Casa" e "Cartão" em vez de apenas uma linha genérica ou o texto "Tesoureiro".
- [x] 2.2 Formatar a linha do Luan para exibir: "Casa: R$ X (sua parte)" e "Cartão: R$ Y (a receber de terceiros)".
- [x] 2.3 Restaurar as cores de status (Verde/Vermelho) no card do Luan baseado apenas na pendência dele com a "Casa".

## 3. UI: Cards de Despesa (Aba Despesas)

- [x] 3.1 Restaurar a exibição do toggle de pagamento para o Luan em `_buildDespesaCard` (remover o filtro `.where((p) => p != "Luan")`).
- [x] 3.2 Corrigir o espaçamento do `Row` dos toggles para que os 3 ícones caibam harmonicamente.

## 4. UI: Consolidado da Tesouraria (Aba Resumo)

- [x] 4.1 Adicionar uma nova seção ou widget na aba Resumo chamada "Estado do Pote da Casa".
- [x] 4.2 Exibir o cálculo: `Soma de (valor da despesa / 3) para cada check feito no app`.
- [x] 4.3 Mostrar o comparativo entre "Arrecadado" vs "Custo Total da Casa".
