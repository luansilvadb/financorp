## 1. Modelo de Dados e Lógica de Negócio

- [x] 1.1 Remover o campo `responsavel` da classe de modelo `Despesa`.
- [x] 1.2 Atualizar o array `despesas` inicial em `_HomeScreenState` removendo o preenchimento de `responsavel` dos dados hardcoded.
- [x] 1.3 Atualizar o método `pendente(String p)` para que a dívida sempre tenha o Luan como referencial, retornando R$ 0,00 para o próprio Luan e cravando o fluxo apenas de terceiros.

## 2. Interface: Formulário de Nova Despesa

- [x] 2.1 Remover a variável de estado `_respForm` de `_HomeScreenState`.
- [x] 2.2 Remover a seção visual de seleção do "Responsável pela Conta" (`_dropdown` respectivo) dentro de `_buildNovaDespesaForm()`.

## 3. Interface: Card de Despesa e Resumo

- [x] 3.1 Em `_buildDespesaCard(Despesa d)`, remover o trecho textual "Resp: X" do subtítulo do cartão.
- [x] 3.2 Ocultar completamente o checkbox (toggle de pagamento) debaixo do nome do Luan nos cartões de `Status de pagamento`, visto que as fatias dele já não envolvem PIX externo/interno de cobrança. Ele só acompanha os toggle checks de terceiros ou pode deixar tudo, mas a regra deve ser limpa.
- [x] 3.3 Atualizar o texto renderizado nos Person Cards (topo da aba Despesas e aba Resumo) garantindo que, quando o nome for Luan, exiba algo do tipo "O seu saldo não é transferido (Tesoureiro)" e as tag lines não digam "falta pagar" se o valor não é de dívida própria.
