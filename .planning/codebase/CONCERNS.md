# Technical Concerns - Divi

## Critical Issues

### 1. RLS (Row Level Security) Disabled in Production
**Severity**: 🔴 HIGH  
**Location**: `supabase/migrations/20260305044257_disable_rls_for_testing.sql`

**Issue**:
```sql
-- Migration explicitly disables RLS for all tables
ALTER TABLE despesas DISABLE ROW LEVEL SECURITY;
ALTER TABLE pagamentos DISABLE ROW LEVEL SECURITY;
ALTER TABLE compras_cartao DISABLE ROW LEVEL SECURITY;
```

**Impact**:
- Any authenticated user can read/write ALL data
- No data isolation between users/households
- Major security vulnerability if app goes to production with multiple households

**Recommendation**:
- Re-enable RLS before production deployment
- Implement proper policies based on `household_id` or similar grouping
- Add tests for RLS policies

**Example Fix**:
```sql
-- Enable RLS
ALTER TABLE despesas ENABLE ROW LEVEL SECURITY;

-- Create policy: Users can only see their household's expenses
CREATE POLICY "Users can view own household expenses"
ON despesas FOR SELECT
USING (auth.uid() IN (
  SELECT user_id FROM household_members 
  WHERE household_id = despesas.household_id
));
```

---

### 2. Hard-Coded Person Names
**Severity**: 🟡 MEDIUM  
**Location**: `lib/shared/constants.dart`

**Issue**:
```dart
const pessoas = ["Luan", "Luciana", "Giovanna"];
const coresPessoa = {
  "Luan": Color(0xFF3b82f6),
  "Luciana": Color(0xFFec4899),
  "Giovanna": Color(0xFF8b5cf6),
};
```

**Impact**:
- Cannot add/remove people without code changes
- Not scalable beyond current 3-person household
- Violates open/closed principle

**Recommendation**:
- Move people to database table
- Fetch dynamically from Supabase
- Allow users to manage household members via UI

---

### 3. Floating Point Arithmetic for Currency
**Severity**: 🟡 MEDIUM  
**Location**: `lib/core/engine/finance_engine.dart`

**Issue**:
```dart
final valorPorPessoa = d.valor / 3;  // Double division
pendenteCasaPessoa[p] = (pendenteCasaPessoa[p] ?? 0.0) + valorPorPessoa;
```

**Impact**:
- Potential rounding errors in financial calculations
- Example: 100.0 / 3 = 33.333333333333336 (not exact)
- Can cause discrepancies in totals

**Recommendation**:
- Use integer arithmetic (store cents instead of reais)
- Or use a decimal library like `decimal` package
- Round to 2 decimal places at display time

**Example Fix**:
```dart
// Store as cents (int)
final valorEmCentavos = (d.valor * 100).round();
final valorPorPessoaEmCentavos = valorEmCentavos ~/ 3; // Integer division

// Convert back for display
final valorPorPessoa = valorPorPessoaEmCentavos / 100.0;
```

---

### 4. Division by Fixed Number (3)
**Severity**: 🟡 MEDIUM  
**Location**: `lib/core/engine/finance_engine.dart:85`

**Issue**:
```dart
final valorPorPessoa = d.valor / 3;  // Hard-coded divisor
```

**Impact**:
- Assumes exactly 3 people always
- Breaks if household size changes
- Inconsistent with dynamic `pessoas.length`

**Recommendation**:
```dart
final valorPorPessoa = d.valor / pessoas.length;
```

---

### 5. No Input Validation
**Severity**: 🟠 MEDIUM-HIGH  
**Location**: Forms throughout the app

**Issue**:
- No validation for negative values
- No validation for future dates
- No validation for empty required fields
- No max/min value constraints

**Impact**:
- Users can enter invalid data
- Database may accept nonsensical values
- Calculations may produce unexpected results

**Recommendation**:
- Add form validators to all input fields
- Validate before sending to Supabase
- Show clear error messages

---

### 6. Missing Error Handling
**Severity**: 🟠 MEDIUM-HIGH  
**Location**: Throughout the codebase

**Issue**:
```dart
// Example from main.dart - no error handling
await Supabase.initialize(
  url: dotenv.env['SUPABASE_URL'] ?? '',
  anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
);
```

**Impact**:
- Silent failures when Supabase is unavailable
- Poor user experience on network errors
- Difficult debugging in production

**Recommendation**:
```dart
try {
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
  );
} catch (e) {
  // Show error screen or retry option
  log('Failed to initialize Supabase: $e');
}
```

---

## Performance Concerns

