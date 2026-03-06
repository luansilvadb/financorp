## 1. Otimização de Performance (Motor Interno)

- [x] 1.1 Refatorar o `resumoProvider` em `lib/features/finance/providers/resumo_provider.dart` para usar indexação via `Map`.
- [x] 1.2 Implementar o widget `CardSkeleton` em `lib/shared/widgets/card_skeleton.dart` com animação de pulsação suave.
- [x] 1.3 Atualizar os métodos `AsyncValue.when` em `DespesasTab` e `CartaoTab` para usar `CardSkeleton` no estado de loading.
- [x] 1.4 Adicionar `ref.keepAlive()` ou lógica de cache no `periodProvider` para evitar saltos de layout na troca de meses.

## 2. Gestos e Atalhos (Dismissible)

- [x] 2.1 Envolver o conteúdo de `CartaoCard` em um widget `Dismissible`.
- [x] 2.2 Implementar o fundo verde (Pago) e vermelho (Excluir) para o `Dismissible` no `CartaoCard`.
- [x] 2.3 Implementar `confirmDismiss` no `CartaoCard` com `HapticFeedback` e `Snap Back` para o pagamento.
- [x] 2.4 Implementar `Dismissible` no `DespesaCard` com a ação de "Quick Pay Luan" (Swipe Right).
- [x] 2.5 Criar um diálogo de confirmação de exclusão reutilizável em `lib/shared/utils/dialogs.dart`.

## 3. Hierarquia e Agrupamento (UI)

- [x] 3.1 Refatorar a renderização da lista em `CartaoTab` para agrupar as compras por pessoa.
- [x] 3.2 Implementar o widget `GroupHeader` para separar as pessoas com Nome e Subtotal.
- [x] 3.3 Otimizar a performance de build do agrupamento (View-Model mapping) dentro da `build` da `CartaoTab`.
- [x] 3.4 (Opcional) Adicionar suporte a colapso de grupos através de um estado local ou provider de UI.

## 4. Validação e Polimento

- [x] 4.1 Testar todos os gestos em dispositivos físicos para garantir a sensibilidade do `HapticFeedback`.
- [x] 4.2 Verificar a precisão dos subtotais dos grupos em relação ao resumo do topo.
- [x] 4.3 Ajustar o timing da animação dos Skeletons para um padrão "Premium".
- [x] 4.4 Garantir que o `Dismissible` não quebre a usabilidade do `GestureDetector` original (Detail Sheet).
