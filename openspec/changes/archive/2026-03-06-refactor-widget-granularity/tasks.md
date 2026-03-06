## 1. DespesasTab e DespesaCard

- [x] 1.1 Criar o arquivo `lib/features/finance/views/widgets/despesa_card.dart` contendo a classe `DespesaCard` estruturada como um `ConsumerStatefulWidget`.
- [x] 1.2 Migrar o layout e a dependência do `pagamentosProvider` que estava no método `_buildDespesaCard` para o novo componente isolado, gerenciando `isExpanded` no seu estado nativo.
- [x] 1.3 Refatorar `lib/features/finance/views/despesas_tab.dart` para instanciar `DespesaCard(despesa: d)` e remover declaração do `pagamentosProvider` da base mãe.

## 2. CartaoTab e CartaoCard

- [x] 2.1 Criar o arquivo `lib/features/cartao/views/widgets/cartao_card.dart` com a classe `CartaoCard` (como `ConsumerWidget`).
- [x] 2.2 Migrar toda a renderização individual de cartão para esse bloco reativo, incluindo a escuta ou reações aos itens próprios.
- [x] 2.3 Remover os watch desnecessários nas chamadas `_build` de `CartaoTab`.

## 3. Row de Resumo de Pessoas Otimizada

- [x] 3.1 Refatorar os blocos internos do resumo para que cada pessoa consuma seu status usando uma query parametrizada: `ref.watch(resumoProvider.select((res) => res["Nome"]))`.
- [x] 3.2 Garantir que o `PersonSummaryRow` não exija um rebuild total de todos quando só um componente mudou.

## 4. Testes e Validação

- [x] 4.1 Validar se as animações ou expanções continuam fluídas.
- [x] 4.2 Testar a marcação (checkbox/toggle) dos pagamentos avulsos simulando seletividade entre os cards para garantir ganhos de FPS.
