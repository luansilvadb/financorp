## ADDED Requirements

### Requirement: Tesoureiro Único
O sistema SHALL consolidar todas as dívidas de despesas e compras de terceiros no cartão de crédito diretamente contra o tesoureiro da casa (Luan). Não há o conceito de múltiplos pagadores ou responsáveis de boleto no escopo de arrecadação.

#### Scenario: Visualização do resumo de pendências por terceiro (Luciana ou Giovanna)
- **WHEN** Luciana ou Giovanna acessam a tela principal para ver seus saldos ou o Resumo
- **THEN** o sistema exibe apenas o valor final devido ao Luan (somando sua fatia de cada despesa não-paga e eventuais cartões atrelados a ela)

## MODIFIED Requirements

### Requirement: Settle Debt (Pagamento ao Tesoureiro)
O sistema SHALL permitir que o usuário sinalize o abatimento da sua parte da despesa na interface, indicando que já depositou/transferiu (PIX) sua exata parcela referente àquela despesa para o Luan.

#### Scenario: Sinalização de cota paga
- **WHEN** Giovanna clica no toggle de pagamento sob o "seu" nome no cartão da despesa de Internet
- **THEN** a sua parcela de pendência frente ao Luan diminui equivalentemente, marcando verde
- **THEN** Luan visualiza confiavelmente que esse montante foi transferido

## REMOVED Requirements

### Requirement: Campo "Responsável" na Despesa
**Reason**: Gerava fricção cognitiva manter a informação sobre em nome de quem estava a conta se, no fim das contas, a casa adotou o modelo em que uma única pessoa puxa o dinheiro para pagar tudo e receber num local só.
**Migration**: O dado será descontinuado da entidade de domínio "Despesa" e do banco em memória.
