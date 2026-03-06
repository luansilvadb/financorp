## Context

O app atual utiliza uma lista plana de despesas e compras, o que gera repetição visual (nomes e avatares repetidos) e exige múltiplos cliques para ações simples. O processamento de resumos utiliza loops aninhados O(N*M), o que pode degradar a performance conforme o histórico cresce.

## Goals / Non-Goals

**Goals:**
- Implementar gestos de swipe (`Dismissible`) nos cards para ações rápidas.
- Agrupar compras de cartão por pessoa na `CartaoTab`.
- Otimizar o `resumoProvider` com indexação por `Map`.
- Adicionar placeholders de carregamento (Skeletons) para evitar saltos de layout.
- Implementar o "Snap Back" no `Dismissible` para ações não destrutivas (pagamento).

**Non-Goals:**
- Alterar o esquema do banco de dados (Migrations).
- Implementar animações complexas de 3D ou shaders.
- Mudar a arquitetura Riverpod (apenas otimização interna).

## Decisions

### 1. Uso de `Dismissible` Nativo vs. Bibliotecas Externas
- **Decisão**: Usar o widget `Dismissible` nativo do Flutter.
- **Racional**: Menor peso no bundle e flexibilidade total para implementar o comportamento de "Snap Back" (retorno automático) através do `confirmDismiss`.
- **Alternativa**: `flutter_slidable` (Descartada por adicionar dependência desnecessária para casos simples).

### 2. Snap Back no Pagamento
- **Decisão**: Retornar `false` no `confirmDismiss` para ações de pagamento, disparando a atualização via Riverpod em background.
- **Racional**: Permite que o usuário continue interagindo com a lista sem que o item "suma" e reapareça, mantendo a continuidade visual.

### 3. Agrupamento em View-Model (UI-Side)
- **Decisão**: Agrupar as compras por pessoa no widget `CartaoTab` usando um `Map<String, List<CompraCartao>>` gerado a partir do estado do provider.
- **Racional**: Mantém o provider de dados simples e permite flexibilidade na exibição (ex: colapsar grupos) sem alterar a lógica de negócio.

### 4. Indexação do Resumo
- **Decisão**: Converter a lista de pagamentos em um `Map<String, Map<String, Pagamento>>` (ID da despesa -> Pessoa -> Pagamento) dentro do `resumoProvider`.
- **Racional**: Transforma a busca de O(N) para O(1) dentro do loop principal, garantindo fluidez total no dashboard.

### 5. Skeletons via Containers Animados
- **Decisão**: Criar um widget `CardSkeleton` que espelha a estrutura do `CartaoCard` e `DespesaCard` usando cores de fundo `kSlate100/200` e animação de opacidade.
- **Racional**: Mais leve que a biblioteca `shimmer` e mantém a consistência visual do app.

## Risks / Trade-offs

- **[Risco] Toque acidental ao deslizar** → **Mitigação**: Configurar um `threshold` de 0.4 e adicionar `HapticFeedback` claro no momento da ativação.
- **[Risco] Confusão em Exclusão** → **Mitigação**: Exigir confirmação via `AlertDialog` ou `SnackBar` com "Desfazer" para o Swipe Left (Vermelho).
- **[Risco] Rebuilds em Cadeia** → **Mitigação**: Garantir que o agrupamento de dados ocorra de forma eficiente e não cause rebuilds desnecessários (uso de `Memoization` se necessário).
