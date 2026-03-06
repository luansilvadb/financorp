## 1. Engine Core & Records

- [x] 1.1 Criar `lib/core/engine/finance_engine.dart` com as definições de Records para `FinanceState`, `DespesaItem` e `CompraItem`.
- [x] 1.2 Implementar o `financeEngineProvider` que reduz `despesas`, `pagamentos` e `compras` in um único estado indexado O(N).
- [x] 1.3 Implementar a lógica de agregação do resumo consolidado dentro do processamento do motor.

## 2. Refatoração de Providers (Features)

- [x] 2.1 Depreciar o `resumo_provider.dart` e mover as dependências de views para o novo motor.
- [x] 2.2 Atualizar `finance_providers.dart` e `cartao_providers.dart` para expor seletores granulares baseados no motor.
- [x] 2.3 Remover os arquivos de estado `freezed` (`despesa_item_state.dart` e `compra_item_state.dart`).

## 3. UI Optimization

- [x] 3.1 Refatorar `DespesaCard` para usar o seletor granular do motor e o novo Record de estado.
- [x] 3.2 Refatorar `CartaoCard` para usar o seletor granular do motor e o novo Record de estado.
- [x] 3.3 Atualizar `ResumoTab` para consumir o resumo pré-calculado pelo motor (O(1) access).

## 4. Limpeza & Validação

- [x] 4.1 Remover lógicas de filtragem redundantes das views `DespesasTab` e `CartaoTab`.
- [x] 4.2 Verificar a taxa de quadros (60fps) e a ausência de rebuilds em cascata ao alternar status de pagamento.
- [x] 4.3 Rodar `build_runner clean` e `build_runner build` para confirmar a remoção dos arquivos gerados obsoletos.
