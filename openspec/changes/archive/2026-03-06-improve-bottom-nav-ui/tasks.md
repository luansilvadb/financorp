## 1. Preparação da Estrutura

- [x] 1.1 Adicionar `extendBody: true` no `Scaffold` principal em `main.dart`.
- [x] 1.2 Padronizar o padding inferior de `DespesasTab`, `CartaoTab` e `ResumoTab` para garantir que o conteúdo limpe a barra de navegação flutuante.

## 2. Implementação da Barra Premium (Glassmorphism)

- [x] 2.1 Envolver a barra de navegação em um `Padding` e `ClipRRect` para torná-la flutuante e arredondada.
- [x] 2.2 Implementar o `BackdropFilter` com desfoque (sigma 15) no fundo da barra.
- [x] 2.3 Adicionar uma borda ultra-fina e sombra sutil para reforçar a estética "Premium".

## 3. Animações e Feedback Tátil

- [x] 3.1 Implementar o indicador "Glide" (pill animado) que desliza entre as posições das abas usando `AnimatedPositioned`.
- [x] 3.2 Adicionar feedback háptico (`HapticFeedback.lightImpact()`) no momento da troca de abas.
- [x] 3.3 Implementar micro-animações nos ícones (escala e troca de estilo `regular`/`fill`).

## 4. Refinamento e Polimento

- [x] 4.1 Ajustar o posicionamento vertical da barra considerando a Safe Area (área de gestos do sistema).
## 5. Ajuste do FAB e Localização

- [x] 5.1 Remover o `FloatingActionButton` de `DespesasTab.dart`.
- [x] 5.2 Remover o `FloatingActionButton` de `CartaoTab.dart`.
- [x] 5.3 Implementar `FloatingActionButton` dinâmico no `main.dart` baseado no índice `_aba`.
- [x] 5.4 Ajustar a margem inferior do FAB para que ele "pouse" elegantemente acima da barra flutuante.

