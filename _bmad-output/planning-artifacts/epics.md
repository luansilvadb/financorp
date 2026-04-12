---
stepsCompleted: [1]
inputDocuments:
  - prd.md
  - architecture.md
  - ux-design-specification.md
---

# DIVI - Epic Breakdown

## Overview

This document provides the complete epic and story breakdown for DIVI, decomposing the requirements from the PRD, UX Design Specification, and Architecture documents into implementable stories.

## Requirements Inventory

### Functional Requirements

FR1: Dashboard de Status binário ("Em dia" / "Pendente") visível em ≤ 2 segundos
FR2: Visão do Grupo — status coletivo "X/Y em dia"
FR3: Registro de Despesa Fixa (nome, valor, dia vencimento, divisão automática)
FR4: Registro de Compra de Cartão (descrição, valor, data, pessoa, atribuição)
FR5: Marcar Pagamento com feedback visual imediato e animado
FR6: Statement Individual por residente (despesas + compras, agrupado por semana)
FR7: Histórico Mensal com navegação entre meses passados
FR8: Cálculo Automático de Divisão (÷ N residentes) com preview em tempo real
FR9: Notificação de Lembrete para pendências próximas do vencimento
FR10: Busca e Filtro por nome/categoria/status

### NonFunctional Requirements

NFR1: Performance — status em ≤ 2s cold start, cache-first obrigatório
NFR2: Offline Support — leitura de cache, escrita queued
NFR3: Platform — Mobile-first Flutter, web secundário
NFR4: Accessibility — WCAG AA, Dynamic Type 200%
NFR5: Haptic Feedback — mediumImpact ao confirmar pagamento
NFR6: Animação — respeitar Reduce Motion com fallback fade-in
NFR7: Data Integrity — sync correto, last-write-wins para conflitos
NFR8: Push Notifications — FCM + Supabase Edge Functions, informativas não punitivas

### Additional Requirements

- Backend: Supabase PostgreSQL com 3 tabelas (despesas, compras_cartao, pagamentos)
- State Management: Riverpod 3.x com AsyncNotifiers e OptimisticNotifier base class
- Data Models: Freezed + json_serializable
- UI: Material 3 + 8 custom skeuomorphic components
- Deployment: Vercel web (atual), mobile builds (futuro)
- Sem autenticação — anon key com RLS permissivo
- diviEngineProvider como computed single source of truth
- RepaintBoundary obrigatório em CustomPainters
- Testing: unit, widget, golden, integration tests

### UX Design Requirements

UX-DR1: Semáforo emocional — verde #2A7F62, âmbar #D4953B, rust #C2654A. Nunca vermelho para culpa
UX-DR2: Tipografia — Young Serif (display), Inter (body/monetary), Space Mono (datas)
UX-DR3: Spacing scale base 8px — xs=4, sm=8, md=16, lg=24, xl=32, xxl=48
UX-DR4: Stamp Animation — scale 0→1.4→1.0 em 300ms, haptic, bounce, glow dourado
UX-DR5: ReceiptCard — CustomClipper bordas serrilhadas, sombra papel deitado
UX-DR6: TearLineDivider — CustomPainter orgânica, segmentos ondulados
UX-DR7: Bottom Sheet First — 60% altura, radius 20px, nunca tela nova < 10 campos
UX-DR8: Cache-First Loading — cache imediato, shimmer só sem cache, timestamp visível
UX-DR9: Empty States — Welcome, No Data, No Results, Disconnected. Nunca tela branca
UX-DR10: Erros Silenciosos — inline validation, toast discreto, nunca modais
UX-DR11: Button Hierarchy — Primary olive (1/tela), Secondary outline, Destructive rust
UX-DR12: GroupSummary Widget — "X/Y em dia" com avatares, fundo 8% opacidade
UX-DR13: Pull-Down to Close — threshold 80px, resistência elástica
UX-DR14: FAB — olive #6B705C, 56x56px, canto inferior direito

### FR Coverage Map

| FR | Epic | Story(s) |
|----|------|----------|
| FR1 | Epic 1 | 1.2 |
| FR2 | Epic 1 | 1.2 |
| FR3 | Epic 2 | 2.2, 2.3 |
| FR4 | Epic 2 | 2.4, 2.5 |
| FR5 | Epic 3 | 3.2 |
| FR6 | Epic 4 | 4.2 |
| FR7 | Epic 5 | 5.2 |
| FR8 | Epic 2 | 2.3, 2.5 |
| FR9 | Epic 6 | 6.2 |
| FR10 | Epic 4 | 4.3 |

