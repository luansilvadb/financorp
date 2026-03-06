# Active Context (DIVI)

## Current State (2026-03-06)
The app has undergone a **rebrand to DIVI**, adopting the slogan **"Divida sem Dívida"**. The performance engine...
### Key Milestones Achieved
1. **Modelagem Modular** — Transição de arquivo único para estrutura `core/`, `shared/`, `features/`.
2. **Integração Supabase** — Persistência real de dados usando PostgreSQL via Supabase.
3. **Gestão com Riverpod** — Transição de `setState` para `flutter_riverpod` para sincronia reativa.
4. **Segurança de Ambiente** — `.env` via `flutter_dotenv` para credenciais sensíveis.
5. **Rebrand UI Completo** — Atualização visual de todas as abas.
6. **Tesouraria Virtual** — Separação estrita de dívidas de cartão vs. contas fixas.
7. **Pagamentos de Cartão** — O sistema agora permite marcar itens individuais do cartão como pagos.
8. **UX de Formulários** — Bottom Sheets elegantes com botões FAB.
9. **Navegação Inteligente** — Navegação de ano explícita e botão "Hoje".
10. **FinTech Premium Rebrand** — Fonte Inter e PhosphorIcons globais.
11. **High-Density Cards** — Cards compactos sem state `isExpanded`, delegando ações para Detail Sheets.
12. **Modelos Imutáveis (Freezed)** — Mapeamento manual `toMap`/`fromMap` substituído completamente por classes `@freezed` geradas via `build_runner`.
13. **Optimistic UI** — Mutação local instantânea estado via `.copyWith()` combinada com fallback de erro global (SnackBar).
14. **Performance Engine (O(N))** — Processamento centralizado "single-pass" (`FinancorpEngine`) substituindo loops O(P*N) espalhados, acoplado com Dart 3 Records para estados UI (zero boilerplate).
15. **Premium Bottom Nav** — Upgrade para barra de navegação "gooey" com glassmorphism e micro-animações táteis.
16. **Splash Screen Premium** — Implementação de splash screen animada com transição suave e orquestração de inicialização assíncrona.
17. **Rebrand DIVI** — Mudança de nome e slogan para "Divida sem Dívida" e atualização de identidade visual.

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
12. `fix-deprecated-value-dropdown` — Correção de `deprecated_member_use` no `DropdownButtonFormField`.
13. `period-navigation-refactor` — Navegação inteligente de período.
14. `refactor-form-to-bottom-sheet` — Refatoração de formulários inline para Bottom Sheets.
15. `fintech-premium-rebrand` — Rebrand FinTech Premium com fonte Inter e ícones PhosphorIcons.
16. `refactor-widget-granularity` — Otimização de granularidade de widgets Riverpod.
17. `high-density-cards` — Cards compactos de alta densidade com Detail Sheets e one-tap payment.
18. `optimistic-ui-and-freezed` — Migração de modelos de dados para Freezed e implementação de testes e Optimistic UI.
19. `performance-engine-optimization` — Motor unificado O(N) (FinancorpEngine), substituição de UI states freezed por Records e reatividade granular extrema.
20. `improve-bottom-nav-ux` — Rebrand premium da Bottom Navigation com animações orgânicas.
21. `splash-screen-premium` — Splash Screen animada com orquestração de inicialização.

## Active Change (In Progress)
Nenhuma mudança ativa no momento.

## Current Work Focus
- Manutenção da estabilidade do novo motor de alta performance.
- Preparação para funcionalidades futuras (Auth, Storage).

## Next Steps (Potential)
1. **User Authentication** — Implementar login real via Supabase Auth.
2. **Receipt upload** — Integração com Supabase Storage para upload de fotos de recibos.
3. **Grocery budget module** — Implementar limite mensal específico para mercado.
4. **Push notifications** — Avisos de contas e pendências.
5. **Otimização de Cache** — Offline-first caching.

## Active Decisions
- **Feature-First Architecture**: Organização modular por `finance` e `cartao`.
- **Server-Side UUIDs**: IDs gerados pelo banco.
- **Provider-based Period**: Mês/Ano unificados globalmente.
- **Inter Font & PhosphorIcons**: Aesthetic FinTech Premium garantido.
- **Modelos Imutáveis (Core Data)**: Core models persistem usando `@freezed`.
- **Dart 3 Records (UI State)**: Estados derivados para a View utilizam estritamente Dart 3 Records para máxima densidade e ausência de boilerplate gerado.
- **Single-Pass Engine**: A agregação do resumo e indexação das listas ocorre no `FinancorpEngine` em passagem única (O(N)).
- **Reatividade Granular O(1)**: As Views consultam os Records em mapas via `.select()`, reconstruindo-se somente se seu ID específico for alterado.
- **Optimistic UI**: Ações locais são aplicadas instantaneamente; rethrow e Snackbar tratam falhas de rede em fallback.

## Important Patterns & Preferences
- **ConsumerWidget/ConsumerStatefulWidget**: Padrão adotado para todos os componentes que consomem estado.
- **High-Density Cards**: Cards são puros e não contêm estado complexo interno. Tudo é despachado para Detail Sheets.
- **Riverpod `.select()` Pattern**: Essencial para a arquitetura do Motor. `ref.watch(financeEngineProvider.select((s) => s.despesas[id]))` isola os cards eficientemente.
- **Detail Bottom Sheets**: Menus contextuais acionados via tap no card para exibir métricas secundárias e botões de Editar/Excluir.

## Learnings
- **Dart 3 Records** são revolucionários para estados efêmeros de UI, reduzindo brutalmente o boilerplate gerado por classes `freezed`.
- Loops redundantes `O(P*N)` espalhados em views e múltiplos providers geram overhead sensível em listas com mutação frequente. Unificar o processamento em um **Motor único O(N)** (indexando em Mapas O(1)) torna o app extremamente reativo (60fps constantes).
- **`.select()` do Riverpod** brilha intensamente quando combinado com os Mapas indexados do Motor Central, pois restringe o trigger do listener apenas à chave afetada.
