## Why

A função "Quitar Tudo" atual é ineficiente tecnicamente (realiza múltiplas chamadas individuais ao banco de dados) e incompleta funcionalmente, pois ignora as despesas fixas da casa no processamento, apesar de incluí-las no cálculo do total devido exibido na interface. Além disso, a falta de uma confirmação de segurança e feedback visual adequado prejudica a experiência do usuário em uma ação financeira crítica.

## What Changes

- **Processamento em Lote (Batch Update)**: Substituição de múltiplas chamadas individuais por uma única operação atômica no Supabase para marcar itens como pagos.
- **Abrangência Total**: A função passará a quitar tanto as compras de cartão quanto a cota de despesas fixas da pessoa para o mês selecionado.
- **Diálogo de Confirmação**: Implementação de um modal de confirmação skeuomorphic para evitar cliques acidentais.
- **Feedback de UX**: Adição de estados de carregamento (loading) no botão, vibração tátil (haptic feedback) ao finalizar e mensagens de sucesso (Snackbar).
- **Refatoração de Lógica**: Migração da lógica de negócio da camada de UI para os Notifiers (Providers), garantindo maior manutenibilidade.

## Capabilities

### New Capabilities
- `batch-payment-processing`: Introduz a capacidade de processar múltiplos pagamentos (cartão e casa) em uma única transação lógica e visual.

### Modified Capabilities
- `consolidated-status-card`: Requisito de que o status "Em dia" deve ser alcançável através de uma única ação de "Quitar Tudo" que limpe todas as pendências calculadas.
- `virtual-treasury`: A lógica de liquidação deve agora suportar a marcação em massa de itens pendentes.

## Impact

- **UI**: `StatementScreen` terá seu FloatingActionButton e diálogos atualizados.
- **Providers**: `CartaoNotifier` e `PagamentosNotifier` receberão novos métodos para processamento em lote.
- **Repositórios**: `CartaoRepository` e `FinanceRepository` serão utilizados para chamadas `upsert` em massa.
- **Engine**: A `FinanceEngine` refletirá as mudanças instantaneamente após o processamento atômico.
