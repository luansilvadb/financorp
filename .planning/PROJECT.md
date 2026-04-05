# Divi - Project Context

**Type:** Brownfield (existing Flutter app)
**Domain:** Financial management for shared households
**Stack:** Flutter + Riverpod + Supabase + Freezed

---

## What This Is

Divi is a Flutter mobile application for transparent financial management in shared households. It provides real-time tracking of expenses, payments, and card purchases with a focus on clarity and accountability among housemates.

**Core Value:** Enable housemates to track shared finances transparently, with clear visibility into who owes what, when payments are due, and complete audit trails.

---

## Current Milestone: v1.0 Refatoração UI/UX com Forui.dev

**Goal:** Migrar toda a interface do Divi para usar exclusivamente Forui.dev como biblioteca UI, mantendo retrocompatibilidade e contratos existentes.

**Target features:**
- Migração completa de todos os componentes e telas para Forui.dev
- Adoção do design system nativo do Forui.dev (clean/moderno)
- Preservação de APIs públicas e contratos existentes (retrocompatibilidade)
- Melhorias moderadas de performance (rebuilds, lazy loading, widget tree)
- Abordagem incremental em fases: componentes base → telas principais → telas secundárias → cleanup

---

## Context

### Existing Architecture
- **Pattern:** Feature-First + Clean Architecture (Simplified)
- **State Management:** Riverpod (AsyncNotifiers, Providers)
- **Backend:** Supabase (PostgreSQL)
- **Code Generation:** Freezed (immutable models), JSON Serializable
- **Navigation:** Bottom Navigation + IndexedStack

### Validated Capabilities (Already Built)
- ✅ Financial ledger with monthly periods
- ✅ Expense tracking with person-based splits
- ✅ Card purchase management with installment plans
- ✅ Payment processing (cash, virtual treasury, card payment)
- ✅ Archive screen for historical periods
- ✅ Summary cards showing balances and totals
- ✅ Bottom sheet forms for adding/editing transactions
- ✅ Period navigation (month/year selectors)
- ✅ Real-time calculations via Finance Engine
- ✅ Supabase integration for data persistence

### Tech Stack
```yaml
Flutter: ^3.1.0
State: flutter_riverpod ^2.4.10
Backend: supabase_flutter ^2.12.0
Models: freezed ^2.5.2, json_serializable ^6.7.1
UI: google_fonts ^6.3.0, phosphor_flutter ^2.1.0, animations ^2.0.11
Utils: intl ^0.20.2, flutter_dotenv ^6.0.0
```

---

## Active Requirements

*Requirements will be defined during milestone setup.*

---

## Key Decisions

### Architecture Decisions
- **Feature-First Organization:** Code organized by business domains (finance, cartao)
- **Reactive State:** Riverpod for all state management
- **Immutable Models:** Freezed for all domain models
- **Centralized Engine:** FinanceEngine for complex calculations

### UI/UX Decisions (Pre-Migration)
- **Theme:** Paper/skeuomorphic design with custom components
- **Navigation:** Bottom nav with 2 tabs (Ledger, Archive)
- **Forms:** Bottom sheet modals for data entry
- **Cards:** High-density information display

---

## Evolution

This document evolves at phase transitions and milestone boundaries.

**After each phase transition** (via `/gsd-transition`):
1. Requirements invalidated? → Move to Out of Scope with reason
2. Requirements validated? → Move to Validated with phase reference
3. New requirements emerged? → Add to Active
4. Decisions to log? → Add to Key Decisions
5. "What This Is" still accurate? → Update if drifted

**After each milestone** (via `/gsd-complete-milestone`):
1. Full review of all sections
2. Core Value check — still the right priority?
3. Audit Out of Scope — reasons still valid?
4. Update Context with current state

---

*Last updated: 2026-04-05*
*Milestone: v1.0 Refatoração UI/UX com Forui.dev*
