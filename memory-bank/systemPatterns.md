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

### State Management: Riverpod
Utilizamos **Flutter Riverpod** para toda a gestão de estado.
- **Providers Assíncronos**: `AsyncNotifierProvider` para dados do Supabase (`despesasProvider`, `cartaoProvider`).
- **Estado Global de Filtro**: `periodProvider` gerencia o mês/ano selecionado, injetando essa dependência nos outros provedores de dados.
- **Computed Providers**: `resumoProvider` calcula estatísticas em tempo real a partir de múltiplos providers de dados.

### Persistence: Supabase
Dados são persistidos em um banco relacional (PostgreSQL) via **Supabase**.
- **Repositories**: Classes pura-Dart em `data/` tratam a comunicação com as tabelas do Supabase.
- **RLS (Row Level Security)**: Políticas configuradas no banco para permitir acesso do app via role `anon`.

## Data Models

### `Despesa` (Fixed Expense)
```dart
class Despesa {
  final String? id; // UUID gerado pelo servidor
  final String nome;
  final int diaVencimento;
  final double valor;
}
```

### `CompraCartao` (Credit Card Purchase)
```dart
class CompraCartao {
  final String? id; // UUID gerado pelo servidor
  final String data;
  final String descricao;
  final double valor;
  final String pessoa;
  final int mes;
  final int ano;
  final bool pago;
}
```

### `Pagamento` (Payment Tracker)
Novo modelo para rastrear pagamentos mensais de forma persistente.
```dart
class Pagamento {
  final String id; // ID composto: despesaId-pessoa-mes-ano
  final String despesaId;
  final String pessoa;
  final int mes;
  final int ano;
  final bool pago;
}
```

## Key Implementation Patterns

### Repository Pattern
Encapsulamento do cliente Supabase para isolar a lógica de rede da lógica de estado (Riverpod Notifiers).

### Reactive Synching
Quando uma despesa é alterada ou deletada, o provider correspondente usa `ref.invalidateSelf()` para forçar a atualização imediata dos dados do servidor, garantindo consistência visual.

### Global Month/Year Filter
O componente de cabeçalho no `HomeScreen` altera o `periodProvider`. Como os `Notifiers` de dados escutam esse provider (`ref.watch(periodProvider)`), toda a UI se atualiza automaticamente ao mudar o mês/ano.
- **Navegação Inteligente**: O `PeriodNotifier` centraliza a lógica de transição. Ao avançar de Dezembro, o ano é incrementado automaticamente. Ao retroceder de Janeiro, o ano é decrementado.
- **Ações Atômicas**: Fornece métodos como `nextMonth()`, `prevMonth()`, `nextYear()`, `prevYear()` e `resetToToday()`.
- **Destaque Visual**: O sistema identifica o "Mês Real" (calendário atual) através do método `isToday(mes)`, exibindo um indicador visual nas abas de navegação.

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
- **Typography**: Manrope
- **Primary Color**: `0xFF195de6` (Modern Blue)
- **Background**: `0xFFF6F6F8` (Light) / `0xFF111621` (Dark)
- **Person Colors**: Luan (`0xFF3b82f6`), Luciana (`0xFFec4899`), Giovanna (`0xFF8b5cf6`).
- **Avatars**: Imagens de perfil configuradas globalmente em `constants.dart`.
- **Icons**: Material Symbols Outlined com variações de `fill` para nav bar.

## Component Hierarchy (New)
```
CasaApp (MaterialApp)
└── HomeScreen (ConsumerStatefulWidget)
    ├── _buildHeader() -> Header com periodProvider selectors
    └── IndexedStack (Aba selecionada)
        ├── DespesasTab (Views de despesas + sumário)
        ├── CartaoTab (Views de compras no cartão)
        └── ResumoTab (Dashboard consolidado)
```
