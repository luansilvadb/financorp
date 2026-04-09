# 📝 User Story: US001 - Autenticação Supabase Auth

## 📋 Descrição
**Como** um morador da casa
**Eu quero** me autenticar com email e senha
**Para que** meus dados financeiros sejam privados e seguros apenas para o meu grupo.

---

## ✅ Critérios de Aceite (Acceptance Criteria)

### Cenário 1: Login bem-sucedido
- **Dado** que o usuário possui uma conta cadastrada.
- **Quando** ele insere o email e senha corretos na tela de login.
- **Então** ele deve ser redirecionado para o Dashboard e um token de sessão deve ser mantido.

### Cenário 2: Erro de autenticação
- **Dado** que o usuário insere credenciais inválidas.
- **Quando** ele clica em entrar.
- **Então** o sistema deve exibir uma mensagem de erro clara ("Credenciais inválidas") e permanecer na tela de login.

### Cenário 3: Persistência de Sessão
- **Dado** que o usuário já fez login anteriormente.
- **Quando** ele abre o aplicativo após fechá-lo.
- **Então** ele deve cair direto no Dashboard (Session Persistence).

---

## 🔒 Definição de Pronto (DoD Check)
- [ ] Código revisado
- [ ] Testes unitários de Auth passando
- [ ] Documentação técnica atualizada em `specs/`
- [ ] Spec validada pela Mente Brilhante Ω
