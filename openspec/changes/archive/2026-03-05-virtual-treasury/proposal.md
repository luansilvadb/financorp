## Why

O modelo de "Tesoureiro Único" onde Luan é a própria tesouraria removeu o senso de compromisso compartilhado e a visibilidade das obrigações do próprio Luan perante a casa. Ao introduzir uma "Tesouraria Virtual", separamos o conceito de "Fundo da Casa" (onde todos devem 1/3) do conceito de "Dívida de Cartão" (devida ao Luan). Isso restaura a igualdade entre os moradores e mantém a transparência sobre quem já contribuiu para o pote comum do mês.

## What Changes

- Reintrodução do status de pagamento (toggle) para o morador "Luan", representando sua contribuição para o caixa da casa.
- Separação visual e lógica de pendências em duas categorias: "Cota da Casa" (1/3 das contas fixas) e "Dívidas de Cartão" (compras terceiras no cartão do Luan).
- Inclusão de um status de saúde da "Tesouraria" no Resumo, mostrando o quanto do total da casa já foi arrecadado.
- Atualização da lógica de cálculo de saldos para que Luan também possua uma barra de progresso de pagamentos à casa.

## Capabilities

### New Capabilities
- `virtual-treasury`: Gestão de um fundo virtual compartilhado onde todos os moradores (incluindo o operador central) prestam contas de suas cotas de 1/3.

### Modified Capabilities
- `core`: Refatoração do motor de cálculos `pendente()` e da exibição do Resumo para suportar a distinção entre dívida de condomínio/casa e dívida interpessoal de cartão.

## Impact

- Mudanças na interface de resumo (`_buildResumoTab`) e nos cards de despesa (`_buildDespesaCard`).
- Atualização do modelo de dados e estado global da `pagamentos` para voltar a incluir o ID do Luan nas chaves de status.
- Ajuste nos Person Cards para exibir as duas sub-pendências (Casa vs Cartão).
