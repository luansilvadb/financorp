## Context

Atualmente, o aplicativo utiliza uma barra de navegação personalizada no `HomeScreen` (`main.dart`) que consiste em um `Container` simples com uma `Row`. Esta barra é fixa no rodapé, possui um fundo branco semi-opaco e um pequeno ponto estático como indicador de aba ativa. O objetivo deste design é elevar a interface para um padrão "Premium Bank", utilizando transparências, desfoque de fundo e animações fluidas.

## Goals / Non-Goals

**Goals:**
- Implementar uma barra de navegação flutuante (detached) com cantos arredondados.
- Aplicar efeito de Glassmorphism (BackdropFilter) no fundo da barra.
- Criar um indicador de aba ativa tipo "pílula" com animação de deslize elástico.
- Integrar feedback háptico (vibration) nas interações.
- Garantir que as listas de conteúdo das abas fluam por trás da barra de navegação.

**Non-Goals:**
- Alterar a arquitetura de navegação (`IndexedStack` e `_aba` index).
- Modificar o conteúdo ou lógica interna das abas (`DespesasTab`, `CartaoTab`, `ResumoTab`).
- Implementar um menu de ações centralizado (foco apenas no refinamento da navegação existente).

## Decisions

### 1. Estrutura de Posicionamento com Stack
**Decisão:** A barra de navegação será implementada como um widget customizado posicionado dentro de um `Stack` no corpo do `Scaffold`, ou utilizando o `bottomNavigationBar` envolto em um `Padding` com `extendBody: true`.
**Racional:** Para obter o efeito "flutuante" e garantir que o desfoque funcione corretamente, a barra precisa estar sobreposta ao conteúdo. O `extendBody: true` do `Scaffold` é essencial para que o corpo do app se estenda por trás da área da barra de navegação.
**Alternativas:** Usar o `bottomNavigationBar` padrão, mas ele limita a customização de margens e o posicionamento exato necessário para o efeito de vidro flutuante.

### 2. Animação de Indicador Glide com AnimatedPositioned
**Decisão:** O indicador visual ("pílula" de fundo) será movido usando um `AnimatedPositioned` com `Curves.easeOutCubic` e duração de aproximadamente 350ms.
**Racional:** Proporciona um movimento fluido e orgânico que comunica a mudança de contexto de forma clara e sofisticada, sem a complexidade de gerenciar `AnimationControllers` manuais.
**Alternativas:** `AnimatedContainer` (limitado para movimentação lateral independente) ou `PageView` (não se aplica à barra de navegação).

### 3. Estética Glassmorphism com BackdropFilter
**Decisão:** A barra terá um `ClipRRect` para os cantos arredondados e um `BackdropFilter` com `ImageFilter.blur(sigmaX: 15, sigmaY: 15)`.
**Racional:** Este é o padrão visual de apps premium modernos (iOS/Fintechs). O desfoque cria uma hierarquia visual clara, mantendo o contexto do que está atrás sem poluir a visão da navegação.
**Alternativas:** Apenas transparência simples (parece inacabado/amador) ou opacidade total (parece pesado/antigo).

### 4. Feedback Háptico e Micro-interações
**Decisão:** Chamar `HapticFeedback.lightImpact()` em cada troca de aba e usar `AnimatedScale` nos ícones selecionados.
**Racional:** O toque físico aumenta a satisfação do usuário e a percepção de que o software é responsivo e de alta qualidade. O leve aumento de escala (ex: 1.0 -> 1.1) complementa a mudança para o estilo `fill` do ícone.

### 5. Centralização do FAB no HomeScreen
**Decisão:** Remover os `FloatingActionButton` das abas internas (`DespesasTab` e `CartaoTab`) e centralizar o FAB no `Scaffold` do `HomeScreen`.
**Racional:** Ao usar `extendBody: true` e uma barra de navegação customizada, o posicionamento automático do FAB em Scaffolds aninhados falha. Centralizar no Scaffold principal garante que o Flutter posicione o botão corretamente acima da barra flutuante. A ação do botão será dinâmica baseada no índice `_aba`.
 → Como a barra é flutuante e o conteúdo passa por trás, botões ou textos no final das listas podem ficar difíceis de ler. **Mitigação:** Garantir que todas as abas tenham um `padding` inferior no `ListView` de pelo menos 120dp.
- **[Risco] Performance do BackdropFilter** → Em dispositivos Android de entrada, o desfoque em tempo real pode causar quedas de frame. **Mitigação:** Manter o `sigma` em valores razoáveis e testar a fluidez. Se necessário, desabilitar o desfoque em favor de opacidade simples em hardware muito limitado.
- **[Risco] Conflito com Safe Area** → A margem inferior da barra pode conflitar com a barra de gestos do sistema (iOS/Android). **Mitigação:** Usar `MediaQuery.of(context).padding.bottom` para calcular a margem inferior de forma segura.
