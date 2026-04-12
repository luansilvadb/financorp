# Product Requirements Document: DIVI

**Product:** DIVI (financorp)
**Version:** 1.0
**Date:** 2026-04-12
**Author:** Luan
**Status:** Draft

---

## 1. Problem Statement

### The Problem

Quando 3+ pessoas dividem contas de uma casa compartilhada, surge atrito social constante: ninguém quer ser "o chato" que fica cobrando quem não pagou. As soluções atuais (WhatsApp, planilhas, Splitwise) ou são caóticas (mensagens perdidas) ou impessoais (apps de finança genéricos). O resultado: pessoas pagam atrasado, outras ficam no prejuízo, e o clima da casa deteriora.

### Target Users

3 residentes específicos de uma casa compartilhada no Brasil:
- **Luan** (azul, `#3B82F6`)
- **Luciana** (rosa, `#EC4899`)
- **Giovanna** (roxo, `#8B5CF6`)

Usuários brasileiros, português, moeda BRL. Tech-savvy moderado. Usam WhatsApp como canal principal de comunicação.

### Current Workarounds

- WhatsApp grupo: mensagens se perdem, sem estrutura
- Memória: "será que eu já paguei?"
- Planilha mental ou anotada: desatualizada, ninguém confia
- Splitwise: registro passivo, não resolve cobrança

---

## 2. Product Vision

DIVI é um app de gestão financeira transparente para casas compartilhadas. Ele elimina o atrito social que surge quando moradores dividem contas. O app responde em 2 segundos: **"Quem deve quanto e quem já pagou?"**

Despesas fixas são divididas igualmente entre residentes. Compras de cartão são atribuídas a quem as fez. O app track quem pagou e quem deve, oferecendo visibilidade financeira completa por pessoa e para a casa.

DIVI não é um registro de dívidas (como Splitwise). É **cobrança automática + paz mental**.

---

## 3. Goals & Success Metrics

### Primary Goals
1. Reduzir conflitos de cobrança de contas entre moradores para zero
2. Garantir que todos saibam seu status financeiro em ≤ 2 segundos
3. Manter dados financeiros atualizados sem dependência de memória humana

### Success Metrics
- **Time-to-conviction:** ≤ 2 segundos (abrir app → saber status)
- **Time-to-relief:** ≤ 5 segundos (com pendência → resolver)
- **Weekly Return Rate orgânico:** > 3x/semana sem push notification
- **% sessões ≤ 5 segundos:** > 70% (entrada, viu, saiu — isso é bom)
- **Resolução sem reabertura:** 100% (marcou como pago, não precisa voltar pra conferir)

---

## 4. Scope

### In Scope (MVP)
- Registro e divisão de despesas fixas mensais
- Registro de compras de cartão de crédito por pessoa
- Tracking de pagamento por pessoa por despesa
- Dashboard de status "estou em dia?" binário
- Visão do grupo (quem está em dia, quem não está)
- Histórico mensal (arquivo de meses passados)
- Statement individual por residente
- Notificações de lembrete de pagamento

### Out of Scope (MVP)
- Autenticação/login (acesso anônimo via Supabase anon key)
- Integração bancária automática
- OCR de recibos
- Múltiplas casas/grupos
- Chat/mensageria interna
- Relatórios gráficos complexos
- Dark mode (fase 2)

---

## 5. Functional Requirements

### FR1: Dashboard de Status
O sistema DEVE exibir um status binário imediato ao abrir: "Em dia" ou "Pendente", visível em ≤ 2 segundos.

### FR2: Visão do Grupo
O sistema DEVE exibir o status coletivo do grupo: "X/Y em dia", onde X é o número de residentes em dia e Y é o total.

### FR3: Registro de Despesa Fixa
O sistema DEVE permitir adicionar despesas fixas mensais com: nome, valor, dia de vencimento, e divisão automática por número de residentes.

### FR4: Registro de Compra de Cartão
O sistema DEVE permitir registrar compras de cartão com: descrição, valor, data, pessoa que comprou, e atribuição a residentes.

### FR5: Marcar Pagamento
O sistema DEVE permitir que um residente marque uma despesa ou compra como paga, com feedback visual imediato e animado.

### FR6: Statement Individual
O sistema DEVE exibir o extrato completo de um residente: todas as suas despesas e compras, com status de pago/pendente, agrupadas por semana.

### FR7: Histórico Mensal
O sistema DEVE permitir navegar entre meses passados, exibindo resumo de cada mês com totais e breakdown por pessoa.

### FR8: Cálculo Automático de Divisão
O sistema DEVE calcular automaticamente a parte de cada residente (despesas fixas ÷ N residentes) e exibir o preview em tempo real durante registro.

### FR9: Notificação de Lembrete
O sistema DEVE enviar notificações de lembrete para residentes com pendências próximas do vencimento.

### FR10: Busca e Filtro
O sistema DEVE permitir buscar despesas por nome/categoria e filtrar por status (pago/pendente).

---

## 6. Non-Functional Requirements

### NFR1: Performance
O app DEVE exibir status em ≤ 2 segundos ao abrir (cold start). Cache-first obrigatório.

### NFR2: Offline Support
O app DEVE funcionar offline para leitura de dados em cache. Escrita offline deve ser queued e sincronizada ao reconectar.

### NFR3: Platform
Mobile-first (iOS + Android via Flutter). Web como acesso secundário (landing page com demo).

