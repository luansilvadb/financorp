# Coding Conventions - Divi

## Code Style

### Formatting
- **Standard Dart formatting** via `dart format`
- **Line length**: Default 80 characters (Flutter standard)
- **Indentation**: 2 spaces (Dart convention)
- **Trailing commas**: Used in multi-line collections and widget constructors

### Linting
- **Ruleset**: `flutter_lints` ^4.0.0
- **Configuration**: `analysis_options.yaml`
- **Strictness**: Recommended Flutter lints enabled

## Naming Conventions

### Files
```dart
// snake_case for all files
lib/features/finance/views/ledger_screen.dart
lib/shared/models/despesa.dart
lib/core/engine/finance_engine.dart
```

### Classes & Widgets
```dart
// PascalCase for classes
class LedgerScreen extends ConsumerStatefulWidget {}
class FinanceEngine {}
class PaperBottomNav extends StatelessWidget {}

// Suffix patterns
*Screen      // Full page screens
*Widget      // Reusable widgets (or descriptive name)
*Provider    // Riverpod providers
*Notifier    // Riverpod notifiers
*Engine      // Business logic engines
*Model       // Data models (or just entity name)
```

### Variables & Functions
```dart
// camelCase
int currentMonth = 5;
String userName = "Luan";

void calculateTotal() { }
Future<void> fetchExpenses() async { }

// Private members with underscore
int _counter = 0;
void _updateState() { }
```

### Constants
```dart
// camelCase with 'k' prefix
const kPrimaryColor = Color(0xFFE63819);
const kPaper = Color(0xFFF4F1EA);
const kInk = Color(0xFF2C2C2C);
```

### Collections
```dart
// camelCase, plural for lists/maps
const pessoas = ["Luan", "Luciana", "Giovanna"];
const mesesAbrev = ["Jan", "Fev", "Mar"];
const coresPessoa = {"Luan": Color(0xFF3b82f6)};
```

## Type Annotations

### Explicit Types
```dart
// Use explicit types for public APIs
String getUserName() => "Luan";
List<Despesa> getExpenses() => [];

// Type inference acceptable for local variables
final total = calculateTotal(); // Inferred as double
```

### Required vs Optional Parameters
```dart
// Required positional parameters for essential data
const factory Despesa({
  required String nome,
  @JsonKey(name: 'dia_vencimento') required int diaVencimento,
  required double valor,
}) = _Despesa;

// Optional named parameters for optional data
String? id, // Nullable and optional
```

## Error Handling

### Try-Catch Pattern
```dart
try {
  await supabase.from('despesas').insert(data);
} catch (e) {
  // Log error and show user feedback
  scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(content: Text('Erro: $e')),
  );
}
```

### Async Error Handling
```dart
// Use AsyncValue for Riverpod providers
final expensesProvider = AsyncNotifierProvider<ExpensesNotifier, List<Despesa>>(
  ExpensesNotifier.new,
);

// Handle loading/error states in UI
ref.watch(expensesProvider).when(
  data: (expenses) => ExpenseList(expenses),
  loading: () => CircularProgressIndicator(),
  error: (error, stack) => ErrorWidget(error),
);
```

### Null Safety
```dart
// Strict null safety enforced
String? nullableString; // Can be null
String nonNullable = "default"; // Cannot be null

// Null-aware operators
final length = nullableString?.length ?? 0;
nullableString ??= "fallback value";
```

## Widget Patterns

### Stateless vs Stateful
```dart
// Prefer StatelessWidget when possible
class SimpleCard extends StatelessWidget {
  const SimpleCard({super.key}); // const constructor
  
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Use ConsumerStatefulWidget for Riverpod integration
class ExpenseScreen extends ConsumerStatefulWidget {
  const ExpenseScreen({super.key});
  
  @override
  ConsumerState<ExpenseScreen> createState() => _ExpenseScreenState();
}
```

### Widget Composition
```dart
// Break down large widgets into smaller components
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Column(
      children: [
        _buildHeader(),      // Extracted method
        _buildSummaryCard(), // Extracted method
        _buildExpenseList(), // Extracted method
      ],
    ),
  );
}
```

### Keys
```dart
// Always pass key to super constructor
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});
}

// Use ValueKey for list items
ListView.builder(
  itemBuilder: (context, index) {
    return ExpenseCard(
      key: ValueKey(expenses[index].id),
      expense: expenses[index],
    );
  },
);
```

## State Management (Riverpod)

### Provider Definitions
```dart
// Global providers in lib/shared/providers/
final periodProvider = StateNotifierProvider<PeriodNotifier, Period>(
  PeriodNotifier.new,
);

// Feature-specific providers in lib/features/*/providers/
final expensesProvider = AsyncNotifierProvider<ExpensesNotifier, List<Despesa>>(
  ExpensesNotifier.new,
);
```

### Notifier Pattern
```dart
class ExpensesNotifier extends AsyncNotifier<List<Despesa>> {
  @override
  Future<List<Despesa>> build() async {
    return _fetchExpenses();
  }
  
  Future<void> addExpense(Despesa expense) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await supabase.from('despesas').insert(expense.toJson());
      return _fetchExpenses();
    });
  }
}
```