### 7. IndexedStack Keeps All Screens in Memory
**Severity**: 🟢 LOW-MEDIUM  
**Location**: `lib/main.dart:102`

**Issue**:
```dart
body: IndexedStack(
  index: _aba,
  children: const [
    LedgerScreen(),
    ArchiveScreen(),
  ],
),
```

**Impact**:
- Both screens remain in memory even when not visible
- May cause memory issues with large datasets
- Unnecessary resource usage

**Recommendation**:
- Consider using `PageView` with lazy loading
- Or implement manual state management to dispose unused screens
- Monitor memory usage in production

---

### 8. No Pagination for Large Lists
**Severity**: 🟢 LOW-MEDIUM  
**Location**: Expense/card lists

**Issue**:
- All expenses loaded at once
- No limit on number of items fetched
- Could become slow with hundreds of transactions

**Impact**:
- Slow initial load times
- High memory usage
- Poor performance on low-end devices

**Recommendation**:
- Implement pagination (load 50 items at a time)
- Add infinite scroll
- Use Supabase range queries

```dart
final response = await supabase
  .from('despesas')
  .select()
  .range(offset, offset + 50);
```

---

### 9. Single-Pass Engine Re-runs on Every Change
**Severity**: 🟢 LOW  
**Location**: `lib/core/engine/finance_engine.dart:43`

**Issue**:
```dart
final diviEngineProvider = Provider<FinanceState>((ref) {
  final despesasAsync = ref.watch(despesasProvider);
  final pagamentosAsync = ref.watch(pagamentosProvider);
  final comprasAsync = ref.watch(cartaoProvider);
  // Recalculates EVERY time any provider changes
});
```

**Impact**:
- Full recalculation even for unrelated changes
- Wasted computation
- May cause UI jank on large datasets

**Recommendation**:
- Use selective watching with `.select()`
- Memoize expensive calculations
- Consider incremental updates

---

## Architecture Concernes

### 10. Empty Supabase Directory
**Severity**: 🟢 LOW  
**Location**: `lib/core/supabase/` (empty)

**Issue**:
- Directory exists but contains no files
- Unclear if Supabase client should be centralized here
- Inconsistent architecture

**Recommendation**:
- Either remove empty directory
- Or create centralized Supabase service:
```dart
// lib/core/supabase/supabase_service.dart
class SupabaseService {
  static SupabaseClient get client => Supabase.instance.client;
  
  Future<List<Despesa>> fetchExpenses(int month, int year) async {
    // Centralized data access
  }
}
```

---

### 11. Mixed Portuguese/English Naming
**Severity**: 🟢 LOW  
**Location**: Throughout codebase

**Issue**:
```dart
// Portuguese
class Despesa, Pagamento, CompraCartao
const pessoas, mesesAbrev

// English
FinanceEngine, LedgerScreen, ArchiveScreen
providers, models, widgets
```

**Impact**:
- Inconsistent code style
- Confusing for new developers
- Makes code search harder

**Recommendation**:
- Choose one language (recommend English for code, Portuguese for UI strings)
- Be consistent across entire codebase
- Document the decision

---

### 12. No Environment Separation
**Severity**: 🟡 MEDIUM  
**Location**: `.env` file

**Issue**:
```
SUPABASE_URL=https://rrihdmbvzsckguvqpmkh.supabase.co
SUPABASE_ANON_KEY=sb_publishable_ns5mvViZb-uGHKfd7q3U_g_vhO2gF9M
```

**Impact**:
- Same credentials for development and production
- Risk of accidentally using prod data in dev
- No staging environment

**Recommendation**:
- Create separate environments:
  - `.env.development`
  - `.env.staging`
  - `.env.production`
- Use different Supabase projects per environment
- Load appropriate file based on build mode

---

## Security Concerns

### 13. API Keys Committed to Repository
**Severity**: 🟡 MEDIUM  
**Location**: `.env` file

**Issue**:
- While `.env` is in `.gitignore`, there's risk of accidental commit
- Supabase anon key is exposed in client-side code anyway (by design)
- But service_role key would be catastrophic if leaked

**Impact**:
- Anon key exposure allows anyone to query your database
- Without RLS, this is a major vulnerability

**Recommendation**:
- Never commit `.env` files
- Use Supabase dashboard to rotate keys if compromised
- Implement RLS ASAP
- Consider using environment-specific keys

---

### 14. No Rate Limiting
**Severity**: 🟢 LOW  
**Location**: Supabase configuration

**Issue**:
- No apparent rate limiting on API calls
- Users could spam requests
- Potential for abuse

**Impact**:
- Increased Supabase costs
- Potential denial of service
- Database performance degradation

