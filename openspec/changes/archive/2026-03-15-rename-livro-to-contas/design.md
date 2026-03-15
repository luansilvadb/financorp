## Context

O aplicativo utiliza o termo "Livro" em diversos pontos da interface para se referir à lista de despesas. O usuário solicitou a mudança para "Contas", que é um termo mais intuitivo e familiar no contexto financeiro.

## Goals / Non-Goals

**Goals:**
- Substituir todas as ocorrências de "LIVRO" e "Livro" por "CONTAS" e "Contas" na interface.
- Simplificar o texto do botão de submissão do modal de lançamento.

**Non-Goals:**
- Não serão feitas alterações estruturais no banco de dados ou nos nomes das entidades (ex: `expenses`, `splits`).
- Não serão alterados os nomes internos das classes ou métodos, apenas as strings de UI.

## Decisions

- **Utilizar "CONTAS" como label da aba**: Substitui "LIVRO" na barra de navegação inferior.
- **Simplificar "LANÇAR NO LIVRO" para "LANÇAR"**: O contexto do modal já deixa claro o que está sendo lançado, tornando o texto mais limpo.
- **Mensagem de confirmação de exclusão**: Alterar para "... do livro?" -> "... das contas?".

## Risks / Trade-offs

- **Espaço em tela**: "CONTAS" possui uma letra a mais que "LIVRO". Isso não deve ser um problema na barra de navegação.
- **Consistência**: É fundamental garantir que todas as menções ao termo "livro" na UI sejam atualizadas para evitar confusão.
