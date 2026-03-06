# Tech Context

## Technology Stack
| Layer           | Technology                                  |
|-----------------|---------------------------------------------|
| Framework       | Flutter (Dart SDK ^3.1.0)                   |
| State Mgmt      | **Flutter Riverpod (2.6.1)**               |
| Backend / DB    | **Supabase (PostgreSQL)**                   |
| Env Management  | **flutter_dotenv (^6.0.0)**                 |
| Schema Mgmt     | **Supabase CLI (Migrations)**               |
| UI Library      | Material Design 3                           |
| Typography      | **Google Fonts — Inter** (`google_fonts`)   |
| Icon Library    | **Phosphor Icons** (`phosphor_flutter`)     |
| Localization    | intl (BRL formatting)                       |

## Project Structure
A estrutura foi modernizada para suportar múltiplos arquivos e separação de camadas.
```
d:\financorp\app_casa_transparente\
├── .env                        # Chaves do Supabase (ignorado no git)
├── supabase\                   # Configuração e Migrations do DB
│   └── migrations\             # Scripts SQL versionados
├── lib\
│   ├── main.dart               # Entry point e orquestração de abas
│   ├── core\                   # Utils e formatadores globais
│   ├── shared\                 # Modelos, constantes e providers globais
│   │   └── widgets\            # Widgets compartilhados (PersonSummaryRow)
│   └── features\               # Módulos de negócio (finance, cartao)
│       └── [feature]\
│           ├── data\           # Repositórios Supabase
│           ├── providers\      # Notifiers Riverpod
│           └── views\          # Telas e widgets
│               └── widgets\    # Widgets isolados (DespesaCard, CartaoCard, Bottom Sheets)
├── pubspec.yaml                # Dependências atualizadas
└── .gitignore                  # Configurado para ignorar .env
```

## Dependencies (Updated)
- `flutter_riverpod`: Gestão de estado reativa.
- `supabase_flutter`: Cliente oficial para banco de dados assíncrono.
- `flutter_dotenv`: Carregamento seguro de chaves de API.
- `intl`: Formatação de data e moeda brasileira.
- `google_fonts`: Fornece a fonte **Inter** via `GoogleFonts.interTextTheme()` no ThemeData global.
- `phosphor_flutter`: Ícones **PhosphorIcons** para visual FinTech premium.
- `freezed_annotation` / `json_annotation`: Anotações para código gerado para modelos imutáveis e serialização. (Usados junto com `freezed`, `build_runner` e `json_serializable` em `dev_dependencies`).

## Development Setup
- **CLI**: Supabase CLI instalado para gerenciamento de migrations.
- **Run command**: `flutter run`
- **Migration command**: `npx supabase db push`

## Technical Constraints (Resolved)
- ~~Persistence~~: **Implementada** via Supabase.
- ~~Single-file architecture~~: **Refatorada** para estrutura modular.
- ~~Auth~~: **Semi-implementada** (Uso de chave `anon` com RLS liberado. Próximo passo é login individual).
- ~~Ícones genéricos~~: **Resolvido** — Todos os Material Icons substituídos por PhosphorIcons para visual FinTech premium.
- ~~Fonte padrão~~: **Resolvido** — Manrope substituída por Inter via google_fonts.
- ~~Rebuilds monolíticos~~: **Resolvido** — Cards de alta densidade como `ConsumerWidget` + Detail Sheets + `.select()` nos resumos.

## Storage Decisions
- **UUIDs**: Gerenciados diretamente pelo servidor PostgreSQL para garantir unicidade sem colisões locais.
- **Relational Integrity**: Uso de `REFERENCES` with `ON DELETE CASCADE` para garantir que pagamentos sejam limpos se uma despesa for removida.
- **Security**: RLS ativo nas tabelas com políticas permitindo acesso público (chave anon) para simplificação inicial.

## Icon/Font Migration Notes
- `PhosphorIconData` extends `IconData`, portanto é compatível com parâmetros `IconData`. Porém, para renderização correta, sempre usar `PhosphorIcon(...)` widget em vez de `Icon(...)`.
- `PhosphorIcons.xxx(PhosphorIconsStyle.regular)` é uma chamada de método, **não pode** ser usada em expressões `const`. Remover `const` de widgets pai quando necessário.
- A NavBar usa alternância `regular`/`fill` para indicar estado ativo vs inativo.

## Performance Optimization Notes
- **Widgets de lista de alta densidade**: `DespesaCard` e `CartaoCard` são `ConsumerWidget` sem estado local. Toque no corpo abre Detail Sheet; toque no ícone (no Cartão) alterna estado de pagamento.
- **Optimistic UI em Providers**: Notifiers modificam o `state.whenData()` localmente logo após a ação, aplicando feedback instantâneo sem depender da latência da requisição HTTP (`ref.invalidateSelf()` não é usado exceto se precisamos sincronizar o DB). Rollbacks ocorrem apenas em cenários de erro via `try-catch`.
- **Tabs leves e .select()**: `DespesasTab`/`CartaoTab` são `ConsumerWidget`. `PersonSummaryRow` escuta seletivamente as changes dos stats de resumo. 
- **Detail Bottom Sheets**: Menus contextuais com ações de Editar/Excluir, mantendo as listas visualmente simples.
