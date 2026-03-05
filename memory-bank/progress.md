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
- **UI/UX Moderna**: Rebrand completo das telas principais (Despesas, Cartão, Resumo) adotando a fonte Manrope, avatares para os usuários e layout focado em usabilidade e clareza.
- **Formulários Acessíveis**: Formulários com foco automático inteligente (Auto-scroll), botões flutuantes (FABs) e elementos responsivos para mobile-first.
- **Navegação Inteligente de Período**: Correção da virada de ano (Dez/Jan), navegação de ano explícita e botão "Hoje".
- **Formulários em Bottom Sheets**: Refatoração estética e funcional para melhorar a UX, desacoplando formulários das listas principais.
- **Separação Estrita**: Aba de Despesas focada puramente no rateio da casa.

## What's Left to Build 🔲
- [ ] **User Authentication** — Login individual via Supabase Auth.
- [ ] **Receipt Image Upload** — Salvar fotos de notas fiscais no Supabase Storage.
- [ ] **Offline Cache** — Cache local para funcionamento sem internet.
- [ ] **Push Notifications** — Avisos de novas despesas ou cobranças amigáveis.
- [ ] **Validação de Formulários**: Snackbars de erro para campos vazios ou falhas de rede.

## Current Status
**Phase**: Refinamento de Lógica Financeira e UX  
**Version**: 2.4.0 (Bottom Sheets UX)  
**Last delivered change**: Refatoração de formulários para Bottom Sheets modulares e elegantes (`refactor-form-to-bottom-sheet`).

## Known Issues
1. **Public Anon Access**: RLS aberto para `anon`. Requer Auth.
2. **Sem Offline-First**: Dependência de conexão ativa.

## Evolution of Decisions
| Decision | Original Plan | Current Implementation | Reason |
|----------|--------------|----------------------|--------|
| **Architecture** | Single-file | **Modular (Feature-First)** | Scalability and professionalism |
| **State Management** | setState | **Riverpod (Notifier)** | Complex data sync requires better tools |
| **Persistence** | None | **Supabase (Postgres)** | Persistence requirement for real use |
| **Database Identity** | Timestamp IDs | **Server-side UUIDs** | Relational best practices |
| **Security** | Hardcoded Keys | **Dotenv (.env)** | Security best practices |
| **Tesouraria** | Luan Paga Tudo | **Virtual Treasury** | Transparency for Luan's own share |
