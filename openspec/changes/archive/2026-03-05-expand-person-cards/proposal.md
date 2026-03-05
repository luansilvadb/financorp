## Why

Os cartões de resumo por usuário (Luan, Luciana, Giovanna) exibidos na aba "Despesas" atualmente não ocupam toda a largura da tela. Eles ficam alinhados à esquerda, deixando um espaço vazio à direita. Para melhorar a estética e aproveitar melhor o espaço disponível em telas maiores ou diferentes dispositivos, é necessário que esses cartões de resumo ocupem o espaço total do container de forma igual.

## What Changes

- Modificação no layout para que a linha (lista) contendo os resumos dos usuários seja distribuída uniformemente (`Expanded` ou `flex`), fazendo com que os cartões preencham toda a largura disponível da tela em proporções iguais.
- O container que envolve a lista será ajustado para eliminar o espaço vazio à direita.

## Capabilities

### New Capabilities
- Nenhuma.

### Modified Capabilities
- `core`: Ajuste no layout visual dos cartões de resumo de usuário para ocupar o espaço total da tela de forma igual.

## Impact

- Mudança puramente visual na Home (Aba "Despesas")
- Sem impacto em lógicas de cálculo ou arquitetura de dados.
