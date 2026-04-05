# Project Structure - Divi

## Root Directory Layout

```
financorp/
├── .qoder/                    # GSD (Get Shit Done) workflow configuration
│   ├── agents/                # Agent definitions
│   ├── get-shit-done/         # GSD workflows and templates
│   ├── skills/                # GSD command skills
│   └── settings.json          # GSD settings
├── divi/                      # Flutter application root
│   ├── android/               # Android platform code
│   ├── ios/                   # iOS platform code
│   ├── web/                   # Web platform code
│   ├── windows/               # Windows platform code
│   ├── linux/                 # Linux platform code
│   ├── macos/                 # macOS platform code
│   ├── lib/                   # Dart source code (main app)
│   ├── test/                  # Test files
│   ├── assets/                # Static assets (images, fonts)
│   ├── supabase/              # Supabase migrations and config
│   ├── build/                 # Build output (generated)
│   ├── pubspec.yaml           # Flutter dependencies
│   ├── analysis_options.yaml  # Linter rules
│   ├── .env                   # Environment variables (Supabase credentials)
│   └── README.md              # Project documentation
├── openspec/                  # OpenSpec change tracking
│   ├── changes/archive/       # Archived feature changes
│   └── specs/                 # Feature specifications
└── .gitignore                 # Git ignore rules
```

## Source Code Structure (`divi/lib/`)

### Top-Level Organization

```
lib/
├── main.dart                  # App entry point
├── core/                      # Core business logic and shared infrastructure
│   ├── engine/                # Business logic engines
│   │   └── finance_engine.dart    # Financial calculations engine
│   ├── supabase/              # Supabase client configuration (empty)
│   ├── utils/                 # Utility functions
│   └── views/                 # Core-level views
│       └── splash_screen.dart     # Splash/loading screen
├── features/                  # Feature modules (domain-driven)
│   ├── finance/               # Finance management feature
│   │   ├── data/              # Data layer (repositories, data sources)
│   │   ├── providers/         # Riverpod providers for finance
│   │   └── views/             # UI screens and widgets
│   │       ├── widgets/       # Finance-specific widgets
│   │       ├── ledger_screen.dart      # Main ledger screen
│   │       ├── archive_screen.dart     # Archive/history screen
│   │       ├── statement_screen.dart   # Detailed statement screen
│   │       ├── resumo_tab.dart         # Summary tab
│   │       └── despesas_tab.dart       # Expenses tab
│   └── cartao/                # Credit card feature
│       ├── data/              # Card data layer
│       ├── providers/         # Card providers
│       └── views/             # Card UI screens
└── shared/                    # Shared components across features
    ├── models/                # Data models (Freezed + JSON serializable)
    │   ├── despesa.dart              # Expense model
    │   ├── despesa.freezed.dart      # Generated Freezed code
    │   ├── despesa.g.dart            # Generated JSON serialization
    │   ├── compra_cartao.dart        # Card purchase model
    │   ├── compra_cartao.freezed.dart
    │   ├── compra_cartao.g.dart
    │   ├── pagamento.dart            # Payment model
    │   ├── pagamento.freezed.dart
    │   └── pagamento.g.dart
    ├── widgets/               # Reusable UI components
    │   ├── card_skeleton.dart        # Base card template
    │   ├── divi_avatar.dart          # Avatar component with initials
    │   ├── divi_toasts.dart          # Toast notifications
    │   ├── paper_background.dart     # Paper-textured background
    │   ├── paper_bottom_nav.dart     # Custom bottom navigation
    │   ├── person_summary_row.dart   # Person summary row widget
    │   ├── premium_bottom_nav.dart   # Premium-style bottom nav
    │   └── skeuomorphic.dart         # Skeuomorphic design components
    ├── providers/             # Global Riverpod providers
    │   └── month_year_provider.dart  # Period (month/year) state
    └── constants.dart         # Global constants (colors, strings)
```

## Key File Locations

### Configuration Files
- `divi/pubspec.yaml` - Dependencies and package metadata
- `divi/analysis_options.yaml` - Linting rules
- `divi/.env` - Environment variables (Supabase URL and key)
- `divi/nixpacks.toml` - Deployment configuration
- `.qoder/settings.json` - GSD workflow settings

