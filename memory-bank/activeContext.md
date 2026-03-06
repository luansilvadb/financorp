# Active Context

## Current State (2026-03-06)
The app has undergone a **complete architectural refactor** and is now a modular, feature-first Flutter application with Supabase backend and Riverpod state management. All core CRUD functionality is working and persisting to Supabase. O sistema de navegação temporal foi aprimorado. **Um rebrand visual "FinTech Premium" foi aplicado**, trocando a fonte para Inter e todos os ícones para PhosphorIcons. **Uma otimização de granularidade de widgets (Riverpod)** foi implementada isolando cards. **Modelos de dados foram migrados para Freezed**, implementando imutabilidade estrita e geração de código para serialização JSON. Acoplado a isso, **Optimistic UI** foi adotada em todas as mutações (`add`, `update`, `delete`, `toggle`), proporcionando feedback visual instantâneo (0ms de latência percebida) e dispensando indicadores de carregamento durante ações comuns.

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
13. **Optimistic UI** — Mutação local instantânea estado via `.copyWith()` (fornecido pelo Freezed) combinada com fallback de erro global (SnackBar) em caso de falha de rede do Supabase, eliminando spinners nas interações corriqueiras.

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
15. `fintech-premium-rebrand` — Rebrand FinTech Premium com fonte Inter e ícones PhosphorIcons.
16. `refactor-widget-granularity` — Otimização de granularidade de widgets Riverpod.
17. `high-density-cards` — Cards compactos de alta densidade com Detail Sheets e one-tap payment.
18. `optimistic-ui-and-freezed` — Migração de modelos de dados para Freezed e implementação de testes e Optimistic UI nos Notifiers do Riverpod.

## Active Change (In Progress)
Nenhuma mudança ativa no momento.

## Current Work Focus
- Evolução da UX com foco em eficiência e densidade visual.
- Manutenção da estabilidade do sistema modularizado.
- Preparação para funcionalidades futuras (Optimistic UI, Auth, Storage).

## Next Steps (Potential)
1. **User Authentication** — Implementar login real via Supabase Auth (atualmente usa chave pública `anon`).
2. **Receipt upload** — Integração com Supabase Storage para upload de fotos de recibos.
3. **Grocery budget module** — Implementar o limite mensal de R$ 1200 específico para compras de mercado.
4. **Push notifications** — Alertas de novas despesas ou lembretes de pagamento.
5. **Otimização de Cache** — Implementar offline-first caching usando Supabase local persistence ou SQLite.

## Active Decisions
- **Feature-First Architecture**: Organizar por funcionalidades (`finance`, `cartao`) em vez de camadas puras.
- **Server-Side UUIDs**: IDs gerados pelo Postgres (`gen_random_uuid()`).
- **Provider-based Period**: Estado de "Mês/Ano" é um `Notifier` global.
- **OpenSpec Workflow**: Gerenciamento via `propose` -> `apply` -> `archive`.
- **Inter Font & PhosphorIcons**: Aesthetic FinTech Premium garantido.
- **Modelos Imutáveis**: Uso exclusivo de `freezed` para definir modelos com `copyWith` robusto e serialização (via `json_serializable`).
- **Optimistic UI Padrão**: As ações da UI reagem instantaneamente e revertem com rollback (rethrow + Snackbar global) se a rede falhar. `ref.invalidateSelf()` é usado somente após Inserts para resgatar UUIDs do servidor.

## Important Patterns & Preferences
- **ConsumerWidget/ConsumerStatefulWidget**: Padrão adotado para todos os componentes que consomem estado.
- **High-Density Cards**: Cards de lista são `ConsumerWidget` puramente visuais (sem estado `isExpanded`). Toque no corpo abre um Bottom Sheet de detalhes; toque no ícone de status alterna pagamento com haptic feedback.
- **Riverpod `.select()` Pattern**: Usado no `PersonSummaryRow` para escutar apenas a fatia de dados relevante (`resumoProvider.select((res) => res["Nome"])`), evitando rebuilds desnecessários.
- **Tabs como ConsumerWidget leves**: `DespesasTab` e `CartaoTab` são `ConsumerWidget` (não `StatefulWidget`), sem ScrollController ou expandedId. Cards filhos também são `ConsumerWidget` sem estado local.
- **Detail Bottom Sheets**: `DespesaDetailsSheet` e `CartaoDetailsSheet` hospedam ações de Editar, Excluir e toggle de pagamento, seguindo o padrão de UX do app.
- **AsyncValue Pattern**: Uso do pattern do Riverpod para lidar com loading/error/data de forma declarativa.
- **Clean UI Logic**: Lógica de cálculo (resumo) movida para `resumoProvider`, mantendo as views simples.
- **RLS permissivo**: Políticas de RLS atualmente permitem acesso total via role `anon`. Requer auth futura.
- **PhosphorIcon Rendering**: Usar `PhosphorIcon(...)` widget em vez de `Icon(...)` para garantir renderização correta dos ícones Phosphor. Para a NavBar, a assinatura `_navBtn` recebe dois `PhosphorIconData` (regular + fill) e alterna baseado no estado selecionado.

## Learnings
- A migração de `setState` para `Riverpod` em um app já funcional requer atenção especial à sincronia de carregamentos assíncronos (AsyncValue).
- O Supabase CLI facilita imensamente o gerenciamento de esquemas via migrations.
- Usar `withValues(alpha: X)` é o substituto moderno para `withOpacity(X)` no Flutter.
- O OpenSpec workflow facilita o rastreamento de mudanças e decisões ao longo do tempo.
- `PhosphorIcons.xxx(PhosphorIconsStyle.regular)` retorna `PhosphorIconData` (que extends `IconData`), não `PhosphorFlatIconData`. Usar o tipo correto nos parâmetros de funções.
- `PhosphorIcon(...)` não pode ser `const` pois depende de chamadas de método em runtime. Remover `const` de widgets pais que contenham `PhosphorIcon`.
- **Funções `_build` dentro de StatefulWidgets** que chamam `ref.watch()` vinculam o watch à tela inteira, causando rebuilds desnecessários. Extrair para `ConsumerWidget` isolado resolve isso.
- **`.select()` do Riverpod** é essencial quando múltiplos consumidores escutam o mesmo Provider mas se interessam apenas por fatias específicas dos dados.
- **Tabs não precisam de `StatefulWidget`** se o estado visual (expansão, scroll) pode ser delegado aos widgets filhos. Simplificar para `ConsumerWidget` melhora performance.
- **Detail Sheets como padrão de ação**: Ações secundárias movidas para Bottom Sheets de detalhe mantêm as listas compactas.
- **Optimistic UI Pattern**: É mais fluído atualizar o estado `AsyncData` localmente `state = state.whenData((list) => ...)` e capturar erros try/catch revertendo ao estado anterior, do que depender de `ref.invalidateSelf()`. Isso cria uma experiência "FinTech Premium" focada em performance aparente.
- **Global Keys**: Foi criado um `scaffoldMessengerKey` armazenado no `constants.dart` e acoplado ao `MaterialApp` para exibir SnackBars globais gerados por exceções dentros dos Providers.
- **Freezed & Constructor Annotations**: Ao usar anotações do tipo `@JsonKey` nos construtores `factory` do Freezed, o analisador Dart nativo reclama (`invalid_annotation_target`). Isso é resolvido adicionando um ignore local em `analysis_options.yaml` mantendo as validações ativas de code generation, mas ocultando o erro sintático visual.
