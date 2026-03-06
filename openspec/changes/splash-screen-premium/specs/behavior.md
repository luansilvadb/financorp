# Spec: Splash Screen Behavior

## Requirements

### Requirement: Initialization Sequence
O sistema deve proceder com as inicializações em paralelo com a exibição da Splash.
- O carregamento do `.env` e `Supabase.initialize` deve ocorrer em segundo plano.
- A transição deve ocorrer somente após AMBOS (inicialização terminada e animação mínima de 1200ms concluída).

### Requirement: Animation Fidelity
- O ícone `PhosphorIcons.bank` deve aparecer com animação de escala (0.8 -> 1.0) e opacidade (0.0 -> 1.0) em 800ms.
- O nome "CASA TRANSPARENTE" deve aparecer 300ms depois do ícone com um suave fade-up.

### Requirement: Resource Cleanup
O `SplashScreen` widget deve descartar os `AnimationController` via `dispose()` para evitar fugas de memória.

## Scenarios

### Scenario: Successful Initialization
- **WHEN** O app é aberto.
- **THEN** A Splash Screen aparece imediatamente.
- **THEN** O backend inicializa em < 1s.
- **THEN** Após atingir 1.2s de exibição, a Splash faz transição de fade para a `HomeScreen`.

### Scenario: Network Error on Init
- **WHEN** O app tenta inicializar o Supabase sem conexão.
- **THEN** A Splash deve aguardar o timeout do Supabase.
- **THEN** Um `SnackBar` informando falha de conexão deve ser exibido ou a Splash deve mostrar um botão amigável de "Tentar Novamente".
