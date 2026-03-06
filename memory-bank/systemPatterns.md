# System Patterns

## Architecture: Modular Feature-First
O sistema evoluiu de um arquivo único para uma arquitetura modular moderna e escalável, baseada em funcionalidades e separação de preocupações.

### Estrutura de Pastas
- `lib/core/`: Utilitários globais, motor de alta performance (`engine`) e formatações.
- `lib/shared/`: Modelos de dados e provedores compartilhados (ex: período global).
- `lib/features/`: Módulos de negócio.
  - `finance/`: Gestão de despesas e resumo geral.
  - `cartao/`: Gestão de compras no cartão.
  - Cada feature contém subpastas `data/` (serviços/repositórios), `providers/` (logica de estado) e `views/` (widgets).
  - `views/widgets/`: Widgets reutilizáveis e isolados (ex: `DespesaCard`, `CartaoCard`, `AddExpenseSheet`).

### State Management: Riverpod & DiviEngine
Utilizamos **Flutter Riverpod** acoplado ao motor unificado para alta performance.
- **Providers Assíncronos Base**: `AsyncNotifierProvider` cuidam da rede e Optimistic UI (`despesasProvider`, `cartaoProvider`).
- **Estado Global de Filtro**: `periodProvider` gerencia o mês/ano selecionado.
- **Motor Central (DiviEngine)**: O `diviEngineProvider` escuta todos os dados brutos e realiza um processamento **Single-Pass O(N)**. Ele gera os resumos agregados e indexa os itens (Despesas e Compras) em Mapas por UUID, retornando um grande Record densamente tipado.
- **Seletividade via `.select()` e O(1) Access**: Todos os widgets individuais consomem dados indexados buscando sua chave específica, ex: `ref.watch(diviEngineProvider.select((s) => s.despesas[id]))`. Isso isola os rebuilds cirurgicamente.

### Persistence: Supabase
Dados são persistidos em um banco relacional (PostgreSQL) via **Supabase**.
- **Repositories**: Classes pura-Dart em `data/` tratam a comunicação com as tabelas do Supabase.
- **RLS (Row Level Security)**: Políticas configuradas no banco para permitir acesso do app via role `anon`.

## Data Models (Core)

### `Despesa` (Fixed Expense)
```dart
@freezed
class Despesa with _$Despesa {
  const factory Despesa({
    String? id,
    required String nome,
    @JsonKey(name: 'dia_vencimento') required int diaVencimento,
    required double valor,
  }) = _Despesa;

  factory Despesa.fromJson(Map<String, dynamic> json) => _$DespesaFromJson(json);
}
```

### `CompraCartao` (Credit Card Purchase)
```dart
@freezed
class CompraCartao with _$CompraCartao {
  const factory CompraCartao({
    String? id,
    required String data,
    required String descricao,
    required double valor,
    required String pessoa,
    required int mes,
    required int ano,
    @Default(false) bool pago,
  }) = _CompraCartao;

  factory CompraCartao.fromJson(Map<String, dynamic> json) => _$CompraCartaoFromJson(json);
}
```

### UI View Models (Dart 3 Records)
Para abstrair os dados consumidos pela interface sem criar classes `freezed` efêmeras (reduzindo memory overhead e tempo de build), o motor fornece os dados consolidados usando Records:
```dart
typedef DespesaItemRecord = ({
  Despesa despesa,
  int totalPagos,
  bool allPaid,
  bool luanPago,
  double valorPorPessoa,
});
```

## Key Implementation Patterns

### Repository Pattern
Encapsulamento do cliente Supabase para isolar a lógica de rede da lógica de estado (Riverpod Notifiers).

### Optimistic UI (Zero-Latency Updates)
Todas as mutações (`add`, `update`, `delete`, `toggle`) atualizam primeiro o `state` local no Notifier e depois repassam o comando para o Supabase. Se a rede falhar, o estado é revertido (`state = previousState`) e uma `SnackBar` global é ativada via `scaffoldMessengerKey`.

### DiviEngine (Motor de Alta Performance)
Remove a sobrecarga de cálculos repetitivos iterando sobre as faturas uma única vez (O(N)). Grupos (para a CartaoTab), Mapas (para os Cards O(1)) e o Balanço Final do Resumo (para o Dashboard) são montados na mesma passada e imutavelmente guardados em Records do Dart 3.

### High-Density Cards & Detail Sheets
As abas de listagem (`DespesasTab`, `CartaoTab`) são `ConsumerWidget` leves que mapeiam a lista de IDs para widgets filhos compactos. Toques no corpo dos cards não causam expansão em linha, mas invocam instâncias elegantes de `ModalBottomSheet` para exibição de detalhes e ações mais complexas.

### Consolidated Status Logic
O balanço de adimplência exibido nos mini-cards da `ResumoTab` consolida obrigações da "Casa" e dívidas do "Cartão". A matemática é unificada no `DiviEngine`, e o card apenas seleciona seu extrato `ref.watch(diviEngineProvider.select((s) => s.resumo[pessoa]))`.

### Form UX (Bottom Sheets)
Os formulários (`AddExpenseSheet` e `AddPurchaseSheet`) são Bottom Sheets responsivos com `isScrollControlled: true` para lidar dinamicamente com aberturas de teclado virtual (`viewInsets.bottom`).

## UI Design System (Tokens)
- **Typography**: Inter (via `google_fonts`)
- **Icon Library**: PhosphorIcons (via `phosphor_flutter`) — traço fino, estilo FinTech premium.
- **Primary Color**: `0xFF195de6` (Modern Blue)
- **Background**: `0xFFF6F6F8` (Light) / `0xFF111621` (Dark)
- **Person Colors**: Luan (`0xFF3b82f6`), Luciana (`0xFFec4899`), Giovanna (`0xFF8b5cf6`).

## Component Hierarchy
```
DIVI (MaterialApp + GoogleFonts.interTextTheme)
└── HomeScreen (ConsumerStatefulWidget)
    ├── _buildHeader() -> Header com periodProvider selectors (PhosphorIcons)
    └── IndexedStack (Aba selecionada)
        ├── DespesasTab (ConsumerWidget leve)
        │   ├── PersonSummaryRow (StatelessWidget)
        │   │   └── _PersonMiniCard × 3 (.select(resumo[pessoa]))
        │   └── DespesaCard × N (.select(despesas[id]) -> tap abre DespesaDetailsSheet)
        ├── CartaoTab (ConsumerWidget leve)
        │   └── CartaoCard × N (.select(compras[id]) -> tap abre CartaoDetailsSheet)
        └── ResumoTab (Dashboard consumindo totais do DiviEngine)
```