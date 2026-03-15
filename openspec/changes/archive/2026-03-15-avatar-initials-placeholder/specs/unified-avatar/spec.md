## ADDED Requirements

### Requirement: Componente de Avatar Unificado (DiviAvatar)
O sistema SHALL possuir um componente visual padronizado para representar moradores, capaz de exibir as iniciais do nome sobre um fundo colorido baseado na identidade visual do morador.

#### Scenario: Exibição de avatar com iniciais
- **WHEN** o componente DiviAvatar é renderizado para o morador "Luan"
- **THEN** o componente deve exibir a letra "L" centralizada
- **THEN** o fundo do componente deve utilizar a cor definida para o Luan (0xFF3b82f6) com opacidade reduzida
- **THEN** o texto da inicial deve utilizar a cor sólida definida para o Luan

#### Scenario: Suporte a diferentes tamanhos
- **WHEN** o componente DiviAvatar é utilizado em diferentes contextos (ex: resumo vs lista de compras)
- **THEN** o componente deve permitir a definição de um tamanho (radius/diâmetro) específico mantendo a proporção visual das iniciais