## Epic List

| Epic | Title | Goal | Stories |
|------|-------|------|---------|
| 1 | Project Foundation & Navigation | Setup project infrastructure, theme, navigation shell, and splash | 3 |
| 2 | Expense Management | CRUD for fixed expenses and card purchases with auto-calculation | 5 |
| 3 | Payment Tracking | Mark payments with animated feedback and real-time status updates | 3 |
| 4 | Ledger & Statement Views | Home dashboard, resident drill-down, search/filter | 4 |
| 5 | Monthly Archive | Historical month navigation and summaries | 2 |
| 6 | UX Polish & Consistency | Empty states, error handling, accessibility, performance | 4 |

---

## Epic 1: Project Foundation & Navigation

**Goal:** Establish the project infrastructure, theme configuration, navigation shell, and splash screen. This epic delivers the app skeleton that all other features build upon.

### Story 1.1: Setup Project Infrastructure

As a developer,
I want the project configured with Supabase, Riverpod, Freezed, and all dependencies,
So that the team can start building features on a stable foundation.

**Acceptance Criteria:**

**Given** a fresh Flutter project
**When** I run `flutter pub get`
**Then** all dependencies resolve without conflicts (flutter_riverpod ^3.3.1, supabase_flutter ^2.12.0, freezed, json_serializable, intl, google_fonts, flutter_dotenv)

**Given** the project is set up
**When** I run `dart run build_runner build`
**Then** Freezed models generate without errors

**Given** the .env.example exists
**When** I create .env with SUPABASE_URL and SUPABASE_ANON_KEY
**Then** flutter_dotenv loads variables successfully

**And** Supabase client initializes in main.dart
**And** Riverpod ProviderScope wraps MaterialApp

### Story 1.2: Implement ThemeData with Design Tokens

As a designer/developer,
I want the app theme configured with all color tokens, typography, and spacing,
So that every component uses consistent design tokens from day one.

**Acceptance Criteria:**

**Given** the ThemeData configuration
**When** the app renders
**Then** the colorScheme uses primaryOlive #6B705C, surfacePaper #FAF6F1, and semantic colors (semanticPaid #2A7F62, semanticPending #D4953B, semanticOverdue #C2654A)

**Given** the TextTheme
**When** text renders
**Then** Young Serif is used for display/headlines, Inter for body/labels/monetary, Space Mono for dates/codes

**Given** the design tokens
**When** spacing is applied
**Then** the scale uses base 8px: xs=4, sm=8, md=16, lg=24, xl=32, xxl=48

**And** CardTheme has elevation 0 (recibos deitam, não flutuam)
**And** ButtonStyle uses FilledButton for primary, OutlinedButton for secondary

### Story 1.3: Implement Splash Screen and Navigation Shell

As a user,
I want to see a branded splash screen and navigate between the main sections,
So that I know the app is loading and can access features.

**Acceptance Criteria:**

**Given** the app is launched
**When** the splash screen appears
**Then** it shows DIVI branding with subtle animation and initializes Supabase

**Given** the splash screen finishes loading
**When** the home screen appears
**Then** an IndexedStack with 2 tabs is rendered (LedgerScreen, ArchiveScreen)

**Given** the bottom navigation
**When** I tap a tab
**Then** the correct screen is shown without losing state (IndexedStack preserves each screen)

**And** a FAB is present on the home screen for adding expenses
**And** the navigation follows the "bottom sheet first" pattern for contextual actions

---

## Epic 2: Expense Management

**Goal:** Enable users to add, edit, and delete fixed expenses and card purchases with automatic division calculations and real-time preview.

### Story 2.1: Implement AppRepository with Supabase CRUD

As the data layer,
I want a repository class that handles all Supabase CRUD operations,
So that business logic is decoupled from data access.

**Acceptance Criteria:**

**Given** the AppRepository
**When** fetchDespesas() is called
**Then** it returns a List<Despesa> from the despesas table

**Given** the AppRepository
**When** createDespesa(Despesa) is called
**Then** a new row is inserted and the created Despesa is returned

**Given** the AppRepository
**When** fetchCompras(mes, ano) is called
**Then** it returns List<CompraCartao> filtered by month/year

**Given** the AppRepository
**When** upsertPagamento(Pagamento) is called
**Then** the pagamento is inserted or updated (ON CONFLICT)

