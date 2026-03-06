# Spec: Optimistic UX & Data Integrity

## User Story
Como morador da casa que busca agilidade no controle financeiro,
Eu quero que minhas interações no app sejam instantâneas e sem espera,
Para que a gestão das contas não pareça uma tarefa burocrática e lenta.

## Requirements

### Instant Mutation Feedback (Optimistic UI)
O sistema DEVE fornecer feedback visual instantâneo (latência visual de 0ms) para as seguintes mutações:
- Alternância de status de pagamento (toggle).
- Adição, edição e exclusão de itens.

#### Cenários de Optimistic UI
- **Sucesso**: O estado local é atualizado imediatamente. Quando o backend confirma, o estado permanece estável sem re-carregamento total da lista.
- **Falha (Rollback)**: O estado local é revertido ao valor anterior e o usuário é notificado via erro global (SnackBar).

### Immutable Data Models
- O sistema DEVE utilizar modelos de dados formais e imutáveis (`freezed`) para garantir operações de deep copy seguras durante atualizações de estado local.
- Todas as classes de modelo DEVEM implementar métodos de cópia gerados (ex: `copyWith`).

## Acceptance Criteria
- [ ] Mutação visual ocorre antes do retorno do Supabase.
- [ ] O app não exibe spinners de carregamento em mutações de lista.
- [ ] Falhas de rede restauram o estado visual anterior automaticamente.
- [ ] Modelos de dados utilizam exclusivamente imutabilidade `freezed`.
