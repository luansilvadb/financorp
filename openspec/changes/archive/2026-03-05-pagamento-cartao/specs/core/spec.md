## ADDED Requirements

### Requirement: Status de Pagamento em Compras de Cartão
O sistema SHALL permitir que cada registro de compra no cartão possua um status booleano indicando se o valor já foi reembolsado ao Luan.

#### Scenario: Inicialização de nova compra
- **WHEN** uma nova compra no cartão é cadastrada
- **THEN** o status `pago` deve ser definido como `FALSE` por padrão
- **THEN** o registro deve ser persistido no Supabase com este valor inicial
