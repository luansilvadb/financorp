# Tech Stack - Divi

## Languages & Runtime

- **Dart**: ^3.1.0 (SDK)
- **Flutter**: Framework UI para desenvolvimento multiplataforma

## Core Dependencies

### State Management
- **flutter_riverpod**: ^2.4.10 - Gerenciamento de estado reativo e injeção de dependência

### Backend & Database
- **supabase_flutter**: ^2.12.0 - Backend as a Service com autenticação, banco de dados em tempo real e storage
  - URL: `https://rrihdmbvzsckguvqpmkh.supabase.co`
  - Configuração via `.env` file

### Utilities
- **intl**: ^0.20.2 - Internacionalização e formatação (datas, moedas, números)
- **flutter_dotenv**: ^6.0.0 - Carregamento de variáveis de ambiente
- **app_links**: ^6.4.1 - Suporte a deep links e app links
- **google_fonts**: ^6.3.0 - Fontes customizadas do Google Fonts
- **dotted_line**: ^3.2.3 - Widget para linhas pontilhadas
- **phosphor_flutter**: ^2.1.0 - Biblioteca de ícones moderna
- **animations**: ^2.0.11 - Animações pré-construídas do Material Design

### Data Modeling
- **freezed_annotation**: ^2.4.1 - Code generation para classes immutable e union types
- **json_annotation**: ^4.9.0 - Serialização/deserialização JSON

## Dev Dependencies

### Code Generation
- **build_runner**: ^2.4.8 - Sistema de build e code generation
- **freezed**: ^2.5.2 - Geração de código para classes immutable
- **json_serializable**: ^6.7.1 - Geração de código para serialização JSON

### Linting & Testing
- **flutter_lints**: ^4.0.0 - Conjunto de regras de linting recomendadas
- **flutter_test**: SDK - Framework de testes do Flutter

## Platform Support

O projeto suporta múltiplas plataformas:
- ✅ Android (`android/`)
- ✅ iOS (`ios/`)
- ✅ Web (`web/`)
- ✅ Windows (`windows/`)
- ✅ Linux (`linux/`)
- ✅ macOS (`macos/`)

## Configuration Files

- `pubspec.yaml` - Definição de dependências e configuração do Flutter
- `analysis_options.yaml` - Regras de análise estática e linting
- `.env` - Variáveis de ambiente (Supabase credentials)
- `nixpacks.toml` - Configuração de deployment

## Key Technical Decisions

1. **Riverpod + Supabase**: Arquitetura reativa com backend serverless
2. **Freezed + JSON Serializable**: Modelos de dados type-safe com serialização automática
3. **Feature-first structure**: Organização por features (`lib/features/`) com separação clara de responsabilidades
4. **Multi-platform**: Suporte completo a mobile, web e desktop
