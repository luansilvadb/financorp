# Spec: Granular State Engine

## User Story
Como desenvolvedor e usuário do financorp que busca uma interface fluida,
Eu quero que o aplicativo processe dados financeiros complexos de forma eficiente e invisível,
Para que a interface responda instantaneamente e sem travamentos, mesmo com centenas de registros.

## Requirements

### Cálculo de Agregação O(N)
- O sistema DEVE processar a união de Despesas e Pagamentos em uma única passagem no nível de Provider.
- O processamento de agregados NÃO DEVE ocorrer dentro do método `build` de qualquer Widget.

### Inscrição de Estado Granular
- O sistema DEVE permitir que Widgets individuais (Cards) se inscrevam apenas na parte do estado que lhes diz respeito (ex: `despesaItemProvider(id)`).
- A alteração de um status de pagamento em uma despesa NÃO DEVE disparar a reconstrução de outros cards de despesas não afetados.

### Abstrações de Dados Modernas
- O sistema DEVE utilizar **Dart 3 Records** para retornar múltiplos valores de operações de cálculo internas.
- O sistema DEVE utilizar **Switch Expressions** para lidar com estados de `AsyncValue` de forma densa e exaustiva.

## Acceptance Criteria
- [ ] Listas de despesas mantêm 60fps constantes durante a rolagem.
- [ ] O número de reconstruções de widgets (`Widget.build`) em uma lista é minimizado ao alterar um único item.
- [ ] Código de transformação de dados no `resumoProvider` reduzido em complexidade visual.
