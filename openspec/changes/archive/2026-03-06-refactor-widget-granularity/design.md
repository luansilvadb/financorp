## Context
O aplicativo possui as abas `DespesasTab` e `CartaoTab` que exibem listas de despesas ou compras, e cards de resumo consolidados de três usuários fixos. Atualmente, as listas são renderizadas como parte da própria classe das tabs, utilizando iteráveis num método local (ex: `_buildDespesaCard`), que contém `ref.watch(pagamentosProvider)`. Isso cria um acoplamento onde qualquer alteração em um item da lista ou no pagamento recria a lista completa e todos e os resumos.
O controle do estado "expandido" para exibir os pagamentos de casa também está centralizado num estado raiz da Aba principal (`expandedId`), desencadeando recálculo desnecessário de todos os cards ao simples toque de um item.

## Goals / Non-Goals

**Goals:**
- Desacoplar os itens renderizados, transformando-os em `ConsumerWidget` ou `ConsumerStatefulWidget` próprios (`DespesaCard` e `CartaoCard`).
- Otimizar o uso do Riverpod nos mini-cards interativos na Row de Resumos (`PersonSummaryRow`), escutando reativamente apenas partes específicas do seu estado via `select`.
- Minimizar consumo de memória local e estabilizar os Quadros por Segundo (FPS).

**Non-Goals:**
- Implementar caching offline para repositórios ou dados locais.
- Implementar requisições otimistas (Optimistic UI) com o backend - será tratado independentemente num módulo focado na latência da rede.

## Decisions

- **Transição para Componentes Folha Isolados:**
O `_buildDespesaCard(d)` se tornará o widget `DespesaCard(despesa: d)` que ficará nos diretórios `views/widgets/`. Como o estado de "expandido" precisa ser local ao card e isolar a própria animação para fechar ou revelar interações, o component devedespesa será um `ConsumerStatefulWidget` contendo internamente `bool isExpanded`. Isso retira o controle da Tab central.

- **Select no Riverpod para o PersonSummaryRow:**
O componente de estatísticas da casa que mostra (status de pessoa, verde x vermelho), consome o provider consolidado. Passará a consumir a informação filtrada `ref.watch(resumoProvider.select((res) => res["NOME"]))`, reconstruindo seu contêiner interno unicamente no momento em que seu extrato próprio foi recomputado diferentemente.

## Risks / Trade-offs

[Risco] Rebuild excessivos acidentais caso alguma das refatorações repasse o `watch` inadequado (mantido num pai errado ou propagado). → Mitigação será uma rigorosa revisão nos trechos de passagem de blocos para os filhos.
[Trade-off] Multiplicidade de limiares gerará uma árvore de blocos mais verbosa (mais subpastas, classes).
