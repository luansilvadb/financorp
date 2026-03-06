# premium-navigation Specification

## Purpose
TBD - created by archiving change improve-bottom-nav-ui. Update Purpose after archive.
## Requirements
### Requirement: Interface de Navegação Flutuante
O sistema SHALL exibir a barra de navegação como um elemento flutuante, separado das bordas da tela, para criar uma percepção de leveza e modernidade.
- A barra deve ter margens laterais de 16dp e margem inferior de 16dp em relação à Safe Area.
- A barra deve possuir cantos arredondados com raio de pelo menos 24dp.

#### Scenario: Visualização da barra flutuante
- **WHEN** o usuário abre qualquer tela principal do aplicativo
- **THEN** a barra de navegação é exibida centralizada horizontalmente, sem tocar as bordas laterais ou inferiores da tela.

### Requirement: Efeito Glassmorphism (Vidro)
O fundo da barra de navegação SHALL utilizar um efeito de desfoque (BackdropFilter) e transparência para permitir a visualização sutil do conteúdo que passa por baixo dela.
- O efeito deve ser implementado usando um filtro de desfoque (BackdropFilter) com sigma de pelo menos 15.
- A cor de fundo deve ser branca ou clara com opacidade entre 70% e 85%.
- Uma borda ultra-fina (0.5dp a 1dp) com baixa opacidade deve ser aplicada para simular reflexo de luz.

#### Scenario: Rolagem de conteúdo sob a barra
- **WHEN** o usuário faz scroll em uma lista (ex: Despesas)
- **THEN** os itens da lista são visíveis de forma desfocada através do fundo da barra de navegação enquanto passam por trás dela.

### Requirement: Indicador de Aba Ativa com Animação Glide
O sistema SHALL utilizar um indicador visual animado que desliza suavemente entre as posições das abas quando o usuário alterna a navegação.
- O indicador deve ser uma "pílula" (pill) de fundo ou uma linha estilizada que utiliza animações implícitas para a transição de posição.
- A animação deve ter uma curva de velocidade suave (ex: easeOutCubic ou elasticOut).

#### Scenario: Transição suave entre abas
- **WHEN** o usuário toca no ícone de "Cartão" estando na aba "Despesas"
- **THEN** o indicador visual desliza da posição atual para a nova posição em uma transição contínua e fluida.

### Requirement: Feedback Háptico na Navegação
O sistema SHALL fornecer um feedback tátil (vibração) leve ao usuário sempre que uma nova aba for selecionada.
- O feedback deve utilizar o padrão "light impact" do sistema operacional.

#### Scenario: Toque em item de navegação
- **WHEN** o usuário seleciona uma aba na barra de navegação
- **THEN** o dispositivo emite uma vibração curta e sutil confirmando a seleção.

### Requirement: Transição de Estilo de Ícones
Os ícones da barra de navegação SHALL alternar entre os estilos `regular` (não selecionado) e `fill` (selecionado) do PhosphorIcons com uma micro-interação visual.

#### Scenario: Seleção de ícone
- **WHEN** uma aba é selecionada
- **THEN** o ícone correspondente muda para a versão preenchida (fill) e sua cor muda para a cor primária (kPrimaryColor).

