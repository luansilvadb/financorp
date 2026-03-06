## ADDED Requirements

### Requirement: Motor de Processamento Single-Pass
O sistema SHALL implementar um motor centralizado que processa todas as métricas financeiras (despesas, pagamentos e cartão) em uma única iteração O(N) sobre os dados brutos.

#### Scenario: Cálculo instantâneo do estado global
- **WHEN** novos dados chegam do Supabase ou ocorre uma mutação local
- **THEN** o motor reconstrói o Record de estado indexado em menos de 16ms

### Requirement: Indexação de Itens para Acesso O(1)
O motor SHALL expor mapas indexados por UUID para que widgets de itens individuais possam acessar seu estado sem percorrer listas.

#### Scenario: Rebuild isolado de card
- **WHEN** o status de pagamento de uma compra no cartão é alterado
- **THEN** apenas o card correspondente àquele ID é reconstruído na UI

### Requirement: Agregação Densa via Records
O sistema SHALL utilizar Records do Dart 3 para representar estados de itens e resumos, eliminando a dependência de classes geradas (`freezed`) para dados efêmeros de UI.

#### Scenario: Redução de overhead de memória
- **WHEN** a lista de despesas contém mais de 100 itens
- **THEN** o consumo de heap de memória é menor do que com instâncias de classes tradicionais