### Reading Providers
```dart
// In ConsumerWidget
class ExpenseList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final period = ref.watch(periodProvider);
    final expenses = ref.watch(expensesProvider);
    
    return ListView(...);
  }
}

// In ConsumerStatefulWidget
class ExpenseScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends ConsumerState<ExpenseScreen> {
  void _addExpense() {
    ref.read(expensesProvider.notifier).addExpense(newExpense);
  }
}
```

## Data Modeling (Freezed)

### Model Definition
```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'despesa.freezed.dart';
part 'despesa.g.dart';

@freezed
class Despesa with _$Despesa {
  @JsonSerializable(includeIfNull: false)
  const factory Despesa({
    String? id,
    required String nome,
    @JsonKey(name: 'dia_vencimento') required int diaVencimento,
    required double valor,
  }) = _Despesa;

  factory Despesa.fromJson(Map<String, dynamic> json) =>
      _$DespesaFromJson(json);
}
```

### JSON Serialization
```dart
// Custom field names with @JsonKey
@JsonKey(name: 'dia_vencimento') required int diaVencimento,

// Exclude null values
@JsonSerializable(includeIfNull: false)

// Generated code must be rebuilt after changes
// Run: flutter pub run build_runner build --delete-conflicting-outputs
```

### Immutability
```dart
// Freezed models are immutable by default
final expense = Despesa(nome: "Aluguel", diaVencimento: 10, valor: 1000);

// Use copyWith for modifications
final updated = expense.copyWith(valor: 1200);

// Original expense is unchanged
print(expense.valor); // 1000
print(updated.valor); // 1200
```

## Import Organization

### Import Order
```dart
// 1. Dart SDK imports
import 'dart:async';

// 2. Flutter framework imports
import 'package:flutter/material.dart';

// 3. Third-party package imports
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// 4. Relative imports (own project)
import '../models/despesa.dart';
import '../../shared/widgets/card_skeleton.dart';
```

### Import Style
```dart
// Use relative imports within lib/
import '../providers/expense_provider.dart';
import '../../shared/constants.dart';

// Avoid absolute imports from package: unless necessary
// Good: import '../models/despesa.dart';
// Avoid: import 'package:divi/models/despesa.dart';
```

## Documentation

### Doc Comments
```dart
/// Calculates the total expenses for a given period.
///
/// Returns the sum of all active expenses in the specified month/year.
double calculateTotalExpenses(int month, int year) {
  // Implementation
}
```

### Inline Comments
```dart
// Use sparingly - prefer self-documenting code

// TODO: Implement pagination for large lists
// FIXME: Handle edge case when list is empty
// HACK: Temporary workaround until API supports filtering
// NOTE: This value comes from Supabase RLS policy
```

## Testing Conventions

### Test File Naming
```dart
// Mirror source structure in test/
lib/features/finance/views/ledger_screen.dart
→ test/features/finance/views/ledger_screen_test.dart
```

### Test Structure
```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FinanceEngine', () {
    test('calculates total correctly', () {
      // Arrange
      final engine = FinanceEngine();
      
      // Act
      final total = engine.calculateTotal([expense1, expense2]);
      
      // Assert
      expect(total, equals(1500.0));
    });
  });
}
```

## Git Conventions

### Commit Messages
```bash
# Format: type: description
git commit -m "feat: add expense filtering by person"
git commit -m "fix: handle null values in expense calculation"
git commit -m "docs: update README with setup instructions"
git commit -m "refactor: extract expense card widget"
git commit -m "test: add unit tests for finance engine"
```

### Branch Naming
```bash
# Format: type/description
git checkout -b feat/expense-filtering
git checkout -b fix/null-handling
git checkout -b refactor/extract-widgets
```

## Build & Code Generation

### Freezed + JSON Serializable
```bash
# After modifying models with @freezed or @JsonSerializable
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode during development
flutter pub run build_runner watch --delete-conflicting-outputs
```

### Generated Files
```
*.freezed.dart  # Freezed generated code (immutable models, union types)
*.g.dart        # JSON serialization generated code

# These files should NOT be edited manually
# They are regenerated on each build_runner execution
```

## Performance Best Practices

### Widget Rebuilding
```dart
// Use const constructors where possible
const CardSkeleton()

// Use selective watching with Riverpod
final name = ref.watch(userProvider.select((u) => u.name));

// Avoid rebuilding entire lists
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return ItemCard(key: ValueKey(items[index].id), item: items[index]);
  },
);
```

### Async Operations
```dart
// Use AsyncValue.guard for safe async operations
state = await AsyncValue.guard(() async {
  return await fetchData();
});

// Avoid blocking the UI thread
await compute(expensiveCalculation, data);
```

## Security Best Practices

### Environment Variables
```dart
// Load from .env file (not hardcoded)
await dotenv.load(fileName: ".env");
final supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';

// NEVER commit .env to git (already in .gitignore)
```

### API Keys
```dart
// Use Supabase anon key (safe for client-side)
// Never use service_role key in client code
final anonKey = dotenv.env['SUPABASE_ANON_KEY'] ?? '';
```
