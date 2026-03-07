## Why

Atualmente, a barra de navegação inferior (PremiumBottomNav) utiliza um indicador deslizante ("gooey") único e global que se move horizontalmente pelas abas. Para elevar ainda mais o nível do design "FinTech Premium" e seguir padrões modernos de UI/UX, precisamos transicionar esse efeito para um "Fade/Scale Morph" isolado por item. A proposta é que a barra atual desvaneça (destransforma) da aba não-selecionada e simultaneamente pulse e acenda (transforma) na aba tocada, tornando a transição mais tátil, exata e com aparência premium.

## What Changes

- **Remoção**: Eliminação do indicador global e deslizante (`_GooeyIndicator`) que opera no eixo X.
- **Modificação**: O background da marcação passa a ser contido dentro do próprio componente de índice da barra (`_PremiumNavItemWidget`).
- **Animações (Micro-interações)**: Adoção combinada de animações como opacidade (`AnimatedOpacity`) e encolhimento/expansão (`AnimatedScale` ou variações de tamanho em contêineres e decorações) nos backgrounds de cada aba. Ao desselecionar uma aba, o seu background encolhe e desaparece, enquanto a recém-selecionada o expande de forma pulsante ganhando opacidade total.

## Capabilities

### New Capabilities

### Modified Capabilities
- `premium-navigation`: Remoção do efeito Gooey de fundo na BottomNav e refatoração para transições e marcações visuais com morfismos autônomos por item.

## Impact

- Refatoração substancial de `lib/shared/widgets/premium_bottom_nav.dart`. 
- Exclusão do widget interno `_GooeyIndicator` e simplificação da estrutura do layout root da BottomNav.
- Expansão do controle de animações dentro de `_PremiumNavItemWidget` sem impactar na comunicação das seleções globais (o `onTap` e callback de mudança permanecem os mesmos).
