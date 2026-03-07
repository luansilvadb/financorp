# Proposal: Splash Screen Premium

## Problem

Atualmente, o aplicativo "Casa Transparente" inicia diretamente na `HomeScreen`. Durante o processo de inicialização asíncrona no `main.dart` (carregamento de `.env` e inicialização do `Supabase`), pode ocorrer uma breve tela em branco ou preta, o que quebra a experiência de usuário de um app de alta qualidade. Além disso, falta um momento de reforço da identidade visual do projeto ao abrir o aplicativo.

## Proposed Change

Implementar uma Splash Screen dinâmica e animada que mascare o tempo de inicialização do backend e apresente a marca do projeto com estética FinTech Premium.

A mudança inclui:
1.  **Splash Widget**: Um novo widget dedicado para a animação inicial.
2.  **Design Premium**: Fundo em gradiente (`kPrimaryColor` para `kSlate900`), ícone `PhosphorIcons.bank` animado e tipografia Inter Bold.
3.  **Fluxo de Orquestração**: Modificação no `main.dart` para gerenciar o estado de inicialização e a transição suave para a `HomeScreen`.
4.  **Feedback de Carregamento**: Um indicador de progresso sutil integrado ao design.

## Impact

- **UI/UX**: Melhora significativa na primeira impressão do app. Transições suaves eliminam "saltos" visuais durante o carregamento.
- **main.dart**: Mudança na lógica do `main()` para lidar com a inicialização dentro ou antes da renderização da Splash.
- **Dependencies**: Uso contínuo de `google_fonts` e `phosphor_flutter`.
