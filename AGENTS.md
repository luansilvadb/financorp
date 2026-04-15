# AGENTS.md — Arquitetura Viva do Projeto

## Identidade: Engenheiro Guardião do Custo
Este projeto é regido pelo princípio de que **custo é o primeiro princípio de qualquer decisão técnica**. Excelência é fazer o máximo com o mínimo.

## Restrições Atuais
- **Orçamento de infra:** R$ 0/mês (Supabase Free Tier / Vercel Hobby)
- **Equipe:** 1 Desenvolvedor (Jules Agent) + Tech Lead (User)
- **Prazo próxima entrega:** N/A (Iterativo)
- **Throughput atual:** < 100 req/dia | 3 usuários ativos (Luan, Luciana, Giovanna)

## Stack
| Camada    | Tecnologia        | Custo/mês | Justificativa de custo                               | Revisar em  |
|-----------|-------------------|-----------|------------------------------------------------------|-------------|
| Framework | Flutter Web       | R$ 0      | Multiplataforma, custo zero de desenvolvimento base  | N/A         |
| Backend   | Supabase          | R$ 0      | Auth + DB + Realtime inclusos no free tier          | 10k usuários|
| State     | Riverpod          | R$ 0      | Gerenciamento reativo eficiente, baixo boilerplate   | N/A         |
| Fontes    | Google Fonts      | R$ 0      | Alta qualidade, custo zero                           | N/A         |
| UI        | Material 3 (Custom)| R$ 0      | Design consistente e acessível                       | N/A         |

## Decisões Arquiteturais
### 2024-05-22 — Transição para Rateio Dinâmico (Acerto de Contas)
- **Problema:** A divisão fixa de 1/3 era rígida e não permitia flexibilidade de aportes individuais.
- **Opções consideradas:**
    - A: Manter 1/3 e criar "ajustes" manuais (Custo: Baixo hoje, alto amanhã por confusão).
    - B: Implementar rateio dinâmico $S = CI - VP$ (Custo: Médio hoje, baixo amanhã).
- **Escolha:** Opção B.
- **Custo evitado:** Retrabalho futuro em reconciliação de contas manual e suporte a novos moradores.
- **Débito introduzido:** Complexidade extra no motor financeiro e migração de banco de dados para `valor_pago`. | **Pagar em:** 2024-05-25

### 2024-05-22 — Refinamento de UX: Atalhos de Pagamento Total
- **Problema:** Usuários que pagam a conta inteira tinham que digitar o valor manual.
- **Solução:** Adicionado botão "Pagar Valor Total" no seletor de valor.
- **Custo:** Mínimo (UI extra). Valor de tempo economizado para o usuário é alto.

### 2024-05-22 — Unificação do Modelo de Saldo (Settlement-First)
- **Problema:** A UI principal ainda mostrava "Total Devido" baseado no 1/3 fixo, causando confusão quando alguém pagava a conta inteira.
- **Solução:** Toda a UI (Ledger, Resumo, Settlement) agora utiliza o `saldoAcerto` ($S = CI - VP$).
- **Custo:** Mínimo. Alinhamento total com as regras de negócio solicitadas.

## Mapa de Débito Técnico
| ID    | Descrição                       | Custo de pagamento | Impacto atual           | Prazo      |
|-------|---------------------------------|--------------------|-------------------------|------------|
| DT-01 | Divisão fixa 1/3 hardcoded      | 4h                 | Rigidez no rateio       | PAGO       |
| DT-02 | Histórico de meses simplificado | 6h                 | Navegação limitada      | DESCONTINUADO|
| DT-03 | Falta de testes de motor        | 3h                 | Risco em cálculos base  | 2024-05-30 |

## Próximas Revisões de Custo
- [ ] [2024-05-30] Validar se o cálculo de "Quem deve para quem" escala para N pessoas sem O(N^2).
- [ ] [2024-06-15] Avaliar uso de Edge Functions se o tráfego de reconciliação aumentar.
