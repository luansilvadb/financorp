# Product Context

## Why This Project Exists
The household of Luan, Luciana, and Giovanna suffers from:
- **Late bill payments** caused by decentralized, manual tracking.
- **Credit card confusion** — Luciana and Giovanna use Luan's card for purchases (groceries, pharmacy, etc.) and debts pile up without visibility.
- **Family friction** — Lack of transparency causes constant arguments about who paid what and who owes whom.
- **Burden on Luan** — He doesn't want to manually chase invoices and manage repayments across WhatsApp.

## Problems It Solves
1. **Transparency** — Everyone sees all expenses, who paid, and who hasn't, in real time.
2. **Accountability** — Visual indicators (red/green, ✅/❌) make it immediately clear when someone is behind.
3. **Simplicity** — One-tap actions replace manual spreadsheets and verbal agreements.
4. **Credit card isolation** — Card purchases are tracked separately, making it easy to see how much each person owes Luan at month's end, with the ability to mark items as paid.

## How It Should Work
- Open the app → see your current status immediately (how much you owe, what's paid).
- **Despesas tab**: Lista compacta de alta densidade mostrando nome, valor e status de pagamento consolidado (X/3 pagos). Toque no card abre um Bottom Sheet de detalhes com status por pessoa e botões de Editar/Excluir. Adições via FAB que abre Bottom Sheet dedicado.
- **Cartão tab**: Lista compacta com descrição, pessoa, data e valor. Toque no ícone de status (trailing) alterna pago/pendente instantaneamente com feedback tátil. Toque no corpo do card abre Bottom Sheet de detalhes com Editar/Excluir. Adições via FAB.
- **Resumo tab**: Full monthly breakdown per person — expenses, paid, pending, card debts.
- Month/year selector in the header allows navigating between periods. Inclui navegação de ano explícita, transição inteligente (ex: Dez -> Jan avança o ano) e botão "Hoje" para retorno rápido ao mês corrente.

## User Experience Goals
- **Zero learning curve** — Must be usable by Luciana and Giovanna without training.
- **Minimal friction** — Add an expense in <30 seconds.
- **Immediate clarity** — Colors and emojis communicate status at a glance (green=paid, red=pending).
- **Trust-based** — Payment confirmation is a simple toggle, no complex verification flows.
