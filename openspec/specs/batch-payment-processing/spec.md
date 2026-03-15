# Specifications: Batch Payment Processing

Esta especificação define como o sistema processa a liquidação em lote de pendências (Casa e Cartão) para um morador em um determinado mês.

## Features & Scenarios

### Feature: Liquidação em Lote por Pessoa
O sistema DEVE permitir que um usuário marque todas as suas pendências (tanto de Cartão quanto de Casa) como pagas em uma única ação atômica para o mês selecionado.

#### Scenario: Quitar tudo com sucesso
- **WHEN** o usuário clica em "QUITAR TUDO" e confirma no diálogo.
- **THEN** o sistema envia uma atualização em lote para o banco de dados.
- **THEN** todas as compras de cartão daquela pessoa no mês e todas as cotas de despesas fixas daquela pessoa no mês são marcadas como `pago = true`.
- **THEN** o saldo devedor da pessoa na interface é zerado instantaneamente.

### Feature: Diálogo de Confirmação de Segurança
O sistema DEVE exibir um diálogo de confirmação antes de processar a liquidação em lote para evitar execuções acidentais.

#### Scenario: Cancelar a operação de quitar tudo
- **WHEN** o usuário clica em "QUITAR TUDO" e depois em "CANCELAR" no diálogo.
- **THEN** nenhuma alteração é feita no banco de dados.
- **THEN** o diálogo é fechado e o estado permanece inalterado.

### Feature: Feedback Visual de Processamento
O sistema DEVE fornecer feedback visual claro durante e após o processamento da liquidação em lote.

#### Scenario: Feedback após sucesso
- **WHEN** o processamento em lote é concluído com sucesso.
- **THEN** o sistema emite uma vibração tátil (haptic feedback).
- **THEN** um Snackbar de sucesso é exibido confirmando que tudo foi quitado.
- **THEN** o botão "QUITAR TUDO" desaparece (pois o saldo devedor agora é zero).
