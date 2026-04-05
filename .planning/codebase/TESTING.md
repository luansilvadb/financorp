# Testing Strategy - Divi

## Current State

### Test Coverage
- **Minimal**: Only one basic widget test exists
- **Location**: `test/widget_test.dart`
- **Coverage**: App renders correctly with ProviderScope

### Existing Tests
```dart
// test/widget_test.dart
testWidgets('App should render', (WidgetTester tester) async {
  await tester.pumpWidget(const ProviderScope(child: CasaApp()));
  expect(find.text('DIVI'), findsOneWidget);
});
```

## Testing Framework

### Primary Framework
- **flutter_test**: Official Flutter testing framework
- **Integration**: Built into Flutter SDK

### Dependencies
```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
```

## Test Structure

### Directory Layout
```
test/
└── widget_test.dart          # Basic smoke test
```

### Recommended Structure
```
test/
├── core/
│   └── engine/
│       └── finance_engine_test.dart      # Unit tests for business logic
├── features/
│   └── finance/
│       ├── providers/
│       │   └── expense_provider_test.dart # Provider tests
│       └── views/
│           ├── ledger_screen_test.dart    # Widget tests
│           └── archive_screen_test.dart   # Widget tests
├── shared/
│   ├── models/
│   │   ├── despesa_test.dart              # Model serialization tests
│   │   └── pagamento_test.dart            # Model tests
│   └── widgets/
│       ├── card_skeleton_test.dart        # Widget component tests
│       └── divi_avatar_test.dart          # Widget tests
└── integration/
    └── app_flow_test.dart                 # Integration tests
```

## Test Types

### 1. Unit Tests
**Purpose**: Test individual functions, classes, and business logic in isolation.

**Priority Targets**:
- `lib/core/engine/finance_engine.dart` - Financial calculations
- Utility functions in `lib/core/utils/`
- Pure functions without UI dependencies

**Example** (not yet implemented):
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:divi/core/engine/finance_engine.dart';
import 'package:divi/shared/models/despesa.dart';

void main() {
  group('FinanceEngine', () {
    test('calculates total expenses correctly', () {
      final engine = FinanceEngine();
      final expenses = [
        Despesa(nome: 'Rent', diaVencimento: 10, valor: 1000),
        Despesa(nome: 'Internet', diaVencimento: 15, valor: 100),
      ];
      
      final total = engine.calculateTotal(expenses);
      
      expect(total, equals(1100.0));
    });
    
    test('handles empty expense list', () {
      final engine = FinanceEngine();
      final total = engine.calculateTotal([]);
      
      expect(total, equals(0.0));
    });
  });
}
```

### 2. Widget Tests
**Purpose**: Test UI components in isolation with mocked state.

**Priority Targets**:
- Reusable widgets in `lib/shared/widgets/`
- Feature-specific widgets in `lib/features/*/views/widgets/`
- Screen layouts

**Example** (not yet implemented):
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:divi/shared/widgets/divi_avatar.dart';

void main() {
  testWidgets('DiviAvatar displays initials', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: DiviAvatar(name: 'Luan'),
        ),
      ),
    );
    
    expect(find.text('L'), findsOneWidget);
  });
  
  testWidgets('DiviAvatar shows correct color', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: DiviAvatar(name: 'Luan'),
        ),
      ),
    );
    
    final avatar = tester.widget<Container>(find.byType(Container));
    // Assert color matches expected value
  });
}
```

### 3. Provider Tests
**Purpose**: Test Riverpod providers and notifiers.

**Priority Targets**:
- `lib/shared/providers/month_year_provider.dart`
- Feature providers in `lib/features/*/providers/`

**Example** (not yet implemented):
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:divi/shared/providers/month_year_provider.dart';

void main() {
  test('PeriodNotifier initializes to current month', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    
    final period = container.read(periodProvider);
    
    final now = DateTime.now();
    expect(period.month, equals(now.month));
    expect(period.year, equals(now.year));
  });
  
  test('PeriodNotifier updates correctly', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    
    container.read(periodProvider.notifier).setPeriod(6, 2024);
    
    final period = container.read(periodProvider);
    expect(period.month, equals(6));
    expect(period.year, equals(2024));
  });
}
```

### 4. Model Tests
**Purpose**: Test JSON serialization/deserialization.

**Priority Targets**:
- All Freezed models in `lib/shared/models/`

**Example** (not yet implemented):
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:divi/shared/models/despesa.dart';