**And** all methods handle network errors gracefully (return exceptions, don't crash)

### Story 2.2: Implement Riverpod Providers with Optimistic Updates

As the state management layer,
I want Riverpod AsyncNotifiers with optimistic update support,
So that the UI responds instantly while syncing with Supabase.

**Acceptance Criteria:**

**Given** the OptimisticNotifier base class
**When** optimisticAdd is called
**Then** the item appears in the UI immediately

**Given** the add succeeds on Supabase
**When** the response returns
**Then** the optimistic state is confirmed

**Given** the add fails on Supabase
**When** the error returns
**Then** the item is rolled back and a toast error is shown

**Given** the provider structure
**When** diviEngineProvider is computed
**Then** it watches despesasProvider, comprasProvider, pagamentosProvider, and periodProvider

**And** FinanceState is returned with residentSummaries, despesaCards, comprasByPerson, poteCollected, poteTarget

### Story 2.3: Add Fixed Expense via Bottom Sheet

As a resident,
I want to add a fixed monthly expense through a bottom sheet form,
So that I can quickly register bills to be split with the house.

**Acceptance Criteria:**

**Given** I'm on the home screen
**When** I tap the FAB and select "Despesa Fixa"
**Then** a bottom sheet opens at 60% height with fields: nome, valor (R$ mask), dia_vencimento

**Given** the form is open
**When** I type a value
**Then** the preview updates in real time: "R$ X ÷ 3 = R$ Y/cada"

**Given** the form is valid
**When** I tap "Salvar"
**Then** the StampAnimation plays (scale 0→1.4→1.0, haptic feedback)

**And** the expense appears in the list immediately (optimistic update)
**And** the bottom sheet closes

**Given** I try to close the sheet with unsaved data
**When** I pull down or tap backdrop
**Then** a confirmation appears: "Dados não salvos. Fechar mesmo?"

**And** validation appears inline below fields with 500ms debounce (not while typing)

### Story 2.4: Add Card Purchase via Bottom Sheet

As a resident,
I want to log a credit card purchase with who bought it and who it's split with,
So that I don't forget to track shared expenses.

**Acceptance Criteria:**

**Given** I'm on the home screen
**When** I tap the FAB and select "Compra Cartão"
**Then** a bottom sheet opens with fields: descrição, valor (R$ mask), data (default today), quem_pagou (pre-selected), divide_com (all residents pre-selected)

**Given** the form
**When** I change "divide com"
**Then** the preview updates: "R$ X ÷ N pessoas = R$ Y/cada"

**Given** the form is valid
**When** I tap "Salvar"
**Then** the StampAnimation plays and the purchase is added

**And** data defaults to today, quem_pagou defaults to logged-in user

### Story 2.5: Edit and Delete Expenses

As a resident,
I want to edit or delete an existing expense,
So that I can correct mistakes or remove items.

**Acceptance Criteria:**

**Given** I tap on an existing expense card
**When** the details bottom sheet opens
**Then** I can edit fields and save (same validation as add)

**Given** I tap "Excluir"
**When** the destructive confirmation appears
**Then** a bottom sheet shows: "Tem certeza? Esta ação não pode ser desfeita." with "Cancelar" and "Sim, excluir" buttons

**Given** I confirm deletion
**When** the expense is deleted
**Then** it's removed from the list immediately (optimistic) with fade-out animation

---

## Epic 3: Payment Tracking

**Goal:** Enable residents to mark expenses and purchases as paid with satisfying animated feedback and real-time status updates.

### Story 3.1: Toggle Payment Status on Fixed Expenses

As a resident,
I want to toggle whether I've paid my share of a fixed expense,
So that everyone knows the current status.

**Acceptance Criteria:**

**Given** I'm viewing a despesa details sheet
**When** I see my payment status
**Then** it shows a toggle: "Pago" / "Pendente" with current state

**Given** I toggle to "Pago"
**When** the Pagamento record is created
**Then** the StampAnimation plays (scale 0→1.4→1.0, 300ms, haptic mediumImpact)

**And** the card color changes from âmbar to verde
**And** the GroupSummary updates: "X/Y em dia" recalculates

**Given** I toggle back to "Pendente"
**When** the Pagamento is deleted
**Then** the card returns to âmbar state

### Story 3.2: Toggle Payment Status on Card Purchases

As a resident,
I want to mark individual card purchases as paid,
So that I can track my credit card spending.

**Acceptance Criteria:**

**Given** I'm viewing a card purchase
**When** I swipe right on the purchase
**Then** it's marked as paid with the StampAnimation

**Given** I swipe left on the purchase
**Then** a delete confirmation appears

**And** the purchase "pago" boolean updates in Supabase
**And** the resident's summary recalculates

### Story 3.3: Implement GroupSummary Widget

As a resident,
I want to see "X/Y em dia" with everyone's status at a glance,
So that I know if the whole house is settled.

**Acceptance Criteria:**

**Given** the GroupSummary widget
**When** all residents are paid
**Then** it shows "3/3 em dia" with verde background (8% opacity) and "Paz na casa ✨"

**Given** 1 resident is pending
**When** the widget renders
**Then** it shows "2/3 em dia" with âmbar background and the pending resident's avatar with âmbar ring

**Given** I tap the GroupSummary
**When** it expands
**Then** an accordion shows individual resident details (slide-down 250ms)

**And** the widget uses DiviAvatar components for each resident
**And** changes are announced via aria-live for screen readers

---

## Epic 4: Ledger & Statement Views

**Goal:** Deliver the home dashboard and individual resident statements with search, filter, and drill-down capabilities.

### Story 4.1: Implement LedgerScreen (Home Dashboard)

As a resident,
I want to see the home dashboard with my status and the group's status,
So that I know in 2 seconds if we're all settled.

**Acceptance Criteria:**

**Given** the LedgerScreen loads
**When** the app opens
**Then** the status appears in ≤ 2 seconds (cache-first)

**Given** the month/year selector
**When** I'm on the current month
**Then** it shows "Abril 2026" by default with horizontal month scroller

**Given** the screen renders
**When** there are expenses
**Then** it shows ResidentSummaryCards for each resident with pending/total amounts

**Given** the PoteStatus card
**When** it renders
**Then** it shows a progress bar: collected vs target (total fixed expenses)

**And** the ZReportCard shows total fixed expenses and per-person share

**Given** I tap a resident's card
**When** I navigate
**Then** the StatementScreen opens for that resident

**And** shimmer skeletons appear if no cache exists
**And** "Atualizado às XX:XX" timestamp is visible

### Story 4.2: Implement StatementScreen (Individual Resident)

As a resident,
I want to see my complete statement with all expenses and purchases,
So that I can verify every item and my total owed.

**Acceptance Criteria:**

**Given** the StatementScreen
**When** it opens
**Then** the header shows: resident name, avatar, monthly total "R$ XXX,XX — Sua parte em [mês]"

**Given** the transaction list
**When** it renders
**Then** items are grouped by week, reverse chronological order

**Given** I pull down on the list
**When** the pull-to-refresh triggers
**Then** data refreshes from Supabase with "checando com o grupo..." feedback

**Given** I tap a transaction
**When** it opens
**Then** the details bottom sheet appears with edit/mark-paid options

### Story 4.3: Implement Search and Filter

As a resident,
I want to search and filter expenses,
So that I can find specific items quickly.

**Acceptance Criteria:**

**Given** a search bar on the statement screen
**When** I type a search term
**Then** the list filters by name/description with debounce 300ms

**Given** no results match
**When** the search is empty
**Then** an empty state shows: "Sem resultados para '[termo]'" with "Limpar busca" button

**Given** filter chips are present
**When** I tap "Pago" or "Pendente"
**Then** the list filters by status and shows the filtered total

### Story 4.4: Implement CartaoTab

As a resident,
I want to see all card purchases grouped by person,
So that I can review credit card spending for the month.

**Acceptance Criteria:**

**Given** the CartaoTab
**When** it renders
**Then** purchases are grouped by person (Luan, Luciana, Giovanna)

**Given** a purchase card
**When** I swipe right
**Then** it's marked as paid (StampAnimation)

**Given** I swipe left
**Then** a delete confirmation appears

**And** the tab shows per-person totals at the top
**And** purchases are sorted by date (newest first)

---

## Epic 5: Monthly Archive

**Goal:** Allow users to browse and view historical months to compare spending and verify past payments.

### Story 5.1: Implement ArchiveScreen (Month Folder View)

As a resident,
I want to browse past months as folder cards,
So that I can navigate to any historical period.

**Acceptance Criteria:**

**Given** the ArchiveScreen
**When** it opens
**Then** it shows folder cards for each month that has data, newest first

**Given** a folder card
**When** it renders
**Then** it shows: month name, year, total expenses count, and a folder icon (skeuomorphic)

**Given** I tap a folder card
**When** I navigate
**Then** the LedgerScreen opens for that specific month/year

### Story 5.2: Navigate Historical Months

As a resident,
I want to view a historical month's summary,
So that I can compare with the current month.

**Acceptance Criteria:**

**Given** I'm viewing a historical month
**When** the screen renders
**Then** it shows the same layout as the current month (ZReport, resident summaries, PoteStatus)

**Given** the data is historical
**When** it displays
**Then** items are shown slightly muted (opacity 0.85) to indicate past data

**Given** the month/year header
**When** I tap left/right arrows
**Then** I navigate to adjacent months with slide transition

**And** months with no data show: "Nenhuma despesa registrada em [Mês]" with "Adicionar retroativa" link

---

## Epic 6: UX Polish & Consistency

**Goal:** Ensure all empty states, error handling, accessibility, and performance requirements are met across the entire app.

### Story 6.1: Implement All Empty States

As a user,
I want meaningful empty states instead of blank screens,
So that I always know what to do next.

**Acceptance Criteria:**

**Given** the Welcome state (first access)
**When** there's no data
**Then** it shows: illustration, "Bem-vindo ao DIVI", "Suas contas em paz, com quem divide a vida.", and "Adicionar primeira despesa" button

**Given** the No Data state (empty list)
**When** a list is empty
**Then** it shows: icon 64px #D4D0C8, "Nada por aqui ainda", "Toque no + para adicionar"

**Given** the Disconnected state
**When** offline
**Then** a top banner shows: "Offline — dados locais disponíveis" (never blocks interaction)

**And** FAB is always visible on empty screens
**And** no screen is ever completely white/blank

### Story 6.2: Implement Error Handling & Retry Patterns

As a user,
I want errors handled gracefully without interrupting my flow,
So that I trust the app even when things go wrong.

**Acceptance Criteria:**

**Given** a network failure during save
**When** the error occurs
**Then** a discreet toast shows: "Não foi possível salvar. Tentando novamente..."

**Given** a load failure with no cache
**When** data can't be fetched
**Then** an error empty state shows: "Não foi possível carregar" with "Tentar novamente" button

**Given** retries are attempted
**When** 3 automatic retries fail (1s, 2s, 4s backoff)
**Then** the manual retry button appears

**Given** validation errors in forms
**When** a field is invalid
**Then** inline error appears below the field with 500ms debounce (rust border + "⚠ Valor deve ser maior que zero")

**And** no modal dialogs for validation errors
**And** stack traces are never shown to the user

### Story 6.3: Accessibility Audit & Fixes

As a user with accessibility needs,
I want the app to work with screen readers and support font scaling,
So that I can use DIVI regardless of my abilities.

**Acceptance Criteria:**

**Given** all text
**When** checked for contrast
**Then** all text passes WCAG AA (4.5:1 normal, 3:1 large)

**Given** a screen reader (VoiceOver/TalkBack)
**When** it navigates the app
**Then** all cards have semantic labels: "Conta de luz, R$ 150, pendente, vence dia 15"

**Given** font scaling
**When** system font is set to 200%
**Then** all text scales without truncation

**Given** Reduce Motion is enabled
**When** animations would play
**Then** they fall back to simple fade-in (StampAnimation: 200ms fade, no bounce/shake)

**Given** touch targets
**When** measured
**Then** all interactive elements are ≥ 48x48px

### Story 6.4: Performance Optimization

As a user,
I want the app to feel fast and responsive,
So that I don't abandon it out of frustration.

**Acceptance Criteria:**

**Given** cold start
**When** the app launches
**Then** status is visible in ≤ 2 seconds (cache-first strategy)

**Given** CustomPainters (ReceiptCard, TearLineDivider)
**When** they render
**Then** they're wrapped in RepaintBoundary with shouldRepaint only on parameter change

**Given** lists with > 20 items
**When** they render
**Then** they use ListView.builder (not ListView)

**Given** provider updates
**When** data changes
**Then** granular .select() minimizes widget rebuilds

**Given** shimmer loading
**When** it runs for > 10 seconds
**Then** it transitions to error empty state with retry button

**And** paper textures are Image.asset pre-cached (not procedural per frame)
**And** no dropped frames on mid-range Android devices
