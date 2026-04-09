# 🧠 Elicitação Avançada: Nova Era / Greenfield

> **Status**: [🟤 Brownfield Recursivo]
> **Foco**: Transição para Identidade, Segurança e Multi-usuário.

---

## 🛠️ Proposta de Arquitetura (Mente Brilhante Ω)

O agente analisou o contexto e propõe as seguintes rotas. Escolha uma ou ajuste a preferida:

### Opção 1: Security First (Recomendada)
- **Foco**: Autenticação Supabase e RLS.
- **Stack**: Supabase Auth, PostgreSQL RLS, Riverpod.
- **Prós**: Resolve o maior risco do projeto (privacidade de dados) e permite escala.
- **Contras**: Complexidade inicial de configuração de políticas de banco.

### Opção 2: Feature Rich MVP
- **Foco**: Upload de recibos e notificações.
- **Stack**: Supabase Storage, Firebase Cloud Messaging.
- **Prós**: Valor utilitário imediato para as moradoras.
- **Contras**: Dados continuam expostos e desprotegidos (acesso anon).

---

## 📅 Esboço Inicial de Roadmap (Épicos)
1. [x] **Fase 0**: Setup da Mente Brilhante Ω (Atual)
2. [ ] **Fase 1**: Identidade & Segurança (Era da Confiança)
3. [ ] **Fase 2**: Evidências & Auditoria (Recibos)

---

## ⚡ Decisões Instantâneas (Aprovação Rápida)
*Responda com 'Sim' para as propostas ou 'Não' para descartar:*
- [x] Adotar Supabase Auth para controle de acesso? (SIM)
- [x] Priorizar RLS para isolamento de dados de moradia? (SIM)

---
*Aprovado pelo Tech Lead para inicializar o diretório .agile/*
