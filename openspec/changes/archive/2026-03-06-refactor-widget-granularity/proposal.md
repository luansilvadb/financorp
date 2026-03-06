## Why
A atualização do status de pagamento de uma única despesa ou compra de cartão no formato atual recria a tela inteira, pois as listas e os resumos estão acoplados ao ciclo de vida da *Tab*. Isso causa degradação de desempenho, possíveis "engasgos" ao rolar a página e uso excessivo de recursos do Flutter, especialmente à medida que o número de registros (histórico de meses) aumenta.

## What Changes
- Refatorar a renderização dos itens de despesa em `DespesasTab` para utilizar um `ConsumerWidget` isolado (ex: `DespesaCard`).
- Refatorar a renderização dos itens de compra em `CartaoTab` para utilizar o mesmo padrão de desacoplamento.
- Transferir o controle do estado de "expandido/recolhido" da Tab principal para dentro do próprio Widget do respectivo card.
- Garantir que mudanças no estado de um item (ex: toggle de pagamento) re-renderizem apenas o card afetado e/ou partes estritamente afetadas.

## Capabilities

### New Capabilities
- `list-rendering-optimization`: Implementação de renderização granular para itens de listas, garantindo que widgets filhos escutem apenas as fatias de estado relevantes.

### Modified Capabilities

## Impact
- **Arquivos afetados:** `lib/features/finance/views/despesas_tab.dart`, `lib/features/cartao/views/cartao_tab.dart`.
- **Desempenho:** Melhoria substancial de FPS durante manipulação da UI, menor consumo de memória, scroll mais suave nas listas de registros.
- **Arquitetura (Riverpod):** Transição de views monolíticas para componentes verdadeiramente reativos e granulares usando `ConsumerWidget` ou `.select()`.
