## Why

A barra de navegação atual é estática e não condiz com a "aura de banco premium" desejada para o projeto. Para elevar a percepção de qualidade e modernidade, precisamos de uma interface mais fluida, que utilize efeitos visuais contemporâneos como Glassmorphism e animações que tragam uma sensação tátil e física ao aplicativo.

## What Changes

- **Interface Flutuante**: A BottomNavigationBar deixará de ser fixa no rodapé e passará a ser um elemento flutuante (detached) com bordas arredondadas e margens laterais.
- **Efeito Glassmorphism**: Implementação de fundo com desfoque (BackdropFilter) e transparência, permitindo que o conteúdo do app seja visível por trás da barra.
- **Indicador Glide**: Substituição do ponto estático por um indicador tipo "pílula" que desliza suavemente entre as abas ativas com animações implícitas.
- **Feedback Háptico**: Adição de vibrações leves (light impact) ao interagir com os botões de navegação para reforçar a sensação de qualidade.
- **Refinamento de Ícones**: Transição suave entre estilos `regular` e `fill` do PhosphorIcons com micro-interações de escala.

## Capabilities

### New Capabilities
- `premium-navigation`: Especificação da interface de navegação flutuante, incluindo comportamento de desfoque, animações de transição de abas e feedback tátil.

### Modified Capabilities
<!-- Nenhuma especificação existente cobre diretamente a barra de navegação global. -->

## Impact

- **UI Global**: Alteração no `HomeScreen` (`main.dart`) para suportar a nova estrutura de navegação e `extendBody: true`.
- **Experiência do Usuário**: Melhoria na percepção de fluidez e feedback tátil em todo o aplicativo.
- **Ajustes de Layout**: Possível necessidade de padronização do padding inferior nas abas `DespesasTab`, `CartaoTab` e `ResumoTab` para garantir que o conteúdo não seja obstruído pela barra flutuante.
