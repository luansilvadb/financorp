## MODIFIED Requirements

### Requirement: Status de Adimplência Consolidado
O sistema SHALL exibir um status consolidado (Casa + Cartão) nos mini-cards de resumo dos moradores. O status é considerado "Em dia" apenas se a soma de todas as pendências (casa e cartão) for menor ou igual a zero. O card SHALL exibir o avatar unificado (DiviAvatar) do morador.

#### Scenario: Luciana está em dia com a casa mas deve o cartão
- **WHEN** Luciana pagou todas as suas despesas de casa (pendenteCasa = 0)
- **BUT** ela ainda tem compras pendentes no cartão (pendenteCartao > 0)
- **THEN** o card de Luciana deve exibir o status "⚠️ Faltam R$ [valor do cartão]"
- **THEN** a cor de destaque do card deve ser vermelha (indicando pendência)
- **THEN** o card deve exibir o DiviAvatar da Luciana com a inicial "L" e sua cor temática

#### Scenario: Luan tem saldo positivo no balanço geral
- **WHEN** Luan pagou sua parte da casa (pendenteCasa = 0)
- **AND** ele tem valores a receber no cartão (pendenteCartao > 0)
- **THEN** o card do Luan deve exibir "✅ Em dia"
- **THEN** a cor de destaque do card deve ser verde
- **THEN** o card deve exibir o DiviAvatar do Luan com a inicial "L" e sua cor temática

#### Scenario: Luan deve para a casa mas tem crédito a receber
- **WHEN** Luan não pagou sua parte da casa (pendenteCasa = 500)
- **AND** ele tem crédito a receber de 600 (pendenteCartao = 600)
- **THEN** o balanço total é -100 (crédito)
- **THEN** o card do Luan deve exibir "✅ Em dia"
- **THEN** a cor de destaque do card deve ser verde
- **THEN** o card deve exibir o DiviAvatar do Luan com a inicial "L" e sua cor temática
