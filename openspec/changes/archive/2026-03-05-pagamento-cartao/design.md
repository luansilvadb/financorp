## Contexto

Atualmente, o aplicativo trata compras de cartão como registros estáticos que sempre contam para o balanço de dívidas. O sistema de pagamento de despesas fixas (1/3 por pessoa) é robusto, mas o de cartão é inexistente. O objetivo é trazer a mesma facilidade de controle para os gastos individuais feitos no cartão do Luan.

## Objetivos / Não-Objetivos

**Objetivos:**
- Permitir que cada moradora marque seus gastos no cartão como "pagos" ao Luan.
- Unificar a linguagem visual entre a aba de Despesas e a de Cartão.
- Refletir o status de pagamento nos cálculos de balanço financeiro em tempo real.

**Não-Objetivos:**
- Suportar pagamentos parciais de uma mesma compra.
- Criar um histórico de transações bancárias (o foco é apenas o status de reembolso).

## Decisões Técnicas

### 1. Modelo de Dados Simplificado
**Decisão:** Adicionar uma coluna `pago` do tipo `BOOLEAN` diretamente na tabela `compras_cartao`.
**Alternativa Considerada:** Criar uma tabela separada `pagamentos_cartao` (seguindo o padrão das despesas fixas).
**Racional:** Diferente das despesas fixas, que são divididas por 3 e precisam de múltiplos registros de status por item, cada compra de cartão pertence a uma única pessoa. Um booleano na própria tabela é mais performático e simplifica as queries.

### 2. Interface de Usuário Coesa
**Decisão:** Refatorar o `CartaoTab` para usar um widget de card expansível customizado, replicando a lógica de `_buildDespesaCard`.
**Racional:** A consistência visual ajuda o usuário a entender que a funcionalidade é a mesma (marcar como pago/não pago). Além disso, permite ocultar o botão de exclusão e o toggle de pagamento dentro da área expandida, limpando a interface principal.

### 3. Lógica de Negócio (Providers)
**Decisão:** Atualizar o `resumoProvider` para filtrar compras de cartão pelo status `pago == false`.
**Racional:** O "Pendente Cartão" no resumo deve representar apenas o que ainda não foi acertado com o Luan.

## Riscos / Trade-offs

- **[Risco] Inconsistência de Dados**: Se a coluna `pago` não for inicializada corretamente para registros antigos.
  - **Mitigação**: O script de migration deve definir `DEFAULT FALSE` para todos os registros existentes.
- **[Risco] Confusão Visual**: Ter dois tipos de cards muito parecidos mas com comportamentos de divisão diferentes (1/3 vs Total).
  - **Mitigação**: Manter ícones distintos (casa vs restaurante/cartão) e labels claros de quem é o devedor.
