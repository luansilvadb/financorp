# External Integrations - Divi

## Backend Services

### Supabase
**Type**: Backend as a Service (BaaS)  
**URL**: `https://rrihdmbvzsckguvqpmkh.supabase.co`  
**Purpose**: Backend completo com autenticação, banco de dados PostgreSQL, storage e realtime subscriptions

**Integration Points**:
- Autenticação de usuários (email/password, OAuth providers)
- Banco de dados PostgreSQL com Row Level Security (RLS)
- Realtime subscriptions para atualizações em tempo real
- Storage para arquivos e imagens
- Edge Functions para lógica server-side (se configurado)

**Configuration**:
- Credenciais armazenadas em `.env`:
  - `SUPABASE_URL`: URL do projeto Supabase
  - `SUPABASE_ANON_KEY`: Chave pública para acesso anônimo

**Database Schema**:
Migrations localizadas em `supabase/migrations/`:
- Arquivos de migration SQL versionados
- Configuração em `supabase/config.toml`

## Authentication Providers

Provavelmente configurado via Supabase Auth:
- Email/Password authentication
- Possivelmente OAuth providers (Google, GitHub, etc.) - verificar configuração no dashboard Supabase

## Third-Party APIs

Nenhuma integração com APIs externas de terceiros detectada além do Supabase.

## Deep Links & App Links

**Package**: `app_links` ^6.4.1  
**Purpose**: Suporte a deep linking para:
- Abrir URLs específicas do app
- Integração com notificações push
- Sharing de conteúdo específico

## Fonts

**Service**: Google Fonts  
**Package**: `google_fonts` ^6.3.0  
**Purpose**: Carregamento dinâmico de fontes do Google Fonts CDN

## Platform-Specific Integrations

### Android
- Gradle build system
- Kotlin/Java bridge para funcionalidades nativas

### iOS/macOS
- CocoaPods para gerenciamento de dependências nativas
- Swift/Objective-C bridge

### Web
- HTML/CSS/JavaScript compilation
- PWA support (manifest.json, service workers)

### Desktop (Windows/Linux/macOS)
- Native window management
- Platform-specific integrations via Flutter plugins

## Environment Configuration

**File**: `.env`  
**Variables**:
```
SUPABASE_URL=https://rrihdmbvzsckguvqpmkh.supabase.co
SUPABASE_ANON_KEY=sb_publishable_ns5mvViZb-uGHKfd7q3U_g_vhO2gF9M
```

**Loading**: Via `flutter_dotenv` package no `main.dart`

## Deployment

**Config**: `nixpacks.toml`  
**Purpose**: Configuração de deployment automatizado (provavelmente para Railway ou plataforma similar que suporta Nixpacks)

## Monitoring & Analytics

Nenhuma integração com serviços de monitoring ou analytics detectada no momento.

## Payment Processing

Nenhuma integração com gateways de pagamento detectada no momento.

## Push Notifications

Nenhuma integração específica com Firebase Cloud Messaging (FCM) ou Apple Push Notification Service (APNS) detectada no momento.
