# System Patterns

## Architecture: Modular Feature-First
O sistema evoluiu de um arquivo único para uma arquitetura modular moderna e escalável, baseada em funcionalidades e separação de preocupações.

### Estrutura de Pastas
- `lib/core/`: Utilitários globais, constantes de design e formatações.
- `lib/shared/`: Modelos de dados e provedores compartilhados (ex: período global).
- `lib/features/`: Módulos de negócio.
  - `finance/`: Gestão de despesas e resumo geral.
  - `cartao/`: Gestão de compras no cartão.
  - Cada feature contém subpastas `data/` (serviços/repositórios), `providers/` (logica de estado) e `views/` (widgets).
  - `views/widgets/`: Widgets reutilizáveis e isolados (ex: `DespesaCard`, `CartaoCard`, `AddExpenseSheet`).

### State Management: Riverpod
Utilizamos **Flutter Riverpod** para toda a gestão de estado.
- **Providers Assíncronos**: `AsyncNotifierProvider` para dados do Supabase (`despesasProvider`, `cartaoProvider`).
- **Estado Global de Filtro**: `periodProvider` gerencia o mês/ano selecionado, injetando essa dependência nos outros provedores de dados.
- **Computed Providers**: `resumoProvider` calcula estatísticas em tempo real a partir de múltiplos providers de dados.
- **Seletividade via `.select()`**: Widgets que precisam apenas de uma fatia do estado (ex: mini-card de uma pessoa) usam `ref.watch(provider.select(...))` para evitar rebuilds desnecessários.

### Persistence: Supabase
Dados são persistidos em um banco relacional (PostgreSQL) via **Supabase**.
- **Repositories**: Classes pura-Dart em `data/` tratam a comunicação com as tabelas do Supabase.
- **RLS (Row Level Security)**: Políticas configuradas no banco para permitir acesso do app via role `anon`.

## Data Models

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

### `Pagamento` (Payment Tracker)
Novo modelo para rastrear pagamentos mensais de forma persistente.
```dart
@freezed
class Pagamento with _$Pagamento {
  const factory Pagamento({
    required String id,
    @JsonKey(name: 'despesa_id') required String despesaId,
    required String pessoa,
    required int mes,
    required int ano,
    required bool pago,
  }) = _Pagamento;

  factory Pagamento.fromJson(Map<String, dynamic> json) => _$PagamentoFromJson(json);
}
```

## Key Implementation Patterns

### Repository Pattern
Encapsulamento do cliente Supabase para isolar a lógica de rede da lógica de estado (Riverpod Notifiers).

### Optimistic UI (Zero-Latency Updates)
Em vez de depender de re-fetches da rede (`ref.invalidateSelf()`), todas as mutações (`add`, `update`, `delete`, `toggle`) atualizam primeiro o `state` local no Notifier e depois repassam o comando para o Supabase. 
Se o comando de rede falhar, o estado é revertido (`state = previousState`) e um erro é lançado para que a View capture e exiba uma `SnackBar` global através da `scaffoldMessengerKey`. Em adições (onde precisamos do UUID do DB), realiza-se o invalidade *após* o sucesso da rede, mantendo o item visível na lista imediatamente enquanto o sync ocorre em segundo plano.

### Global Month/Year Filter
O componente de cabeçalho no `HomeScreen` altera o `periodProvider`. Como os `Notifiers` de dados escutam esse provider (`ref.watch(periodProvider)`), toda a UI se atualiza automaticamente ao mudar o mês/ano.
- **Navegação Inteligente**: O `PeriodNotifier` centraliza a lógica de transição. Ao avançar de Dezembro, o ano é incrementado automaticamente. Ao retroceder de Janeiro, o ano é decrementado.
- **Ações Atômicas**: Fornece métodos como `nextMonth()`, `prevMonth()`, `nextYear()`, `prevYear()` e `resetToToday()`.
- **Destaque Visual**: O sistema identifica o "Mês Real" (calendário atual) através do método `isToday(mes)`, exibindo um indicador visual nas abas de navegação.

### High-Density Cards (Performance + UX)
As abas de listagem (`DespesasTab`, `CartaoTab`) são `ConsumerWidget` leves que delegam renderização de itens individuais a widgets compactos:
- **`DespesaCard`** (`ConsumerWidget`): Card de alta densidade sem estado local. Exibe nome, valor, dia de vencimento e status consolidado de pagamentos (X/3 pagos). Toque no corpo abre `DespesaDetailsSheet`; o ícone de status é puramente indicativo.
- **`CartaoCard`** (`ConsumerWidget`): Card de alta densidade com touch targets separados. Toque no corpo abre `CartaoDetailsSheet`; toque no ícone trailing alterna pagamento com `HapticFeedback.lightImpact()`.
- **`DespesaDetailsSheet`** (`ConsumerWidget`): Bottom Sheet com detalhes da despesa, status de pagamento por pessoa (toggleável) e botões de Editar/Excluir.
- **`CartaoDetailsSheet`** (`ConsumerWidget`): Bottom Sheet com detalhes da compra, botão de toggle pago/pendente e botões de Editar/Excluir.
- **`PersonSummaryRow`** (`StatelessWidget` pai + `_PersonMiniCard` `ConsumerWidget` filhos): Cada mini-card escuta `resumoProvider.select((res) => res["Nome"])`, reconstruindo apenas quando o extrato daquela pessoa mudar.