### Entry Points
- `divi/lib/main.dart` - Application entry point
- `divi/web/index.html` - Web entry point
- `divi/android/app/src/main/kotlin/.../MainActivity.kt` - Android entry
- `divi/ios/Runner/AppDelegate.swift` - iOS entry

### Database Migrations
- `divi/supabase/migrations/` - SQL migration files
- `divi/supabase/config.toml` - Supabase CLI configuration

### Generated Files (Do Not Edit)
- `*.freezed.dart` - Freezed code generation output
- `*.g.dart` - JSON serializable code generation output
- `divi/build/` - Flutter build artifacts
- `divi/.flutter-plugins` - Flutter plugin registration

## Naming Conventions

### Files
- **snake_case** for all Dart files: `ledger_screen.dart`, `finance_engine.dart`
- **kebab-case** for directories: `bottom-nav` (if used)

### Classes/Widgets
- **PascalCase**: `LedgerScreen`, `FinanceEngine`, `PaperBottomNav`
- Suffix patterns:
  - `*Screen` - Full page screens
  - `*Widget` or specific name - Reusable widgets
  - `*Provider` or `*Notifier` - Riverpod providers
  - `*Model` - Data models (though often just the entity name)

### Variables/Functions
- **camelCase**: `currentPeriod`, `calculateTotal()`, `fetchExpenses()`
- Private members: `_privateMethod()`, `_internalState`

### Constants
- **camelCase** with `k` prefix: `kPrimaryColor`, `kInk`, `kPaper`
- Defined in `shared/constants.dart`

## Module Boundaries

### Feature Isolation
Each feature in `lib/features/` should be:
- Self-contained (own data, providers, views)
- Import from `shared/` but not from other features
- Minimally dependent on `core/` (only engines and utilities)

### Shared Components
`lib/shared/` contains:
- Models used across multiple features
- Widgets reused in different contexts
- Global providers (period selection, theme)
- Constants and utilities

### Core Layer
`lib/core/` provides:
- Business logic engines (feature-agnostic)
- Infrastructure setup (Supabase initialization)
- Core views (splash, error screens)

## Import Patterns

### Within Same Feature
```dart
import 'widgets/expense_card.dart';
import '../providers/expense_provider.dart';
```

### Cross-Module Imports
```dart
// From feature to shared
import '../../shared/models/despesa.dart';
import '../../shared/widgets/card_skeleton.dart';

// From feature to core
import '../../core/engine/finance_engine.dart';

// From main to features
import 'features/finance/views/ledger_screen.dart';
```

## Platform-Specific Directories

### Android (`divi/android/`)
- Gradle build configuration
- Native Android code (Kotlin/Java)
- AndroidManifest.xml
- Platform-specific permissions

### iOS (`divi/ios/`)
- Xcode project configuration
- Native iOS code (Swift/Objective-C)
- Info.plist
- Podfile for CocoaPods dependencies

### Web (`divi/web/`)
- `index.html` - HTML entry point
- `manifest.json` - PWA manifest
- `icons/` - Web app icons
- Service worker configuration

### Desktop Platforms
- `windows/` - Windows desktop (C++/Win32)
- `linux/` - Linux desktop (GTK)
- `macos/` - macOS desktop (Swift/AppKit)

## Build Artifacts (Ignored by Git)

- `divi/build/` - Compiled output
- `divi/.dart_tool/` - Dart tooling cache
- `divi/.flutter-plugins` - Plugin registration
- `divi/*.iml` - IDE module files
- Platform-specific generated files

## Documentation Structure

### OpenSpec Changes (`openspec/changes/archive/`)
Archived feature implementations with:
- Proposal documents
- Implementation notes
- Design decisions

### OpenSpec Specs (`openspec/specs/`)
Feature specifications:
- `consolidated-expense-list/` - Expense list spec
- `virtual-treasury/` - Virtual treasury spec
- `batch-payment-processing/` - Batch payments spec
- And others...

## Testing Structure

```
test/
└── widget_test.dart           # Basic widget test (template)
```

**Note**: Currently minimal test coverage. Recommended expansion:
- Unit tests for `finance_engine.dart`
- Widget tests for critical UI components
- Integration tests for user flows
