## Why

O termo "Livro" (Book) está sendo substituído por "Contas" (Accounts) para tornar a navegação e o entendimento das funcionalidades mais intuitivos para os usuários. "Contas" reflete melhor a natureza financeira do aplicativo e é um termo mais comum no cotidiano dos usuários brasileiros.

## What Changes

- Renomear o rótulo da aba principal de "LIVRO" para "CONTAS" na barra de navegação inferior.
- Atualizar o texto do botão de submissão no modal de lançamento de "LANÇAR NO LIVRO" para "LANÇAR".
- Atualizar mensagens de confirmação e outros textos da interface que mencionam "livro" para utilizarem "contas".

## Capabilities

### New Capabilities
- Nenhuma.

### Modified Capabilities
- `core`: Atualização de termos de interface de "Livro" para "Contas".

## Impact

- `divi/lib/shared/widgets/paper_bottom_nav.dart`: Alteração do label da primeira aba.
- `divi/lib/features/finance/views/widgets/spike_modal_sheet.dart`: Alteração do texto do botão principal.
- `divi/lib/features/finance/views/statement_screen.dart`: Alteração da mensagem de confirmação de exclusão.
- Possíveis outras referências em strings de UI.
