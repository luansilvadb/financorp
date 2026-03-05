## 1. Banco de Dados e Modelos

- [x] 1.1 Criar migration SQL para adicionar coluna `pago` na tabela `compras_cartao`
- [x] 1.2 Atualizar o modelo `CompraCartao` em `compra_cartao.dart` (toMap e fromMap)

## 2. Repositório e State Management

- [x] 2.1 Atualizar `CartaoRepository` para garantir que o campo `pago` seja persistido
- [x] 2.2 Implementar método `togglePagamento` no `CartaoNotifier` em `cartao_providers.dart`

## 3. Interface de Usuário (UI)

- [x] 3.1 Refatorar `CartaoTab` para transformar itens da lista em cards expansíveis
- [x] 3.2 Implementar o botão de toggle de pagamento dentro da área expandida do card
- [x] 3.3 Adicionar indicadores visuais de "Pago" (check verde/borda) no card fechado

## 4. Lógica de Negócio e Verificação

- [x] 4.1 Atualizar o `resumoProvider` em `resumo_provider.dart` para considerar apenas compras `!pago`
- [x] 4.2 Validar o cálculo de "Pendente Cartão" para Luciana, Giovanna e Luan
- [x] 4.3 Testar fluxo: criar gasto -> marcar como pago -> observar redução da dívida no resumo
