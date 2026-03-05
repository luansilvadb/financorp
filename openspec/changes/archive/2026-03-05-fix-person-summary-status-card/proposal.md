## Por que

Os mini-cards de resumo no topo da aba "Despesas" atualmente mostram o status "Em dia" ou "Faltam" baseando-se apenas nas contas fixas da casa. Isso é enganoso, pois um morador pode ter pago sua parte do aluguel mas ainda dever compras no cartão. Precisamos que o status visual reflita a obrigação total pendente de cada pessoa (Casa + Cartão).

## O que muda

- Ajuste no indicador visual (`✅ Em dia` vs `⚠️ Faltam`) para considerar o balanço total de cada morador.
- O valor exibido após o texto "Faltam" passará a ser a soma das pendências de casa e cartão.
- No caso do Luan, o status "Em dia" considerará se o seu débito com a casa é menor ou igual ao seu crédito a receber (ou se ele já pagou sua parte da casa).

## Capabilities

### New Capabilities
- `consolidated-status-card`: Capacidade de exibir um status de adimplência consolidado (Casa + Cartão) nos mini-cards de cada morador.

### Modified Capabilities
- `resumo-view`: Ajuste dos requisitos de exibição para incluir o balanço consolidado no texto de status.

## Impact

- `app_casa_transparente/lib/shared/widgets/person_summary_row.dart`: Onde a lógica visual e o texto de status residem.