### NFR4: Accessibility
Todos os textos DEVE passar WCAG AA (4.5:1 para texto normal, 3:1 para large text). Suporte a Dynamic Type até 200%.

### NFR5: Haptic Feedback
Feedback háptico DEVE acompanhar ações de confirmação de pagamento (HapticFeedback.mediumImpact).

### NFR6: Animação
Animações DEVE respeitar "Reduce Motion" (iOS) / "Remove Animations" (Android) com fallback de fade-in simples.

### NFR7: Data Integrity
Sync correto entre dispositivos é obrigatório. Conflitos de sync devem ser resolvidos com last-write-wins + indicador visual.

### NFR8: Push Notifications
Notificações via FCM + Supabase Edge Functions. Devem ser informativas, não punitivas ("Sua parte é R$X, vence amanhã" não "VOCÊ DEVE R$X").

---

## 7. Technical Constraints

- **Backend:** Supabase (PostgreSQL) com 3 tabelas: `despesas`, `compras_cartao`, `pagamentos`
- **State Management:** Riverpod 3.x com AsyncNotifiers e optimistic updates
- **Data Models:** Freezed + json_serializable
- **UI Framework:** Flutter Material 3 + custom skeuomorphic widgets
- **Deployment:** Vercel (web), Flutter builds (mobile futuro)
- **Sem autenticação:** Acesso anônimo via Supabase anon key com RLS permissivo

---

## 8. UX Design Requirements

*(Extraído do UX Design Specification — ver `ux-design-specification.md`)*

### UX-DR1: Sistema de Cores Emocional
Implementar semáforo emocional: verde `#2A7F62` (pago), âmbar `#D4953B` (pendente), rust `#C2654A` (vencido). NUNCA usar vermelho para culpa.

### UX-DR2: Tipografia
Implementar hierarquia tipográfica: Young Serif (display/headlines), Inter (body/labels/monetary), Space Mono (datas/códigos).

### UX-DR3: Spacing
Implementar spacing scale base 8px: xs=4, sm=8, md=16, lg=24, xl=32, xxl=48.

### UX-DR4: Stamp Animation
Implementar animação de carimbo "PAGO ✅" com: scale 0→1.4→1.0 em 300ms, haptic feedback, bounce, glow dourado de confirmação.

### UX-DR5: ReceiptCard
Implementar card skeuomórfico com CustomClipper para bordas serrilhadas, sombra de "papel deitado", textura sutil.

### UX-DR6: TearLineDivider
Implementar linha de picote orgânica com CustomPainter (segmentos ondulados, não dashes perfeitos).

### UX-DR7: Bottom Sheet First
Todo formulário de entrada abre como bottom sheet (60% altura, radius topo 20px). Nunca tela nova para < 10 campos.

### UX-DR8: Cache-First Loading
Sempre mostrar dados em cache imediatamente. Shimmer skeleton apenas quando não há cache. Timestamp "Atualizado às XX:XX" visível.

### UX-DR9: Empty States
Implementar empty states para: Welcome (primeiro acesso), No Data (lista vazia), No Results (busca), Disconnected (offline). Nunca tela branca.

### UX-DR10: Erros Silenciosos
Erros de validação aparecem inline abaixo do campo. Toast discreto para erros de rede. Nunca modais de erro.

### UX-DR11: Button Hierarchy
Implementar hierarquia: Primary (olive #6B705C, 1 por tela), Secondary (outline), Destructive (rust, exige confirmação), Text links.

### UX-DR12: GroupSummary Widget
Implementar widget "X/Y em dia" com avatares dos residentes, fundo verde/âmbar/rust com 8% opacidade.

### UX-DR13: Pull-Down to Close
Bottom sheets devem ser fecháveis com pull-down (threshold 80px, resistência elástica).

### UX-DR14: FAB para Adicionar
FAB olive #6B705C, 56x56px, canto inferior direito. Presente em todas as telas onde adicionar faz sentido.

---

## 9. Risks & Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| Usuário esquece de registrar compras | Alto | Notificações push de lembrete, registro rápido < 15s |
| Dados desatualizados por falta de sync | Alto | Cache-first, retry automático, indicador de staleness |
| Conflito de sync (2 pessoas editam) | Médio | Last-write-wins + indicador visual de mudança |
| App parece "genérico" | Médio | Skeuomorphic sutil como identidade visual |
| Residentes hardcoded limitam escala | Médio | Modelo de dados suporta N residentes (UI limita a 3 no MVP) |

---

## 10. Open Questions

1. **Jornada 4 (log card purchases):** Qual estratégia para resolver dependência de memória humana? Automação bancária futura?
2. **Múltiplas casas:** Quando expandir para > 1 grupo? Modelo de dados já suporta?
3. **Monetização:** DIVI será gratuito ou pago? Se pago, qual modelo?

---

## 11. Glossary

| Term | Definition |
|------|-----------|
| **Despesa Fixa** | Conta recorrente mensal (luz, internet, gás) dividida igualmente |
| **Compra de Cartão** | Compra avulsa no cartão de crédito, atribuída a pessoa específica |
| **Em dia** | Residente pagou todas as suas partes das despesas do mês |
| **Pendente** | Residente tem pelo menos uma parte não paga |
| **Pote** | Meta mensal de arrecadação (soma de todas as despesas fixas) |
| **Stamp** | Animação de carimbo que confirma pagamento |
| **Mesa Calma** | Direção de design: skeuomorphic sutil, olive primary, metáfora de mesa com recibos |
