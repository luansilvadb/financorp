## MODIFIED Requirements

### Requirement: Otimização do resumoProvider
O sistema SHALL implementar o cálculo de resumos através de um motor de processamento single-pass O(N). O acesso a itens individuais dentro do motor DEVE ser feito via indexação por Map (O(1)). O estado final DEVE ser exposto via Records para garantir densidade máxima de dados.

#### Scenario: Atualização instantânea do dashboard
- **WHEN** qualquer status de pagamento é alterado localmente (Optimistic UI)
- **THEN** o resumo consolidado reflete a mudança sem latência perceptível e sem disparar re-fetches de rede

### Requirement: Granularidade e Performance de Dados (O(N))
O sistema SHALL utilizar Records e Switch Expressions para processamento denso. O uso de seletores granulares (`ref.watch(provider.select(...))`) é OBRIGATÓRIO para widgets de lista para garantir que rebuilds ocorram apenas quando o dado indexado específico for alterado.

#### Scenario: Rolagem fluida com centenas de itens
- **WHEN** o usuário rola a lista de despesas ou cartão
- **THEN** a taxa de quadros permanece em 60fps constantes devido à minimização de rebuilds desnecessários
