## Why

Atualmente, os gastos no cartão de crédito (Compras no Cartão) não possuem um sistema de controle de pagamento, ao contrário das despesas fixas da casa. Isso faz com que o resumo de dívidas sempre mostre o valor total das compras, mesmo que a pessoa já tenha reembolsado o Luan, tornando o controle financeiro impreciso ao longo do mês.

## What Changes

- **Status de Pagamento no Cartão**: Adição de um campo booleano `pago` para cada item de compra no cartão.
- **Interface Unificada**: Transformação da lista de compras em cartões expansíveis (estilo `DespesasTab`), permitindo marcar o pagamento individualmente.
- **Integração com Resumo**: O cálculo de dívidas no topo da tela e na aba de resumo passará a considerar apenas os gastos de cartão que ainda não foram marcados como pagos.
- **Persistência**: Atualização do banco de dados (Supabase) e dos repositórios para suportar o novo estado de pagamento.

## Capabilities

### New Capabilities
- Nenhuma nova capability será criada; o foco é a evolução das existentes.

### Modified Capabilities
- `core`: Atualização do modelo `CompraCartao` para incluir o campo `pago`.
- `consolidated-expense-list`: O requisito de exibição de compras de cartão agora inclui a funcionalidade de expansão e controle de status de pagamento.
- `virtual-treasury`: A lógica de cálculo de dívidas de cartão deve filtrar apenas itens não pagos.

## Impact

- **Banco de Dados**: Nova coluna `pago` na tabela `compras_cartao`.
- **Modelos**: Alteração na classe `CompraCartao`.
- **Providers**: Mudança na lógica do `resumoProvider` (finance) e adição de métodos no `cartaoProvider`.
- **UI**: Refatoração do componente de item de lista em `cartao_tab.dart`.
