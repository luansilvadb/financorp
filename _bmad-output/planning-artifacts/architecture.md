# Architecture Document: DIVI

**Product:** DIVI (financorp)
**Version:** 1.0
**Date:** 2026-04-12
**Author:** Luan
**Status:** Draft

---

## 1. System Overview

DIVI é um app Flutter mobile-first para gestão financeira de casas compartilhadas. Backend via Supabase (PostgreSQL). State management via Riverpod 3.x. Sem autenticação — acesso anônimo via Supabase anon key.

---

## 2. Architecture Style

**Feature-first com Core + Shared layers:**

```
lib/
  main.dart                    # App entry, MaterialApp, theme, Supabase init
  core/
    data/
      repository.dart          # Supabase CRUD operations (AppRepository)
    engine/
      finance_engine.dart      # Centralized data processing engine (diviEngineProvider)
    providers/
      app_providers.dart       # Riverpod AsyncNotifiers with optimistic updates
    utils/
      formatters.dart          # BRL currency formatter, input formatter
      extensions.dart          # sumBy() extension
    views/
      splash_screen.dart       # Animated splash
  features/
    finance/
      views/
        ledger_screen.dart     # Home: resident summaries, month selector
        archive_screen.dart    # Historical month folders
        resumo_tab.dart        # Per-person summary tab
        despesas_tab.dart      # Fixed expenses tab
        statement_screen.dart  # Individual resident statement
        widgets/               # Finance-specific widgets
    cartao/
      views/
        cartao_tab.dart        # Credit card purchases tab
        widgets/               # Card-specific widgets
  shared/
    constants.dart             # Colors, people names, month names
    models/
      domain.dart              # Freezed models: Despesa, CompraCartao, Pagamento
    providers/
      month_year_provider.dart # Period (month/year) state management
    widgets/                   # Reusable widgets
```

---

## 3. Technology Stack

| Layer | Technology | Version |
|-------|-----------|---------|
| Framework | Flutter | ^3.1.0 |
| State Management | Riverpod | ^3.3.1 |
| Backend | Supabase | ^2.12.0 |
| Data Modeling | Freezed + json_serializable | ^3.2.5 / ^6.7.1 |
| Typography | Google Fonts | (Inter, Young Serif, Space Mono) |
| Localization | intl | BRL currency, Portuguese |
| Env Config | flutter_dotenv | ^6.0.0 |
| Build Tools | build_runner | ^2.4.8 |
| Deployment | Vercel (web) | nixpacks.toml |

---

## 4. Data Model

### 4.1 Database Schema (Supabase)

```sql
-- Despesas fixas
CREATE TABLE despesas (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nome TEXT NOT NULL,
  dia_vencimento INT NOT NULL,
  valor NUMERIC(10,2) NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Compras de cartão
CREATE TABLE compras_cartao (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  data DATE NOT NULL,
  descricao TEXT NOT NULL,
  valor NUMERIC(10,2) NOT NULL,
  pessoa TEXT NOT NULL,  -- 'Luan', 'Luciana', 'Giovanna'
  mes INT NOT NULL,       -- 0-11
  ano INT NOT NULL,
  pago BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Pagamentos (tracking de quem pagou o quê)
CREATE TABLE pagamentos (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  despesa_id UUID REFERENCES despesas(id),
  pessoa TEXT NOT NULL,
  mes INT NOT NULL,
  ano INT NOT NULL,
  pago BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
```

### 4.2 Domain Models (Freezed)

```dart
@freezed
class Despesa with _$Despesa {
  const factory Despesa({
    required String id,
    required String nome,
    required int diaVencimento,
    required double valor,
  }) = _Despesa;
}

@freezed
class CompraCartao with _$CompraCartao {
  const factory CompraCartao({
    required String id,
    required DateTime data,
    required String descricao,
    required double valor,
    required String pessoa,
    required int mes,
    required int ano,
    required bool pago,
  }) = _CompraCartao;
}

@freezed
class Pagamento with _$Pagamento {
  const factory Pagamento({
    required String id,
    required String despesaId,
    required String pessoa,
    required int mes,
    required int ano,
    required bool pago,
  }) = _Pagamento;
}
```

---

## 5. State Management Architecture

### 5.1 Provider Structure

```
diviEngineProvider (computed)          ← Single source of truth
├── despesasProvider (AsyncNotifier)   ← CRUD despesas
├── comprasProvider (AsyncNotifier)    ← CRUD compras
├── pagamentosProvider (AsyncNotifier) ← CRUD pagamentos
└── periodProvider (Notifier)          ← Current month/year
```

### 5.2 Optimistic Updates

Base class `OptimisticNotifier<T>`:
```dart
abstract class OptimisticNotifier<T> extends AsyncNotifier<T> {
  void optimisticUpdate(T newState) { /* apply immediately, rollback on failure */ }
  void optimisticAdd(T item) { /* add to list immediately, rollback on failure */ }
  void optimisticDelete(String id) { /* remove from list immediately, rollback on failure */ }
}
```

### 5.3 Engine Output