**Recommendation**:
- Configure Supabase rate limits
- Implement client-side throttling
- Add debounce to search/filter operations

---

## Maintainability Concerns

### 15. Minimal Test Coverage
**Severity**: 🟠 MEDIUM-HIGH  
**Location**: `test/widget_test.dart` (only 1 test)

**Issue**:
- Only 1 basic widget test exists
- No unit tests for business logic
- No integration tests
- No CI/CD pipeline

**Impact**:
- High risk of regressions
- Difficult to refactor safely
- Manual testing required for every change

**Recommendation**:
- Add unit tests for `FinanceEngine` (critical!)
- Add widget tests for shared components
- Set up GitHub Actions for automated testing
- Aim for 70%+ code coverage

---

### 16. No Documentation
**Severity**: 🟢 LOW  
**Location**: Project-wide

**Issue**:
- README is Flutter default template
- No API documentation
- No architecture decision records (ADRs)
- No contributing guidelines

**Impact**:
- Difficult onboarding for new developers
- Knowledge silos
- Inconsistent implementation patterns

**Recommendation**:
- Update README with project overview
- Add doc comments to public APIs
- Create CONTRIBUTING.md
- Document architectural decisions

---

### 17. Magic Numbers
**Severity**: 🟢 LOW  
**Location**: Various files

**Issue**:
```dart
final valorPorPessoa = d.valor / 3;  // Why 3?
Color(0xFF3b82f6)  // What color is this?
```

**Impact**:
- Unclear intent
- Hard to maintain
- Easy to introduce bugs

**Recommendation**:
```dart
const int numberOfPeople = 3;
final valorPorPessoa = d.valor / numberOfPeople;

const kPersonColors = {
  'Luan': kBlue,
  'Luciana': kPink,
  'Giovanna': kPurple,
};
```

---

## Deployment Concerns

### 18. No CI/CD Pipeline
**Severity**: 🟡 MEDIUM  
**Location**: No `.github/workflows/` or similar

**Issue**:
- No automated testing
- No automated builds
- No deployment automation
- Manual release process

**Impact**:
- Slow release cycles
- Human error in deployments
- No quality gates

**Recommendation**:
- Set up GitHub Actions or similar
- Automate testing on PR
- Automate builds and deployments
- Add version tagging

---

### 19. No Analytics or Crash Reporting
**Severity**: 🟢 LOW  
**Location**: Project-wide

**Issue**:
- No error tracking (Sentry, Crashlytics)
- No usage analytics
- No performance monitoring

**Impact**:
- Blind to production issues
- No user behavior insights
- Difficult to prioritize improvements

**Recommendation**:
- Add Sentry or Firebase Crashlytics
- Add privacy-friendly analytics (Plausible, PostHog)
- Monitor key metrics

---

## Data Integrity Concerns

### 20. No Data Backup Strategy
**Severity**: 🟡 MEDIUM  
**Location**: Supabase configuration

**Issue**:
- No apparent backup strategy
- Relying solely on Supabase's built-in backups
- No local data export feature

**Impact**:
- Risk of data loss
- Difficult migration if needed
- No offline capability

**Recommendation**:
- Enable Supabase automated backups
- Implement data export feature
- Consider local caching with Hive or SQLite

---

### 21. No Data Validation at Database Level
**Severity**: 🟢 LOW-MEDIUM  
**Location**: Database schema

**Issue**:
```sql
-- From migrations: minimal constraints
valor DOUBLE PRECISION NOT NULL,
dia_vencimento INTEGER NOT NULL,
```

**Impact**:
- Database accepts invalid data
- Negative values possible
- No referential integrity checks

**Recommendation**:
```sql
ALTER TABLE despesas 
ADD CONSTRAINT positive_valor CHECK (valor > 0);

ALTER TABLE despesas 
ADD CONSTRAINT valid_dia CHECK (dia_vencimento BETWEEN 1 AND 31);
```

---

## Summary

### High Priority (Fix Before Production)
1. 🔴 Re-enable RLS with proper policies
2. 🟠 Add comprehensive error handling
3. 🟠 Implement input validation
4. 🟠 Add unit tests for FinanceEngine

### Medium Priority (Next Sprint)
5. 🟡 Move person names to database
6. 🟡 Fix floating point arithmetic
7. 🟡 Separate environments (dev/staging/prod)
8. 🟡 Set up CI/CD pipeline
9. 🟡 Add form validation

### Low Priority (Technical Debt)
10. 🟢 Improve naming consistency
11. 🟢 Add pagination
12. 🟢 Optimize engine recalculations
13. 🟢 Add documentation
14. 🟢 Implement analytics/crash reporting
15. 🟢 Add database constraints
