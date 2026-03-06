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
- **UI/UX Moderna**: Rebrand completo com fonte Inter e ícones PhosphorIcons.
- **Formulários Acessíveis**: Formulários com foco automático inteligente em Bottom Sheets.
- **Navegação Inteligente de Período**: Correção da virada de ano e botão "Hoje".
- **High-Density Cards**: Cards de lista como `ConsumerWidget` compactos com ações baseadas em Detail Sheets secundários.
- **Modelos Imutáveis (Freezed)**: Core data protegido com geradores automáticos para `copyWith` e JSON serialization.
- **Optimistic UI**: Mutação zero-lag com fallback automático global via SnackBar.
- **Motor de Alta Performance (O(N))**: `FinancorpEngine` processando agregados e resumos em single-pass.
- **Densidade em UI State**: Uso agressivo de **Dart 3 Records** nos Providers granulares, reduzindo o build-time e consumo de HEAP.
- [x] **Isolamento Total de Rebuilds**: Cards escutam estritamente modificações em seu próprio UUID em tempo `O(1)` no motor.
- [x] **Premium Bottom Navigation**: Barra de navegação com glassmorphism avançado, indicador "gooey" (liquid movement) e micro-interações táteis.

## What's Left to Build 🔲
- [ ] **User Authentication** — Login individual via Supabase Auth.
- [ ] **Receipt Image Upload** — Salvar fotos de notas fiscais no Supabase Storage.
- [ ] **Offline Cache** — Cache local para funcionamento sem internet.
- [ ] **Push Notifications** — Avisos de novas despesas ou cobranças amigáveis.
- [ ] **Validação de Formulários**: Refinamento adicional de validações cliente-side.

## Current Status
**Phase**: Performance & Density Engine  
**Version**: 3.0.0 (FinancorpEngine)  
**Last delivered change**: `improve-bottom-nav-ux` — Upgrade da barra de navegação para estética premium com animações orgânicas.

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
| **Typography** | Manrope | **Inter (google_fonts)** | FinTech premium feel |
| **Icon Library** | Material Icons | **PhosphorIcons** | Unified thin stroke, premium aesthetic |
| **Widget Granularity** | `_build` methods in Tabs | **Isolated `.select()` per ID** | Prevent full-page rebuilds |
| **Data Models** | Maps e classes simples | **Anotações `@freezed`** | Tipagem rigorosa para Database Models |
| **UI Item States** | Classes `@freezed` gen. | **Dart 3 Records** | Performance absoluta e zero-boilerplate para view-models |
| **Data Processing** | Múltiplos Providers | **Single-Pass O(N) Engine** | Eliminar repetitivos loops O(P*N) nos resumos |
| **Data Synchronization**| Pessimista (`ref.invalidate()`) | **Optimistic UI local state** | UX ágil, latência instantânea (0ms). |
