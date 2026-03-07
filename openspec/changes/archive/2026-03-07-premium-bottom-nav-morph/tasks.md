## 1. Refatoração Arquitetural

- [x] 1.1 Excluir completamente o widget stateful `_GooeyIndicator` de `lib/shared/widgets/premium_bottom_nav.dart`
- [x] 1.2 Remover a dependência do GooeyIndicator dentro do `LayoutBuilder`/`Stack` do widget `PremiumBottomNav`
- [x] 1.3 Preservar o agrupamento de botões de índice na `Row` e a estilização e contornos base da barra flutuante

## 2. Animação Isolada (Morph)

- [x] 2.1 Adicionar um container de background no stack de conteúdo interno do `_PremiumNavItemWidget` (atrás do ícone e do texto)
- [x] 2.2 Envolver o background com propriedades implícitas de transição como `AnimatedContainer`, reagindo diretamente à propriedade boolean `isSelected`
- [x] 2.3 Configurar as dimensões ativas (ex: scale ou tamanho fixo ampliado / opacidade alta) e dimesões inativas (shrunk / opacidade nula) no background do botão
- [x] 2.4 Parametrizar tempos de animação e curvas orgânicas (ex: duração de ~300ms, use `easeOutCubic`) que estejam alinhados com as micro-reações existentes dos respectivos ícones Phosphor
- [x] 2.5 Validar visualmente o switch local de abas garantindo o efeito fade e o scale morfando o objeto perfeitamente