### Isolated Expense Views
A aba de `DespesasTab` foi refatorada para exibir exclusivamente os gastos compartilhados da casa (fundo comum). As compras de cartão de crédito são visualizadas apenas na aba `CartaoTab`. Isso reforça a separação lógica da Tesouraria Virtual e simplifica o acompanhamento das contas fixas.

### Consolidated Status Logic
O balanço de adimplência exibido nos mini-cards (`PersonSummaryRow`) consolida obrigações da "Casa" e dívidas do "Cartão". Um morador só é considerado "Em dia" se a soma de ambas as fatias for zero ou negativa (no caso do Luan, que possui créditos a receber). O cálculo do cartão filtra apenas itens não pagos (`!pago`), e separa estritamente dívidas a pagar (`pendenteCartao`) de valores a receber (`creditoCartao`).

### Form UX (Bottom Sheets)
Para melhorar a experiência em dispositivos móveis e liberar espaço visual nas abas, os formulários de entrada de dados (`AddExpenseSheet` e `AddPurchaseSheet`) são implementados como **Modal Bottom Sheets**.
- **Abertura**: Acionados via Floating Action Button (FAB).
- **Responsividade**: Utilizam `isScrollControlled: true` e `MediaQuery.of(context).viewInsets.bottom` para se ajustarem automaticamente à abertura do teclado virtual.
- **Fechamento**: O sheet é encerrado via `Navigator.pop(context)` imediatamente após a persistência bem-sucedida dos dados no Supabase.
- **Design**: Seguem o padrão visual com cantos arredondados no topo (`Radius.circular(32)`) e um indicador visual ("handle") centralizado.

### Currency Formatting (BRL)
- Mapeado no `core/utils/formatters.dart`.
- `BrlCurrencyInputFormatter`: Real-time mask para inputs monetários.
- `fmt()`: Formatação para exibição de valores (R$ 0,00).

## UI Design System (Tokens)
- **Typography**: Inter (via `google_fonts`)
- **Icon Library**: PhosphorIcons (via `phosphor_flutter`) — traço fino, estilo FinTech premium
  - Regular style para estados inativos/padrão
  - Fill style para estados ativos/selecionados
- **Primary Color**: `0xFF195de6` (Modern Blue)
- **Background**: `0xFFF6F6F8` (Light) / `0xFF111621` (Dark)
- **Person Colors**: Luan (`0xFF3b82f6`), Luciana (`0xFFec4899`), Giovanna (`0xFF8b5cf6`).
- **Avatars**: Imagens de perfil configuradas globalmente em `constants.dart`.

### PhosphorIcons Quick Reference
| Contexto | Ícone Regular | Ícone Fill |
|----------|---------------|------------|
| Header | `PhosphorIcons.bank` | — |
| Despesas (Nav) | `PhosphorIcons.receipt` | `PhosphorIcons.receipt(fill)` |
| Cartão (Nav) | `PhosphorIcons.creditCard` | `PhosphorIcons.creditCard(fill)` |
| Resumo (Nav) | `PhosphorIcons.chartBar` | `PhosphorIcons.chartBar(fill)` |
| FAB (Add) | `PhosphorIcons.plus(bold)` | — |
| Editar | `PhosphorIcons.pencilSimple` | — |
| Excluir | `PhosphorIcons.trash` | — |
| Pago (✅) | — | `PhosphorIcons.checkCircle(fill)` |
| Pendente (❌) | — | `PhosphorIcons.xCircle(fill)` / `warningCircle(fill)` |
| Pesquisa | `PhosphorIcons.magnifyingGlass` | — |
| Calendário | `PhosphorIcons.calendarBlank` | — |
| Setas Nav | `PhosphorIcons.caretLeft/Right(bold)` | — |
| Pessoa | `PhosphorIcons.user` | — |
| Valor | `PhosphorIcons.currencyDollar` | — |
| Refeição | `PhosphorIcons.forkKnife` | — |
| Cofre | `PhosphorIcons.piggyBank` | — |
| Info | `PhosphorIcons.info` | — |
| Desfazer | `PhosphorIcons.arrowCounterClockwise` | — |
| Dropdown | `PhosphorIcons.caretDown` | — |

## Component Hierarchy
```
CasaApp (MaterialApp + GoogleFonts.interTextTheme)
└── HomeScreen (ConsumerStatefulWidget)
    ├── _buildHeader() -> Header com periodProvider selectors (PhosphorIcons)
    └── IndexedStack (Aba selecionada)
        ├── DespesasTab (ConsumerWidget leve)
        │   ├── PersonSummaryRow (StatelessWidget)
        │   │   └── _PersonMiniCard × 3 (ConsumerWidget c/ .select())
        │   └── DespesaCard × N (ConsumerWidget compacto → tap abre DespesaDetailsSheet)
        ├── CartaoTab (ConsumerWidget leve)
        │   └── CartaoCard × N (ConsumerWidget compacto → tap abre CartaoDetailsSheet, trailing toggle)
        └── ResumoTab (Dashboard consolidado)
```
