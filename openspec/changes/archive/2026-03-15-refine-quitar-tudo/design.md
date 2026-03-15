## Context

A funcionalidade atual de "Quitar Tudo" na `StatementScreen` é implementada diretamente no widget, iterando sobre uma lista de compras de cartão e chamando `togglePagamento` individualmente. Isso causa problemas de performance e inconsistência, pois não processa as despesas fixas (moradia) que compõem o saldo devedor do usuário.

## Goals / Non-Goals

**Goals:**
- Centralizar a lógica de liquidação total nos Notifiers (Providers).
- Processar pagamentos de cartão e casa em uma única ação coordenada.
- Utilizar operações de batch (lote) do Supabase via `upsert`.
- Melhorar o feedback visual e de segurança para o usuário.

**Non-Goals:**
- Alterar o motor de cálculo (`FinanceEngine`).
- Implementar integrações reais com gateways de pagamento (PIX/Cartão). O sistema continua dependendo de input humano para marcar como pago.
- Alterar a lógica de histórico ou auditoria.

## Decisions

### 1. Métodos de Batch nos Notifiers
**Decisão:** Adicionar `markAllAsPaid(String pessoa, int mes, int ano)` em `CartaoNotifier` e `PagamentosNotifier`.
- **Racional:** Mantém a responsabilidade de cada domínio em seu respectivo Notifier, mas permite que a UI coordene as chamadas.
- **Alternativa Considerada:** Criar um `BatchPaymentNotifier` separado. **Rejeitado** para evitar fragmentação de estado e complexidade desnecessária.

### 2. Coordenação via `Future.wait` na UI
**Decisão:** O botão "Quitar Tudo" chamará uma função na UI que agrupa as chamadas aos providers usando `Future.wait`.
- **Racional:** Garante que o feedback visual de "carregando" dure exatamente o tempo necessário para ambas as operações terminarem.

### 3. Diálogo de Confirmação Skeuomorphic
**Decisão:** Implementar um diálogo customizado que segue o padrão visual do app (papel, fontes mono, bordas suaves).
- **Racional:** Mantém a imersão visual e garante segurança operacional.

### 4. Uso de Upsert em Massa
**Decisão:** Passar a lista completa de objetos modificados para o repositório, que por sua vez envia ao Supabase em uma única lista.
- **Racional:** Otimiza drasticamente o uso da rede e reduz a carga no servidor.

## Risks / Trade-offs

- **[Risco] Falha Parcial**: Um dos batches pode falhar enquanto o outro tem sucesso.
  - **Mitigação**: O estado do Riverpod será invalidado apenas em caso de sucesso total. Se um falhar, o Snackbar notificará o erro e o estado anterior será restaurado (rollback otimista).
- **[Trade-off] UX vs Simplicidade**: Adicionar diálogos de confirmação adiciona um clique extra, mas o risco de limpar dados financeiros acidentalmente justifica o custo.
