# AGENTS.md — Arquitetura Viva do Projeto

## Restrições Atuais
- Orçamento de infra: R$ 0/mês (Supabase Free Tier)
- Equipe: 1 dev (AI Agent)
- Prazo próxima entrega: n/a
- Throughput atual: Desenvolvimento inicial

## Stack
| Camada    | Tecnologia | Custo/mês | Justificativa de custo     | Revisar em  |
|-----------|------------|-----------|----------------------------|-------------|
| Banco     | Supabase   | R$ 0      | Plano gratuito atende MVP  | 10k req/dia |
| Hosting   | Vercel     | R$ 0      | Plano gratuito para Web    | n/a         |
| State     | Riverpod   | R$ 0      | Standard p/ Flutter        | n/a         |

## Decisões Arquiteturais
### 2024-04-15 — Implementação de Equilíbrio do Pote (Omega-Settlement)
- **Problema:** Moradores não sabem quem deve pagar a próxima conta para manter a divisão justa em tempo real.
- **Opções consideradas:**
  - A: Resumo Integrado (Baixo custo, Alta visibilidade) - **ESCOLHIDA**
  - B: Modal de Liquidação Dedicado (Custo médio)
- **Escolha:** Opção A. Implementação direta no `finance_engine.dart` com exibição em cards existentes.
- **Custo evitado:** Horas de design de UI complexa e novas tabelas no banco.
- **Débito introduzido:** Nenhum. Lógica O(N) integrada ao motor existente.

## Mapa de Débito Técnico
| ID    | Descrição                       | Custo de pagamento | Impacto atual      | Prazo      |
|-------|---------------------------------|--------------------|--------------------|------------|
| DT-01 | Mock de Auth em alguns fluxos   | 4h                 | Risco de segurança | dd/mm/aaaa |

## Próximas Revisões de Custo
- [ ] [2024-05-15] Validar se o custo total da casa justifica persistência de saldos históricos.
