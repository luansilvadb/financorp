# Active Context

## Current State (2026-03-05)
The app has undergone a **complete architectural refactor** and is now a modular, feature-first Flutter application with Supabase backend and Riverpod state management. All core CRUD functionality is working and persisting to Supabase. The "Tesouraria Virtual" (Virtual Treasury) system is fully implemented, separating house expenses from personal credit card debts. O sistema de navegação temporal foi aprimorado com lógica inteligente de virada de ano e controles explícitos.

### Key Milestones Achieved
1. **Modelagem Modular** — Transição de arquivo único (~1600 linhas) para estrutura `core/`, `shared/`, `features/`.
2. **Integração Supabase** — Persistência real de dados usando PostgreSQL via Supabase.
3. **Gestão com Riverpod** — Transição de `setState` para `flutter_riverpod` para sincronia reativa.
4. **Segurança de Ambiente** — `.env` via `flutter_dotenv` para credenciais sensíveis.
5. **Profissionalização DB** — Supabase Migrations e políticas de RLS implementadas.
6. **Rebrand UI Completo** — Atualização visual de todas as abas (Despesas, Cartão, Resumo) com design system moderno (Manrope), nova paleta e avatares.
7. **Tesouraria Virtual** — Implementação do "Pote da Casa" e separação estrita de dívidas de cartão vs. contas fixas (aba Despesas agora mostra apenas contas da casa).
8. **Pagamentos de Cartão** — O sistema agora permite marcar itens individuais do cartão como pagos, abatendo a dívida automaticamente do resumo em tempo real.
9. **UX de Formulários** — Formulários de adição adaptados para mobile-first com botões de ação flutuantes (FAB) e auto-enquadramento de tela (`Scrollable.ensureVisible`).
10. **Navegação Inteligente** — Correção da virada de ano (Dez/Jan), adição de navegação de ano explícita e botão "Hoje".

## What Was Done (Archived Changes via OpenSpec)
As seguintes mudanças foram propostas, implementadas e arquivadas:
1. `2026-03-04-app-casa-transparente` — MVP inicial do app.
2. `2026-03-04-format-currency-input` — Formatação de input monetário BRL.
3. `2026-03-05-expand-person-cards` — Expansão de cards por pessoa no resumo.
4. `2026-03-05-fix-summary-card-overflow` — Correção de overflow em cards de resumo.
5. `2026-03-05-tesoureiro-unico` — Ajuste de tesoureiro único (Luan como pagador principal).
6. `2026-03-05-virtual-treasury` — Tesouraria virtual.
7. `refactor-modular-supabase-riverpod` — Refatoração completa para arquitetura modular com Supabase e Riverpod.
8. `2026-03-05-fix-person-summary-status-card` — Status consolidado (casa+cartão) nos mini-cards.
9. `2026-03-05-unify-expenses-card-view` — Lista única de despesas fixas e cartão.
10. `2026-03-05-fix-card-calculation-summary` — Correção de cálculos de recebíveis no resumo.
11. `pagamento-cartao` — Adição do status de pagamento (pago/pendente) nas compras de cartão e padronização da UI.
12. `fix-deprecated-value-dropdown` — Correção de `deprecated_member_use` no `DropdownButtonFormField` trocando `value` por `initialValue`.
13. `period-navigation-refactor` — Navegação inteligente de período com correção de virada de ano e novos controles de UI.
14. `refactor-form-to-bottom-sheet` — Refatoração de formulários inline para Bottom Sheets elegantes.

## Active Change (In Progress)
Nenhuma mudança ativa no momento. O sistema está estável e atualizado com os novos Bottom Sheets.

## Current Work Focus
- Manutenção da estabilidade do sistema modularizado.
- Preparação para funcionalidades futuras (Auth, Storage).

## Next Steps (Potential)
1. **User Authentication** — Implementar login real via Supabase Auth (atualmente usa chave pública `anon`).
2. **Receipt upload** — Integração com Supabase Storage para upload de fotos de recibos.
3. **Grocery budget module** — Implementar o limite mensal de R$ 1200 específico para compras de mercado.
4. **Push notifications** — Alertas de novas despesas ou lembretes de pagamento.
5. **Otimização de Cache** — Implementar offline-first caching usando Supabase local persistence ou SQLite.

## Active Decisions
- **Feature-First Architecture**: Organizar por funcionalidades (`finance`, `cartao`) em vez de camadas puras.
- **Server-Side UUIDs**: IDs gerados pelo Postgres (`gen_random_uuid()`).
- **Provider-based Period**: Estado de "Mês/Ano" é um `Notifier` global sincronizado em todos os repositórios.
- **Dotenv for Safety**: Credenciais do Supabase ficam em `.env`, fora do controle de versão.
- **OpenSpec Workflow**: Gerenciamento de mudanças via OpenSpec (propose → apply → archive).

## Important Patterns & Preferences
- **ConsumerWidget/ConsumerStatefulWidget**: Padrão adotado para todos os componentes que consomem estado.
- **AsyncValue Pattern**: Uso do pattern do Riverpod para lidar com loading/error/data de forma declarativa.
- **Clean UI Logic**: Lógica de cálculo (resumo) movida para `resumoProvider`, mantendo as views simples.
- **RLS permissivo**: Políticas de RLS atualmente permitem acesso total via role `anon`. Requer auth futura.

## Learnings
- A migração de `setState` para `Riverpod` em um app já funcional requer atenção especial à sincronia de carregamentos assíncronos (AsyncValue).
- O Supabase CLI facilita imensamente o gerenciamento de esquemas via migrations.
- Usar `withValues(alpha: X)` é o substituto moderno para `withOpacity(X)` no Flutter.
- O OpenSpec workflow facilita o rastreamento de mudanças e decisões ao longo do tempo.
