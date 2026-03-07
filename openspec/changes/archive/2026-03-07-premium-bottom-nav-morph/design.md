## Context
A aplicação DIVI tem uma estética baseada em FinTechs Premium. A barra de navegação principal (`PremiumBottomNav`) utiliza o widget stateful `_GooeyIndicator` para animar globalmente um sublinhado/background no eixo horizontal da tela, sobrepondo os ícones (apresentando um efeito de deslize / gooey). Buscando refinar a reatividade e seguir um modelo de materialização instantânea e autônoma, adotaremos a transição independente de fundo por botão (Fade e Scale), como dita a proposta do projeto.

## Goals / Non-Goals

**Goals:**
- Converter o mecanismo de navegação horizontal por um mecanismo autônomo individual por botão.
- O fundo ativo de uma aba deve esvanecer (fade-out) e encolher simultaneamente (destransformar).
- A aba selecionada tem o fundo materializado instantaneamente pelo efeito inverso: expansão em escala com transição para opacidade total (fade-in / transform).
- Simplificar e limpar a classe `PremiumBottomNav`.

**Non-Goals:**
- Redesenhar por completo o design dos ícones ou proporções físicas e de acessibilidade da barra.
- Alterar o `HomeScreen` no `main.dart` no modo como indexa e chama as abas.

## Decisions

1. **Remoção Categórica do _GooeyIndicator**: Deletar a classe inteira referente a este efeito de deslize.
2. **Encapsulamento Visual em _PremiumNavItemWidget**: Toda a lógica de UI do background ficará agrupada na raiz do layout de cada item no Stack individual, usando Widgets implícitos acionados pela flag `isSelected`:
   - Utilizaremos `AnimatedOpacity` e `AnimatedScale` em um `Container` de background simulando a barra de destaque (ou equivalente em tamanho para contornar o ícone).
   - O tempo de duração será sincronizado com as atuais animações de ícone (ex. 200/350ms) usando curvas suaves como `Curves.easeOutCubic`.

## Risks / Trade-offs

- [Risk] Pulo indesejado ou clipping em animações de Scale.
  - _Mitigation_: Usaremos `AnimatedScale` direto ou `AnimatedContainer` com modificações puras nas dimensões contidas num alinhamento centro-central seguro para evitar jitter indesejado no layout flexível.
