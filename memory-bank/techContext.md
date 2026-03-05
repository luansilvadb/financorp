# Tech Context

## Technology Stack
| Layer           | Technology                                  |
|-----------------|---------------------------------------------|
| Framework       | Flutter (Dart SDK ^3.10.7, Flutter SDK >=3.10.0) |
| State Mgmt      | **Flutter Riverpod (^3.2.1)**               |
| Backend / DB    | **Supabase (PostgreSQL)**                   |
| Env Management  | **flutter_dotenv (^5.1.0)**                 |
| Schema Mgmt     | **Supabase CLI (Migrations)**               |
| UI Library      | Material Design 3                           |
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
│   └── features\               # Módulos de negócio (finance, cartao)
│       └── [feature]\
│           ├── data\           # Repositórios Supabase
│           ├── providers\      # Notifiers Riverpod
│           └── views\          # Telas e widgets
├── pubspec.yaml                # Dependências atualizadas
└── .gitignore                  # Configurado para ignorar .env
```

## Dependencies (Updated)
- `flutter_riverpod`: Gestão de estado reativa.
- `supabase_flutter`: Cliente oficial para banco de dados assíncrono.
- `flutter_dotenv`: Carregamento seguro de chaves de API.
- `intl`: Formatação de data e moeda brasileira.

## Development Setup
- **CLI**: Supabase CLI instalado para gerenciamento de migrations.
- **Run command**: `flutter run`
- **Migration command**: `npx supabase db push`

## Technical Constraints (Resolved)
- ~~Persistence~~: **Implementada** via Supabase.
- ~~Single-file architecture~~: **Refatorada** para estrutura modular.
- ~~Auth~~: **Semi-implementada** (Uso de chave `anon` com RLS liberado. Próximo passo é login individual).

## Storage Decisions
- **UUIDs**: Gerenciados diretamente pelo servidor PostgreSQL para garantir unicidade sem colisões locais.
- **Relational Integrity**: Uso de `REFERENCES` com `ON DELETE CASCADE` para garantir que pagamentos sejam limpos se uma despesa for removida.
- **Security**: RLS ativo nas tabelas com políticas permitindo acesso público (chave anon) para simplificação inicial.
