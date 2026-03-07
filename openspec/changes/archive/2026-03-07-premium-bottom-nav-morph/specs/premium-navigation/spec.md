## MODIFIED Requirements

### Requirement: Indicador de Aba Ativa com Animação Glide
O sistema SHALL utilizar um indicador visual expansivo contido de forma isolada dentro de cada item da barra, esvanecendo a marcação na aba desativada e simultaneamente expandindo (ou materializando) na aba selecionada por meio de transições de fade e scale.
- O background ativo do item em foco deve animar na própria posição sem contato com os adjacentes (destransformar no ícone atual / transformar no novo ícone selecionado).
- Fica proibido o uso de um único indicador deslizando horizontalmente entre as opções.

#### Scenario: Transição independente de foco entre itens
- **WHEN** o usuário toca no ícone de "Cartão" estando atualmente na aba "Despesas"
- **THEN** a marcação visual de fundo associada à "Despesas" some progressivamente encolhendo em seu centro (fade-out e redução), enquanto a marcação do "Cartão" cresce de seu centro até englobar o ícone, atingindo também opacidade máxima.