`diviEngineProvider` returns `FinanceState`:
```dart
@freezed
class FinanceState with _$FinanceState {
  const factory FinanceState({
    required Map<String, ResidentSummary> residentSummaries,
    required Map<String, List<DespesaCardData>> despesaCards,
    required Map<String, List<CompraCartao>> comprasByPerson,
    required double poteCollected,
    required double poteTarget,
    required int periodMes,
    required int periodAno,
  }) = _FinanceState;
}
```

---

## 6. API Contracts

### 6.1 Supabase Repository

```dart
class AppRepository {
  // Despesas
  Future<List<Despesa>> fetchDespesas();
  Future<Despesa> createDespesa(Despesa despesa);
  Future<void> updateDespesa(Despesa despesa);
  Future<void> deleteDespesa(String id);

  // Compras
  Future<List<CompraCartao>> fetchCompras(int mes, int ano);
  Future<CompraCartao> createCompra(CompraCartao compra);
  Future<void> updateCompra(CompraCartao compra);
  Future<void> deleteCompra(String id);

  // Pagamentos
  Future<List<Pagamento>> fetchPagamentos(int mes, int ano);
  Future<void> upsertPagamento(Pagamento pagamento);
  Future<void> deletePagamento(String id);
}
```

---

## 7. UI Architecture

### 7.1 Design System

- **Base:** Material 3 via `ThemeData`
- **Custom Components:** `ReceiptCard`, `StampAnimation`, `TearLineDivider`, `DiviAvatar`, `StatusBadge`, `GroupSummary`, `PoteProgress`, `HolePunch`
- **Principle:** Display = Custom, Interaction = Material
- **Zero Material elevation** — recibos deitam, não flutuam

### 7.2 Color Tokens

```dart
static const primaryOlive = Color(0xFF6B705C);
static const surfacePaper = Color(0xFFFAF6F1);
static const paperDepth = Color(0xFFEDE8E0);
static const textPrimary = Color(0xFF2C2825);
static const textSecondary = Color(0xFF6B6560);
static const textMuted = Color(0xFF8B8178);
static const semanticPaid = Color(0xFF2A7F62);
static const semanticPending = Color(0xFFD4953B);
static const semanticOverdue = Color(0xFFC2654A);
static const luanBlue = Color(0xFF3B82F6);
static const lucianaPink = Color(0xFFEC4899);
static const giovannaPurple = Color(0xFF8B5CF6);
```

### 7.3 Navigation

- **Primary:** `IndexedStack` com 2 tabs (LedgerScreen, ArchiveScreen)
- **Secondary:** Bottom sheets para formulários e detalhes
- **FAB:** Adicionar despesa/compra
- **Pull-down:** Fechar bottom sheets

---

## 8. Infrastructure

### 8.1 Supabase Setup

- **URL/Key:** Via `.env` (`SUPABASE_URL`, `SUPABASE_ANON_KEY`)
- **RLS:** Enabled mas com políticas permissivas "allow all for anon"
- **Realtime:** Não utilizado no MVP (polling via provider refresh)

### 8.2 Deployment

- **Web:** Vercel com `vercel.json` configurado para SPA
- **Build:** `flutter build web --release`
- **Mobile:** Não implementado no MVP (builds futuros)

### 8.3 Environment Variables

```
SUPABASE_URL=https://xxx.supabase.co
SUPABASE_ANON_KEY=eyJ...
```

---

## 9. Performance Considerations

### 9.1 Cold Start Budget

- **Target:** 2-3 segundos
- **Strategy:** Cache-first, token persistente, skeleton loading

### 9.2 CustomPainter Performance

- `RepaintBoundary` obrigatório em todos os CustomPainters
- `shouldRepaint` rigoroso — só repaint se parâmetros mudarem
- Texturas de papel: `Image.asset` pré-carregado, não procedural por frame

### 9.3 List Performance

- `ListView.builder` para listas > 20 itens
- Granular `.select()` nos providers para minimizar rebuilds

---

## 10. Testing Strategy

- **Unit tests:** Finance engine calculations, domain models
- **Widget tests:** All custom components, form validation, navigation flows
- **Golden tests:** ReceiptCard, TearLineDivider, StatusBadge, EmptyStates
- **Integration tests:** Critical user journeys (open→check→pay)

---

## 11. Technical Debt & Future Considerations

### Known Debt
- **Residentes hardcoded:** 3 fixos em `constants.dart`, divisão hardcoded por 3
- **diviEngineProvider monolítico:** Single source of truth — se falha, UX inteira desmorona
- **Sem autenticação:** Anon key com RLS permissivo — sem accountability

### Future Enhancements
- **Multi-house support:** Adicionar `house_id` a todas as tabelas
- **Supabase Auth:** Email magic link ou OAuth
- **FCM Push Notifications:** Edge Functions → FCM → device
- **Offline sync queue:** Local cache (isar/drift) → sync when online
- **OCR de recibos:** Câmera → ML Kit → auto-fill
- **Dark mode:** Material ColorScheme dark

---

## 12. Glossary

| Term | Definition |
|------|-----------|
| **diviEngineProvider** | Computed provider que agrega todos os dados em FinanceState |
| **OptimisticNotifier** | Base class para updates otimistas com rollback |
| **FinanceState** | Modelo agregado: summaries, cards, compras, pote |
| **Period** | Par mês/ano selecionado (0-based month indexing) |
| **Pote** | Meta mensal de arrecadação (soma despesas fixas) |
