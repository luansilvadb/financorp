# Design: Splash Screen Premium

## Problem & Context

Atualmente o `main.dart` realiza todas as inicializações (`dotenv`, `Supabase`) antes de chamar `runApp`. Isso causa um atraso perceptível na renderização inicial do app. Precisamos de uma tela de transição que já seja renderizada imediatamente enquanto os processos pesados ocorrem em background.

## Goals

- **Performance Percebida**: Iniciar o motor do Flutter e mostrar a UI da Splash o mais rápido possível.
- **Micro-interações**: Animação de escala e opacidade no ícone central.
- **Transição Suave**: Troca de telas via `PageRouteBuilder` com efeito de fade.

## Non-Goals

- Não vamos usar `flutter_native_splash` (imagens estáticas nativas) pois queremos animações dinâmicas de código que integrem com nossos tokens de design (`kPrimaryColor`, `Inter Font`).

## Design Patterns

### 1. `SplashScreen` Widget
Será implementado em `lib/core/views/splash_screen.dart`.
- Utilizará `SingleTickerProviderStateMixin` para animações controladas.
- O background será um `BoxDecoration` com `LinearGradient`.

### 2. State Management (Initialization)
- No `main.dart`, mudaremos para instanciar as dependências em paralelo com a exibição da Splash.
- Usaremos um `Future.delayed` mínimo para garantir que a animação da Splash seja vista por pelo menos 1.2 segundos para fluidez.

### 3. Navigation Hook
Ao completar a inicialização:
```dart
Navigator.of(context).pushReplacement(
  PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
    transitionDuration: const Duration(milliseconds: 600),
  ),
);
```

## UI Structure

```
Stack
├── Container (LinearGradient: kPrimaryColor -> kSlate900)
├── Center
│   └── Column (mainAxisSize.min)
│       ├── ScaleTransition(PhosphorIcon(bank, color: White, size: 80))
│       ├── Opacity(Text("CASA TRANSPARENTE", style: Inter, 800))
└── Align (Bottom)
    └── Padding(CircularProgressIndicator(strokeWidth: 2, color: White38))
```

## Risks / Trade-offs

- **Risk**: A inicialização do Supabase pode falhar (ex: sem internet). 
- **Mitigation**: A Splash deve mostrar uma mensagem de erro ou botão de "Tentar Novamente" se o timeout de 10s for atingido.
