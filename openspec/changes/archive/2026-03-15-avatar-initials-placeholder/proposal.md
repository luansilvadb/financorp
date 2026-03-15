## Why

Atualmente, o sistema utiliza imagens reais (URLs estáticas no `constants.dart`) para os avatares dos moradores em algumas telas, enquanto em outras já utiliza a inicial do nome. Além disso, a implementação do avatar está duplicada em vários componentes, o que dificulta a manutenção e gera inconsistência visual. Esta mudança visa unificar a exibição dos avatares, priorizando as iniciais do nome com as cores temáticas de cada morador, eliminando a dependência de URLs de imagens externas que podem quebrar ou não representar bem todos os usuários.

## What Changes

- Criação de um componente unificado `DiviAvatar` para padronizar a exibição de avatares em todo o app.
- Substituição de imagens de placeholder (URLs de teste) pelas iniciais dos nomes dos moradores.
- Padronização das cores dos avatares utilizando as cores já definidas para cada pessoa no `constants.dart`.
- Refatoração dos componentes `ResidentSummaryCard`, `PersonSummaryRow`, `ResumoTab`, `CartaoCard` e `CartaoDetailsSheet` para utilizarem o novo `DiviAvatar`.
- Remoção (ou marcação como obsoleta) da constante `avataresPessoa` no `constants.dart`.

## Capabilities

### New Capabilities
- `unified-avatar`: Implementação de um widget padrão para avatares que suporta iniciais, cores customizadas e tamanhos variados.

### Modified Capabilities
- `consolidated-status-card`: Atualização do card de resumo de residentes para usar o novo padrão de avatar.
- `consolidated-expense-list`: Atualização da lista de compras do cartão para usar o novo padrão de avatar.

## Impact

- **UI/UX**: Melhora na consistência visual do aplicativo.
- **Manutenção**: Redução de código duplicado e centralização da lógica de estilo dos avatares.
- **Performance**: Leve melhora ao evitar o carregamento de imagens externas desnecessárias.
- **Arquivos Afetados**:
    - `divi/lib/shared/widgets/divi_avatar.dart` (Novo)
    - `divi/lib/shared/constants.dart`
    - `divi/lib/features/finance/views/widgets/resident_summary_card.dart`
    - `divi/lib/shared/widgets/person_summary_row.dart`
    - `divi/lib/features/finance/views/resumo_tab.dart`
    - `divi/lib/features/cartao/views/widgets/cartao_card.dart`
    - `divi/lib/features/cartao/views/widgets/cartao_details_sheet.dart`
