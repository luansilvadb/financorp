# Progress

## What Works ✅
- **Arquitetura Modular**: Sistema escalável e organizado por features (Core, Shared, Features).
- **Persistência Supabase**: Dados salvos em tempo real via PostgreSQL.
- **Estado Reativo (Riverpod)**: Sincronização automática entre abas e componentes.
- **Migrations de Banco**: Esquema versionado via Supabase CLI.
- **Filtro Global de Período**: Mês/Ano unificado em todo o app.
- **Tesouraria Virtual**: Separação clara entre cotas da casa e dívidas interpessoais de cartão.
- **CRUD Completo**: Despesas fixas, status de pagamento reativo e gastos no cartão.
- **Controle de Pagamentos (Cartão)**: Compras individuais no cartão podem ser marcadas como pagas e são abatidas do resumo geral instantaneamente.
- **Cálculo de Resumo**: Dashboard dinâmico com barra de progresso do "Pote da Casa".
- **Formatação BRL**: Máscaras de input e exibição profissional de moeda.
- **UI/UX Moderna**: Rebrand completo das telas principais (Despesas, Cartão, Resumo) adotando a fonte Inter (via google_fonts), ícones PhosphorIcons e layout focado em usabilidade e clareza.
- **Formulários Acessíveis**: Formulários com foco automático inteligente (Auto-scroll), botões flutuantes (FABs) e elementos responsivos para mobile-first.
- **Navegação Inteligente de Período**: Correção da virada de ano (Dez/Jan), navegação de ano explícita e botão "Hoje".
- **Formulários em Bottom Sheets**: Refatoração estética e funcional para melhorar a UX, desacoplando formulários das listas principais.
- **Separação Estrita**: Aba de Despesas focada puramente no rateio da casa.
- **FinTech Premium Rebrand**: Fonte Inter + PhosphorIcons em todas as views, nav bar e bottom sheets. Traço fino e uniforme, com alternância regular/fill para estados.
- **High-Density Cards**: Cards de lista como `ConsumerWidget` compactos com Bottom Sheets de detalhe.
- **Modelos Imutáveis (Freezed)**: Geração de serialização JSON e operador `copyWith` super rápido evitando problemas de reatividades residuais e bugs de igualdade (`==`).
- **Optimistic UI**: Interface 0-lags e fluidas. Mutações e ações como deletar ou marcar pendências alteram os dados num piscar de olhos, garantindo UX Premium (Falhas acionam um rollback safe via Error global da Scaffold).

## What's Left to Build 🔲
- [ ] **User Authentication** — Login individual via Supabase Auth.
- [ ] **Receipt Image Upload** — Salvar fotos de notas fiscais no Supabase Storage.
- [ ] **Offline Cache** — Cache local para funcionamento sem internet.
- [ ] **Push Notifications** — Avisos de novas despesas ou cobranças amigáveis.
- [ ] **Validação de Formulários**: Snackbars de erro para campos vazios ou falhas de rede.

## Current Status
**Phase**: Optimistic UI & Freezed Migration  
**Version**: 2.8.0 (Optimistic State)  
**Last delivered change**: `optimistic-ui-and-freezed` — Modelos mudaram para Freezed, UI reage em 0ms c/ Optimistic UI.

## Known Issues
1. **Public Anon Access**: RLS aberto para `anon`. Requer Auth.
2. **Sem Offline-First**: Dependência de conexão ativa no envio local (mesmo com Optimistic State mitigando atrasos de input).

## Evolution of Decisions
| Decision | Original Plan | Current Implementation | Reason |
|----------|--------------|----------------------|--------|
| **Architecture** | Single-file | **Modular (Feature-First)** | Scalability and professionalism |
| **State Management** | setState | **Riverpod (Notifier)** | Complex data sync requires better tools |
| **Persistence** | None | **Supabase (Postgres)** | Persistence requirement for real use |
| **Database Identity** | Timestamp IDs | **Server-side UUIDs** | Relational best practices |
| **Security** | Hardcoded Keys | **Dotenv (.env)** | Security best practices |
| **Tesouraria** | Luan Paga Tudo | **Virtual Treasury** | Transparency for Luan's own share |
| **Typography** | Manrope | **Inter (google_fonts)** | FinTech premium feel, precise number rendering |
| **Icon Library** | Material Icons | **PhosphorIcons** | Unified thin stroke, premium FinTech aesthetic |
| **Widget Granularity** | `_build` methods in Tabs | **Isolated ConsumerWidgets** | Prevent full-page rebuilds on single-item changes |
| **Resumo Rendering** | Single `ref.watch(resumoProvider)` | **`.select()` per person** | Rebuild only the affected mini-card |
| **Card Interaction** | Expandable accordion cards | **High-Density + Detail Sheets** | No layout shift, compact list, actions via Bottom Sheet |
| **Data Models** | Maps e classes simples | **Anotações `@freezed`** | Tipagem rigorosa, métodos gerados, imutabilidade fácil |
| **Data Synchronization**| Pessimista (`ref.invalidate()`) | **Optimistic UI local state** | UX ágil, latência instantânea (0ms). |
