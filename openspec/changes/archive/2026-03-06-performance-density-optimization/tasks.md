## 1. Modelagem e Extensões Funcionais

- [x] 1.1 Criar a extensão `sumBy` no diretório `lib/core/utils/` ou em um novo arquivo de extensões.
- [x] 1.2 Definir a classe de estado consolidado `DespesaItemState` (usando `freezed`) para suportar a UI granular.
- [x] 1.3 Definir a classe de estado consolidado `CompraItemState` (usando `freezed`) para a aba de cartões.

## 2. Refatoração do Motor de Estado (Providers)

- [x] 2.1 Refatorar o `resumoProvider` no arquivo `resumo_provider.dart` usando **Records**, **Switch Expressions** e o novo padrão de agregação O(N).
- [x] 2.2 Implementar o `despesaItemProvider.family` no arquivo `finance_providers.dart` para expor o estado consolidado de uma única despesa.
- [x] 2.3 Implementar o `compraItemProvider.family` no arquivo `cartao_providers.dart` para expor o estado consolidado de uma única compra de cartão.

## 3. Refatoração da Camada de Visualização (UI)

- [x] 3.1 Atualizar o `DespesaCard` para receber apenas o `id` da despesa e assistir ao `despesaItemProvider(id)`.
- [x] 3.2 Atualizar o `CompraCard` (ou equivalente na aba de cartão) para utilizar a inscrição granular por ID.
- [x] 3.3 Refatorar o `ResumoTab` para extrair o widget do Pote da Casa em um componente isolado (`PoteStatusCard`), reduzindo reconstruções na aba.
- [x] 3.4 Aplicar o padrão `.select()` no `ResumoTab` para assistir apenas as partes necessárias do `resumoProvider`.
- [x] 3.5 Padronizar avatares no ResumoTab seguindo o estilo do CartaoCard.

## 4. Validação e Limpeza

- [x] 4.1 Verificar a consistência dos cálculos de saldo após a refatoração (testes manuais e unitários se aplicável).
- [x] 4.2 Analisar se restam lógicas de cálculo pesadas dentro de métodos `build` e movê-las para os providers.
- [x] 4.3 Remover códigos e classes auxiliares que se tornaram obsoletos com o uso de Records e Dart 3.
