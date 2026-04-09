# SPRINT-001: Bootstrap de Autenticação v4.0.0

**META:** Implementação do fluxo base de Supabase Auth e proteção inicial da Splash Screen.

## BACKLOG DE EXECUÇÃO

> ATENÇÃO: LÓGICA EXAUSTIVA, EDGE CASES E BDD

- [ ] **[TSK-01]** Configuração do `SupabaseAuthRepository` e Provider de Auth State.
- [ ] **[TSK-02]** Implementação da `LoginView` minimalista com validação de input.
- [ ] **[TSK-03]** Refatoração da lógica de Splash Screen para redirecionamento condicional (Auth/Unauth).
- [ ] **[TSK-04]** Integração do Auth State com o `DiviEngine` para filtragem inicial por UserID.

## CRITÉRIOS DE ACEITE (AUDITORIA)

- [ ] TESTES UNITÁRIOS/INTEGRAÇÃO DO AUTH REPOSITORY APROVADOS.
- [ ] CONTRATOS DE INTERFACE COM SUPABASE AUTH VALIDADOS.
- [ ] ZERO REGRESSÃO NO FLUXO DE CARREGAMENTO DE DADOS EXISTENTE.
