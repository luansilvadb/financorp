# Spec: Estrutura Modular e Sincronização

## Requisitos
### Requirement: Persistência no Supabase
O sistema deve salvar todas as operações de escrita no banco de dados remoto para garantir que os dados sobrevivam ao reinício do aplicativo.
- **GIVEN** O aplicativo está conectado à internet.
- **WHEN** O usuário adiciona uma despesa ou compra de cartão.
- **THEN** O dado deve ser persistido imediatamente no PostgreSQL do Supabase.

### Requirement: Sincronização de Estado (Riverpod)
O estado das abas deve ser gerenciado por providers para evitar inconsistência de dados entre as visualizações (Despesas vs Resumo).
- **GIVEN** Uma despesa marcada como paga na aba de Despesas.
- **WHEN** O usuário navega para a aba de Resumo.
- **THEN** O valor pendente da pessoa deve estar atualizado refletindo o pagamento.

### Requirement: Filtro por Período
A navegação por mês e ano deve filtrar todos os dados (despesas, compras e pagamentos) de forma consistente.
- **GIVEN** O seletor de mês está em "Março/2026".
- **WHEN** O usuário navega entre as abas.
- **THEN** Apenas os dados referentes a Março/2026 devem ser exibidos.

## Cenários de Teste

### Cenário: Adição de Compra no Cartão
- **WHEN** Adiciono uma compra de "Farmácia" no valor de R$ 50,00 para "Luciana".
- **THEN** O Supabase deve conter o novo registro e o Resumo da Luciana deve aumentar a dívida de cartão em R$ 50,00.

### Cenário: Toggle de Pagamento
- **WHEN** Marco "Luan" como pago na despesa "Aluguel".
- **THEN** O Status do Pote da Casa na aba Resumo deve progredir proporcionalmente ao valor (1/3 do aluguel).
