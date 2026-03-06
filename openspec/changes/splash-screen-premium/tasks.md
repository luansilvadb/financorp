# Tasks: Splash Screen Premium

### 1. Novo Componente Splash Screen
- [x] 1.1 Criar o diretório `lib/core/views/` caso não exista.
- [x] 1.2 Implementar `SplashScreen` em `lib/core/views/splash_screen.dart` com animações Flutter.
- [x] 1.3 Integrar gradiente de background e tipografia Inter com tokens de `constants.dart`.

### 2. Orquestração e Inicialização no Main
- [x] 2.1 Refatorar `main.dart` para delegar a inicialização profunda (`dotenv` e `Supabase`) para a `SplashScreen` ou um provedor de inicialização.
- [x] 2.2 Garantir que a `HomeScreen` só seja exibida após as inicializações necessárias.
- [x] 2.3 Implementar o temporizador mínimo de 1.2s para retenção da Splash.

### 3. Navegação e Limpeza
- [x] 3.1 Implementar a troca de páginas via `PageRouteBuilder` com Fade Transition suave.
- [x] 3.2 Verificar o tratamento de erros (`Supabase` timeout) e UI de fallback.
- [x] 3.3 Testar o comportamento em "cold start" real para verificar se não há "flicker".
