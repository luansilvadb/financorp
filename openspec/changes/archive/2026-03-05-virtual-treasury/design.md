## Context

O sistema atual centraliza tudo no Luan. Precisamos descentralizar a responsabilidade moral (todos devem somar para pagar os boletos) enquanto mantemos a centralização operacional (Luan continua sendo o morador que de fato executa os pagamentos no banco). A "Tesouraria Virtual" é essa camada de abstração que permite ao Luan também ser um devedor da própria casa que ele administra.

## Goals / Non-Goals

**Goals:**
- Restaurar a igualdade visual entre Luan, Luciana e Giovanna (cada um com seu card de pendência).
- Diferenciar claramente o que é "Cota da Casa" (divisão de contas fixas) do que é "Cartão" (empréstimo pessoal).
- Permitir que o Luan dê "check" em suas próprias cotas.

**Non-Goals:**
- Não criaremos uma conta bancária real integrada.
- Não alteraremos o fato de que a divisão é sempre em 3 partes iguais.

## Decisions

**Decisão 1: Categorização das Pendências**
- **O que muda:** O método `pendente(p)` será splitado ou terá um retorno mais rico.
- **Racional:** Facilitar para as moradoras saberem exatamente quanto do PIX total é "pra repor o cartão" e quanto é "pra pagar a luz/aluguel".

**Decisão 2: O Retorno do Toggle do Luan**
- **O que muda:** Os `Row` de pagamento nos cards de despesa voltam a iterar sobre a lista completa de `pessoas` (incluindo Luan).
- **Racional:** Transparência. Se Luan não marcar que "pagou" sua parte, a Tesouraria da casa fica com um buraco visual no resumo.

**Decisão 3: Visão de "Recebíveis" para o Luan**
- **O que muda:** No card do Luan, o campo "Cartão" exibirá o total que ele tem a REBER, enquanto nos das outras exibirá o total que elas tem a PAGAR.
- **Racional:** Manter a utilidade prática do app para o Luan (saber quanto vai entrar no bolso dele no fim do mês para cobrir a fatura do cartão).

## Risks / Trade-offs

- **[Risco] Confusão entre Tesouraria e Luan:** A Luciana pode achar que marcar "Pago" na casa já paga o cartão.
  - **Mitigação:** UI com separação clara de linhas ou cores (ex: Casa = Azul/Verde, Cartão = Laranja).
- **[Risco] Excesso de informação nos cards pequenos:** 
  - **Mitigação:** Manter um "Total Pendente" em destaque e as quebras (Casa/Cartão) em fonte menor logo abaixo.
