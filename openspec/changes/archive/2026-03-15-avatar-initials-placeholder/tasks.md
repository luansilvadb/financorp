## 1. Criação do Componente Base

- [x] 1.1 Criar o arquivo `divi/lib/shared/widgets/divi_avatar.dart` com o widget `DiviAvatar`.
- [x] 1.2 Implementar lógica de cores e iniciais no `DiviAvatar` baseada no nome da pessoa.
- [x] 1.3 Suportar parâmetro `radius` ou `size` para diferentes contextos de exibição.

## 2. Refatoração dos Componentes Existentes

- [x] 2.1 Atualizar `ResidentSummaryCard` em `divi/lib/features/finance/views/widgets/resident_summary_card.dart` para usar `DiviAvatar`.
- [x] 2.2 Atualizar `PersonSummaryRow` em `divi/lib/shared/widgets/person_summary_row.dart` para usar `DiviAvatar`.
- [x] 2.3 Atualizar `ResumoTab` em `divi/lib/features/finance/views/resumo_tab.dart` para usar `DiviAvatar`.
- [x] 2.4 Atualizar `CartaoCard` em `divi/lib/features/cartao/views/widgets/cartao_card.dart` para usar `DiviAvatar`.
- [x] 2.5 Atualizar `CartaoDetailsSheet` em `divi/lib/features/cartao/views/widgets/cartao_details_sheet.dart` para usar `DiviAvatar`.

## 3. Limpeza e Finalização

- [x] 3.1 Remover ou comentar a constante `avataresPessoa` em `divi/lib/shared/constants.dart`.
- [x] 3.2 Verificar se há outros usos residuais de `avataresPessoa` no projeto.
- [x] 3.3 Validar a consistência visual em todas as telas afetadas.
