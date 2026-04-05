# Architecture - Divi

## Architectural Pattern

**Feature-First + Clean Architecture (Simplified)**

O projeto segue uma arquitetura híbrida que combina:
- **Feature-First Organization**: Código organizado por features/domínios de negócio
- **Layered Architecture**: Separação clara entre presentation, business logic e data layers
- **Reactive State Management**: Riverpod para gerenciamento de estado reativo

## Layers

### 1. Presentation Layer (`lib/features/*/views/`)
Widgets e screens responsáveis pela UI.

**Responsibilities**:
- Renderização de UI
- Captura de eventos do usuário
- Exibição de estado via providers
- Navegação entre telas

**Examples**:
- `lib/features/finance/views/ledger_screen.dart` - Tela principal de registro financeiro
- `lib/features/finance/views/archive_screen.dart` - Tela de arquivo/histórico
- `lib/features/finance/views/resumo_tab.dart` - Tab de resumo financeiro
- `lib/features/finance/views/despesas_tab.dart` - Tab de despesas

### 2. Business Logic Layer (`lib/core/engine/`, `lib/shared/providers/`)
Lógica de negócio e state management.

**Responsibilities**:
- Cálculos financeiros
- Transformação de dados
- Regras de negócio
- Estado global via Riverpod providers

**Examples**:
- `lib/core/engine/finance_engine.dart` - Motor de cálculos financeiros
- `lib/shared/providers/month_year_provider.dart` - Provider de período (mês/ano)

### 3. Data Layer (`lib/features/*/data/`, `lib/shared/models/`)
Modelos de dados e acesso a dados.

**Responsibilities**:
- Definição de modelos de domínio
- Serialização/deserialização JSON
- Interação com Supabase (via providers)
- Cache local (se aplicável)

**Examples**:
- `lib/shared/models/despesa.dart` - Modelo de despesa
- `lib/shared/models/compra_cartao.dart` - Modelo de compra no cartão
- `lib/shared/models/pagamento.dart` - Modelo de pagamento

## Core Modules

### Core Engine (`lib/core/engine/`)
Motor de processamento financeiro centralizado.

**Purpose**: 
- Centraliza lógica complexa de cálculos
- Processa transações financeiras
- Calcula saldos, totais e métricas

**Key File**: `finance_engine.dart`

### Core Views (`lib/core/views/`)
Views compartilhadas em nível de core.

**Examples**:
- `splash_screen.dart` - Tela de splash/inicialização

### Shared Components (`lib/shared/`)
Componentes reutilizáveis em todo o app.

**Subdirectories**:
- `models/` - Modelos de dados compartilhados
- `widgets/` - Widgets reutilizáveis
- `providers/` - Providers globais
- `constants.dart` - Constantes globais (cores, strings, etc.)

## Feature Modules

### Finance Feature (`lib/features/finance/`)
Módulo principal de gestão financeira.

**Structure**:
```
features/finance/
├── data/          # Data sources, repositories
├── providers/     # Feature-specific providers
└── views/         # Screens and widgets
    └── widgets/   # Feature-specific widgets
```

**Screens**:
- `LedgerScreen` - Registro financeiro principal (tabs: Resumo, Despesas)
- `ArchiveScreen` - Histórico/arquivo de períodos anteriores
- `StatementScreen` - Extrato detalhado

### Cartão Feature (`lib/features/cartao/`)
Módulo de gestão de compras no cartão de crédito.

**Structure**: Similar ao finance feature

## Navigation Architecture

**Pattern**: Bottom Navigation + IndexedStack

**Implementation**:
- `HomeScreen` gerencia navegação principal via `_aba` index
- `PaperBottomNav` - Custom bottom navigation bar
- `IndexedStack` mantém estado das tabs ao navegar
- FAB (Floating Action Button) abre modal para adicionar transações

**Routes**:
- Tab 0: `LedgerScreen` (Registro atual)
- Tab 1: `ArchiveScreen` (Arquivo/Histórico)
- FAB: `SpikeModalSheet` (Adicionar transação)

## State Management Pattern

**Riverpod Architecture**:

1. **Global Providers** (`lib/shared/providers/`)
   - `periodProvider` - Gerencia período selecionado (mês/ano)
   
2. **Feature Providers** (`lib/features/*/providers/`)
   - Providers específicos de cada feature
   
3. **Async Notifiers**
   - Providers assíncronos para operações com Supabase
   - Auto-refresh em mudanças de período

**State Flow**:
```
User Action → Event Handler → Provider Update → UI Rebuild
                    ↓
              Supabase Call
                    ↓
              Data Update
                    ↓
              Provider Refresh
```

## Data Flow

### Read Path:
```
Supabase Database
       ↓
Riverpod AsyncNotifier Provider
       ↓
Finance Engine (calculations)
       ↓
UI Widgets (ConsumerWidget)
```

### Write Path:
```
User Input (Form)
       ↓
Validation
       ↓
Supabase Insert/Update
       ↓
Provider Refresh
       ↓
UI Update
```

## Key Abstractions

### Models (Freezed)
Todos os modelos usam **Freezed** para:
- Immutabilidade
- Union types (sealed classes)
- Copy-with methods
- Equality operators automáticos

**Generated Files**:
- `.freezed.dart` - Código gerado pelo Freezed
- `.g.dart` - Código gerado pelo JSON Serializable

### Widgets Compartilhados

**Paper Theme**:
- `PaperBackground` - Background texturizado estilo papel
- `PaperBottomNav` - Bottom navigation customizada
- `CardSkeleton` - Template base para cards

**Design System**:
- Cores definidas em `shared/constants.dart`
- Tipografia via Google Fonts (Inter)
- Componentes skeuomórficos

## Entry Points

### Main Entry (`lib/main.dart`)
1. Inicializa Flutter binding
2. Carrega variáveis de ambiente (`.env`)
3. Inicializa Supabase client
4. Configura tema global (Google Fonts, cores)
5. Renderiza `SplashScreen` → `HomeScreen`

### Initialization Flow:
```
main()
  ↓
dotenv.load()
  ↓
Supabase.initialize()
  ↓
SplashScreen (loading state)
  ↓
HomeScreen (bottom nav)
```

## Error Handling

**Strategy**: 
- Toasts/notificações via `DiviToasts`
- ScaffoldMessenger para mensagens globais
- Try-catch em operações async com Supabase

## Testing Strategy

**Current State**: 
- Teste básico em `test/widget_test.dart`
- Framework: flutter_test

**Recommended** (não implementado ainda):
- Unit tests para Finance Engine
- Widget tests para componentes críticos
- Integration tests para fluxos principais