void main() {
  group('Despesa', () {
    test('serializes to JSON correctly', () {
      final despesa = Despesa(
        id: '123',
        nome: 'Aluguel',
        diaVencimento: 10,
        valor: 1000.0,
      );
      
      final json = despesa.toJson();
      
      expect(json['id'], equals('123'));
      expect(json['nome'], equals('Aluguel'));
      expect(json['dia_vencimento'], equals(10));
      expect(json['valor'], equals(1000.0));
    });
    
    test('deserializes from JSON correctly', () {
      final json = {
        'id': '123',
        'nome': 'Aluguel',
        'dia_vencimento': 10,
        'valor': 1000.0,
      };
      
      final despesa = Despesa.fromJson(json);
      
      expect(despesa.id, equals('123'));
      expect(despesa.nome, equals('Aluguel'));
      expect(despesa.diaVencimento, equals(10));
      expect(despesa.valor, equals(1000.0));
    });
    
    test('copyWith creates new instance', () {
      final original = Despesa(
        nome: 'Aluguel',
        diaVencimento: 10,
        valor: 1000.0,
      );
      
      final updated = original.copyWith(valor: 1200.0);
      
      expect(original.valor, equals(1000.0)); // Original unchanged
      expect(updated.valor, equals(1200.0));  // New value
      expect(updated.nome, equals('Aluguel')); // Other fields preserved
    });
  });
}
```

### 5. Integration Tests
**Purpose**: Test complete user flows across multiple screens.

**Priority Flows**:
1. Add expense → View in ledger → Archive period
2. Mark payment as paid → Verify status update
3. Navigate between tabs → State persistence

**Example** (not yet implemented):
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:divi/main.dart';

void main() {
  testWidgets('User can navigate between tabs', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: CasaApp()));
    await tester.pumpAndSettle();
    
    // Should start on Ledger tab
    expect(find.text('Ledger'), findsOneWidget);
    
    // Tap Archive tab
    await tester.tap(find.text('Arquivo'));
    await tester.pumpAndSettle();
    
    expect(find.text('Archive'), findsOneWidget);
  });
}
```

## Mocking Strategy

### Supabase Mocking
```dart
// Use mocktail or mockito for Supabase client
import 'package:mocktail/mocktail.dart';

class MockSupabaseClient extends Mock implements SupabaseClient {}

// In tests
final mockClient = MockSupabaseClient();
when(() => mockClient.from('despesas').select())
    .thenAnswer((_) async => []);
```

### Provider Mocking
```dart
// Override providers in tests
await tester.pumpWidget(
  ProviderScope(
    overrides: [
      expensesProvider.overrideWith(() => MockExpensesNotifier()),
    ],
    child: MyApp(),
  ),
);
```

## Running Tests

### Run All Tests
```bash
cd divi
flutter test
```

### Run Specific Test File
```bash
flutter test test/core/engine/finance_engine_test.dart
```

### Run with Coverage
```bash
flutter test --coverage
# View coverage report
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### Watch Mode
```bash
# Run tests automatically on file changes
flutter test --watch
```

## Test Best Practices

### Arrange-Act-Assert Pattern
```dart
test('calculates total correctly', () {
  // Arrange
  final engine = FinanceEngine();
  final expenses = [/* ... */];
  
  // Act
  final total = engine.calculateTotal(expenses);
  
  // Assert
  expect(total, equals(1100.0));
});
```

### Descriptive Test Names
```dart
// Good
test('returns zero when expense list is empty', () { });

// Bad
test('test1', () { });
```

### Test Independence
```dart
// Each test should be independent and not rely on other tests
// Use setUp() for common setup
setUp(() {
  // Reset state before each test
});
```

### Avoid Hard-Coded Values
```dart
// Use constants or helper functions
const testExpense = Despesa(
  nome: 'Test Expense',
  diaVencimento: 15,
  valor: 100.0,
);
```

## Continuous Integration

### Recommended CI Pipeline
```yaml
# .github/workflows/test.yml (example)
name: Tests
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter analyze
      - run: flutter test
```

## Testing Gaps & Recommendations

### Critical Gaps
1. ❌ **No unit tests** for `FinanceEngine` (core business logic)
2. ❌ **No widget tests** for any UI components
3. ❌ **No provider tests** for state management
4. ❌ **No model tests** for JSON serialization
5. ❌ **No integration tests** for user flows

### Priority Actions
1. **High Priority**: Add unit tests for `FinanceEngine`
   - Test all calculation methods
   - Test edge cases (empty lists, null values)
   
2. **Medium Priority**: Add widget tests for shared widgets
   - `CardSkeleton`, `DiviAvatar`, `PersonSummaryRow`
   
3. **Medium Priority**: Add model serialization tests
   - Ensure Freezed models serialize/deserialize correctly
   
4. **Low Priority**: Add integration tests
   - Test critical user journeys end-to-end

### Target Coverage
- **Unit Tests**: 80%+ for business logic
- **Widget Tests**: 60%+ for UI components
- **Integration Tests**: Cover 3-5 critical user flows
- **Overall**: Aim for 70%+ code coverage

## Database Testing

### Supabase Migrations
```sql
-- Test migrations manually before deploying
-- Location: supabase/migrations/

-- Example: Test schema creation
SELECT * FROM despesas;
SELECT * FROM pagamentos;
SELECT * FROM compras_cartao;
```

### RLS Policies
Currently disabled for testing (`supabase/migrations/20260305044257_disable_rls_for_testing.sql`)

**Recommendation**: 
- Re-enable RLS for production
- Add tests for RLS policies
- Test with different user roles
