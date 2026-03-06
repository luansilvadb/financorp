# Spec: Hierarchical Card View (Visão Hierárquica)

## Capability Definition
- **Identifier**: `hierarchical-card-view`
- **Description**: Agrupamento visual de despesas/compras por pessoa para eliminar a redundância de dados e oferecer subtotais dinâmicos.

## Requirements

- **Agrupamento por Pessoa** (Aba Cartão):
  - A lista plana de compras deve ser transformada em grupos por pessoa (`Luan`, `Luciana`, `Giovanna`).
  - Cada grupo deve ter um **Header de Grupo** fixo no topo.
  - O Header deve exibir o Nome da Pessoa e o Valor Total acumulado para o mês atual.

- **Header de Grupo Visual**:
  - Estilo: Texto em `kSlate900`, fonte semi-bold, tamanho 14.
  - Subtotal: Exibido à direita com fonte semi-bold em `kPrimaryColor`.
  - Divisores: Linha tênue (`kSlate100`) para separar os grupos visualmente.

- **Interação**:
  - Opcionalmente: O grupo pode ser colapsável via toque no Header.
  - O cabeçalho deve ser omitido se a pessoa não possuir compras para o período selecionado.

## Acceptance Criteria

- [ ] A aba de cartão exibe "Luciana", "Giovanna" e "Luan" como cabeçalhos de grupo.
- [ ] O valor total acumulado por pessoa aparece no cabeçalho.
- [ ] Não há repetição desnecessária de avatares/nomes dentro de cada card do grupo.
- [ ] O resumo do topo (KPIs) permanece funcional e sincronizado com os subtotais dos grupos.
- [ ] A performance de rolagem da lista permanece suave (60 FPS+).
