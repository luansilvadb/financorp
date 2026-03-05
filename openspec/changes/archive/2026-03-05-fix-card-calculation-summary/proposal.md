## Por que

Os cartões de resumo na aba de "Resumo" não estão calculando corretamente os valores totais, focando apenas nas despesas fixas da casa e ignorando as dívidas de cartão de crédito. Isso causa confusão para os usuários, pois o "TOTAL A PAGAR" exibido não reflete a realidade das obrigações financeiras de cada pessoa, especialmente para o Luan (que deveria ver quanto tem a receber) e para as outras moradoras (que devem incluir o gasto do cartão no seu total).

## O que muda

- Ajuste na lógica de cálculo do `resumoProvider` para incluir dívidas de cartão no total geral de cada pessoa.
- Correção da visualização para o Luan, permitindo que ele veja o total que tem a receber das outras moradoras como parte de seu resumo.
- Garantia de que o "TOTAL A PAGAR" para Luciana e Giovanna seja a soma de sua parte nas contas da casa + seus gastos individuais no cartão de Luan.

## Capabilities

### New Capabilities
- `total-balance-calculation`: Nova lógica para calcular o balanço final (devedor/credor) de cada morador, consolidando casa e cartão.

### Modified Capabilities
- `resumo-view`: Atualização dos requisitos de exibição do resumo para suportar a distinção entre dívida de casa e dívida de cartão no total.

## Impact

- `app_casa_transparente/lib/features/finance/providers/resumo_provider.dart`: Onde a lógica de cálculo reside.
- `app_casa_transparente/lib/features/finance/views/resumo_tab.dart`: Onde os valores são exibidos (pode precisar de ajustes visuais para clareza).
