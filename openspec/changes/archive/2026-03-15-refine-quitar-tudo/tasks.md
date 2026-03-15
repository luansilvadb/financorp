## 1. Repositórios e Notifiers (Batch Implementation)

- [x] 1.1 Adicionar método `markAllAsPaid(String pessoa, int mes, int ano)` em `CartaoNotifier`.
- [x] 1.2 Implementar lógica de atualização em lote no `CartaoRepository` usando `upsert`.
- [x] 1.3 Adicionar método `markAllAsPaid(String pessoa, int mes, int ano)` em `PagamentosNotifier`.
- [x] 1.4 Implementar lógica de atualização em lote no `FinanceRepository` (tabela `pagamentos`) usando `upsert`.

## 2. Interface e UX (StatementScreen)

- [x] 2.1 Criar o diálogo de confirmação skeuomorphic para a ação de "Quitar Tudo".
- [x] 2.2 Atualizar o FAB "QUITAR TUDO" para incluir estado de carregamento (spinner) e cor verde `kPaid`.
- [x] 2.3 Implementar a função de coordenação `_handleQuitarTudo` usando `Future.wait` para chamar ambos os notifiers.
- [x] 2.4 Adicionar feedback tátil (`HapticFeedback.heavyImpact()`) ao sucesso da operação.
- [x] 2.5 Exibir Snackbar de sucesso usando `DiviToasts` ou `ScaffoldMessenger`.

## 3. Validação e Polimento

- [x] 3.1 Validar se o status consolidado na aba "Resumo" reflete "Em dia" imediatamente após o "Quitar Tudo".
- [x] 3.2 Verificar se compras de outros meses NÃO são afetadas pela ação do mês atual.
- [x] 3.3 Garantir que o rollback de estado funcione corretamente caso uma das chamadas de rede falhe.
