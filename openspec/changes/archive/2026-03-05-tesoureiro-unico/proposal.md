## Why

O modelo atual em que cada despesa da casa possui um responsável pelo pagamento gera ineficiência e atrito. Os moradores precisam fazer múltiplos PIX para pessoas diferentes todo final de mês de forma desordenada. Ao centralizar as contas no modelo de "Tesoureiro Único" (Luan realiza o pagamento de todas as contas), Luciana e Giovanna precisarão fazer apenas um único PIX com suas respectivas cotas, consolidando as divisões de despesas fixas com as compras de cartão.

## What Changes

- Remoção do campo `responsavel` do modelo de dados `Despesa` e de todos os formulários e listagens aplicáveis.
- Omitir e remover a lógica individualizada de checagem de quem pagou quem ("Status de pagamento") no detalhe das despesas (cards).
- Refatorar a visualização da tela inicial e da tela Resumo para apontar a dívida de cada morador unicamente para o tesoureiro central.

## Capabilities

### New Capabilities
Nenhuma.

### Modified Capabilities
- `core`: Simplificação do rastreamento de responsabilidade pelas contas. A divisão igualitária por três continua vigente, mas o fluxo de pagamento passa a ser centralizado em uma pessoa em vez de rastreado via campo `responsavel` por despesa.

## Impact

- Modificações extensas na UI principal de `lib/main.dart`, especialmente em `_buildDespesaCard` e `_buildNovaDespesaForm`.
- Refatoração dos cálculos globais de `pendente`, `pagoDesp`, e `totalDesp` dentro do estado principal.
- Deleção das lógicas legadas que consultavam responsabilidade e cruzamento de PIX entre membros diferentes do "Tesoureiro Único".
