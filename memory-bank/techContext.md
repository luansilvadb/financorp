# Tech Context

## Technology Stack
| Layer           | Technology                                  |
|-----------------|---------------------------------------------|
| Framework       | Flutter (Dart SDK ^3.1.0)                   |
| State Mgmt      | **Flutter Riverpod (2.6.1)**                |
| Backend / DB    | **Supabase (PostgreSQL)**                   |
| Env Management  | **flutter_dotenv (^6.0.0)**                 |
| Schema Mgmt     | **Supabase CLI (Migrations)**               |
| Typography      | **Google Fonts — Inter** (`google_fonts`)   |
| Icon Library    | **Phosphor Icons** (`phosphor_flutter`)     |
| Code Generation | **Freezed** & **Json Serializable**         |

## Project Structure
A estrutura foi modernizada para suportar múltiplos arquivos e separação de camadas.
```
d:\financorp\app_casa_transparente\
├── .env                        # Chaves do Supabase (ignorado no git)
├── supabase\                   # Configuração e Migrations do DB
│   └── migrations\             # Scripts SQL versionados
├── lib\
│   ├── main.dart               # Entry point e orquestração de abas
│   ├── core\                   # Utils, formatadores e o Motor Central (FinancorpEngine)
│   ├── shared\                 # Modelos (Freezed), constantes e provedor de período
│   │   └── widgets\            # Widgets compartilhados (PersonSummaryRow, Skeletons)
│   └── features\               # Módulos de negócio (finance, cartao)
│       └── [feature]\
│           ├── data\           # Repositórios Supabase
│           ├── providers\      # Notifiers Riverpod para CRUD e Optimistic UI
│           └── views\          # Telas e widgets filhos
├── pubspec.yaml                # Dependências
└── .gitignore                  # Configurado para ignorar .env e arquivos gerados locais
```

## Dependencies (Updated)
- `flutter_riverpod`: Gestão de estado reativa de alta performance.
- `supabase_flutter`: Cliente oficial para banco de dados assíncrono.
- `flutter_dotenv`: Carregamento seguro de chaves de API.
- `intl`: Formatação de data e moeda brasileira.
- `google_fonts`: Fornece a fonte **Inter**.
- `phosphor_flutter`: Ícones **PhosphorIcons** para visual FinTech premium.
- `freezed_annotation` / `json_annotation`: Anotações para modelos imutáveis com serialização em conjunto com o pacote `build_runner`.

## Development Setup
- **CLI**: Supabase CLI instalado para gerenciamento de migrations.
- **Run command**: `flutter run`
- **Migration command**: `npx supabase db push`
- **Build runner**: `dart run build_runner build --delete-conflicting-outputs` (gerar/atualizar arquivos `.freezed.dart` e `.g.dart`).

## Technical Constraints (Resolved)
- ~~Persistence~~: **Implementada** via Supabase.
- ~~Single-file architecture~~: **Refatorada** para estrutura modular.
- ~~Rebuilds monolíticos e lógicas repetidas~~: **Resolvido** — Implementado o `FinancorpEngine` com mapeamento O(N) e acesso O(1) combinados com `.select()` do Riverpod, além do uso extensivo de Dart 3 Records.
- ~~Ícones genéricos / Fonte padrão~~: **Resolvido** — Substituídos por PhosphorIcons e Inter.
- ~~Auth~~: **Semi-implementada** (Uso de chave `anon` com RLS liberado. Próximo passo é login individual).

## Storage Decisions
- **UUIDs**: Gerenciados diretamente pelo servidor PostgreSQL.
- **Relational Integrity**: Uso de `REFERENCES` with `ON DELETE CASCADE`.
- **Security**: RLS ativo nas tabelas com políticas permitindo acesso público temporário (anon).

## Performance Optimization Notes (FinancorpEngine)
- O **FinancorpEngine** varre todos os dados brutos de Despesas, Pagamentos e Compras uma única vez em tempo linear **O(N)**.
- O Motor dispensa inteiramente o uso de listas dentro dos widgets, fornecendo **Mapas** estritamente tipados baseados em Dart 3 **Records**. Isso permite seleções pontuais (O(1) Access) usando Riverpod (`ref.watch(financeEngineProvider.select((s) => s.despesas[id]))`), mantendo o framerate cravado em **60fps** em telas com alto volume de interações "Optimistic".
- Classes `freezed` para representar estados visuais voláteis foram substituídas por **Records** com campos nomeados, que eliminam o tempo do build runner e oferecem o mesmo nível de imutabilidade sem custos de runtime de POO tradicionais.
