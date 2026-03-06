# Spec: Performance Engine Optimization (Motor de Alta Performance)

## Capability Definition
- **Identifier**: `performance-engine-optimization`
- **Description**: Otimização profunda do processamento de dados e da percepção de velocidade de carregamento (Skeletons).

## Requirements

- **Otimização do `resumoProvider`**:
  - Transformar as buscas por loops aninhados em buscas via indexação (`Map`).
  - O cálculo de resumos deve ocorrer em tempo O(1) para acesso a cada item individual dentro do loop principal.
  - Implementar um sistema de cache no estado (`AsyncData`) para evitar recalculação em mudanças não relevantes de período.

- **Placeholders de Carregamento (Skeletons)**:
  - Criar o widget `CardSkeleton` que simula a estrutura do `CartaoCard` e `DespesaCard`.
  - Animação de opacidade cíclica (Pulsação suave) em `kSlate100` e `kSlate200`.
  - O `AsyncValue.loading` deve retornar uma lista de `CardSkeleton` em vez de um `CircularProgressIndicator`.

- **Eficiência de Rede**:
  - Garantir que o `periodProvider` não dispare múltiplos fetches idênticos ao alternar meses rapidamente (uso de `ref.keepAlive()` se necessário).
  - Implementar um mecanismo de `debounce` para a escrita no Supabase ao alternar status de pagamento rapidamente.

- **Granularidade e Performance de Dados (O(N))**:
  - Utilizar **Records** e **Switch Expressions** (Dart 3+) para processamento denso de agregados.
  - Implementar o `sumBy` utilitário para garantir agregações em tempo O(N) no nível de Provider.
  - Widgets individuais DEVEM utilizar providers granulares (ID-based) para minimizar reconstruções.

## Acceptance Criteria

- [ ] O app carrega inicialmente com 3-5 skeletons em vez de um spinner.
- [ ] O dashboard de resumo é atualizado instantaneamente ao alternar o status de pagamento de qualquer card.
- [ ] O tempo de cálculo do `resumoProvider` é imperceptível (abaixo de 16ms) mesmo com 100+ registros.
- [ ] A troca de período (mês/ano) ocorre suavemente sem "flicker" de layout.
- [ ] A animação dos skeletons segue um ritmo relaxado (1.5s - 2s por pulsação).
- [ ] Listas de despesas mantêm 60fps constantes durante a rolagem.
- [ ] O número de reconstruções de widgets em listas é minimizado via inscrições por ID.
