## 1. Refatoração de Providers

- [x] 1.1 Atualizar `totalGeralProvider` em `resumo_provider.dart` para incluir gastos no cartão.
- [x] 1.2 Criar (se necessário) ou ajustar o fluxo de dados na `DespesasTab` para ouvir o `cartaoProvider`.

## 2. Ajustes na Interface (UI)

- [x] 2.1 Modificar `DespesasTab` para mesclar a lista de despesas fixas com as compras do cartão.
- [x] 2.2 Implementar o widget `_buildCardCompraCartao` (ou similar) para exibir gastos individuais na lista principal.
- [x] 2.3 Adicionar ícones (ex: 💳) e etiquetas ("Gasto de [Pessoa]") para diferenciar as despesas de cartão das fixas.

## 3. Validação

- [x] 3.1 Verificar se o total no topo da aba Despesas reflete a soma real de tudo que está na lista.
- [x] 3.2 Confirmar se a troca de mês atualiza corretamente tanto as fixas quanto os cartões na mesma tela.
