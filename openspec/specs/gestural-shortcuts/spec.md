# Spec: Gestural Shortcuts (Gestos de Atalho)

## Capability Definition
- **Identifier**: `gestural-shortcuts`
- **Description**: Atalhos gestuais baseados em swipe para ações comuns sem necessidade de toque em botões ou abertura de menus.

## Requirements

- **Swipe Right (Start-to-End)**:
  - No `CartaoCard`: Deve alternar o status `pago`/`pendente` da compra.
  - No `DespesaCard`: Deve marcar apenas a parte do pagador principal (Luan) como `pago` para o mês atual.
  - **Snap Back**: Após a ativação bem-sucedida, o card deve retornar suavemente para a posição central.
  - **Visual**: Fundo verde suave (`kGreen500.withOpacity(0.1)`) com ícone `PhosphorIcons.checkCircle(fill)` centralizado à esquerda.

- **Swipe Left (End-to-Start)**:
  - Em ambos os cards: Deve acionar a exclusão do item.
  - **Confirmação**: Exibir um `AlertDialog` de confirmação para evitar perdas acidentais de dados.
  - **Visual**: Fundo vermelho suave (`kRed500.withOpacity(0.1)`) com ícone `PhosphorIcons.trash` centralizado à direita.

- **Feedback**:
  - Acionar `HapticFeedback.lightImpact()` ao atingir o limite de ativação do gesto.
  - O `threshold` de ativação deve ser de `0.4` para evitar ativações acidentais.

## Acceptance Criteria

- [ ] Deslizar um `CartaoCard` para a direita alterna o status de pagamento instantaneamente (Optimistic UI).
- [ ] O card deslizado para a direita volta para a posição original sem sumir da lista.
- [ ] Deslizar para a esquerda abre o diálogo de confirmação de exclusão.
- [ ] Ação de "Quick Pay Luan" funciona para despesas fixas via swipe right.
- [ ] Vibrar levemente o dispositivo ao ativar qualquer gesto.
