# ROADMAP-001: v4.0.0

**VISÃO TRANSVERSAL:**
Transição do DIVI de um aplicativo de acesso público anônimo para uma plataforma multiusuário segura e autenticada. O "North Star" desta era é a **Confiança e Identidade**, garantindo que cada usuário (Luan, Luciana, Giovanna) tenha sua própria conta, dados protegidos por RLS e uma base sólida para funcionalidades personalizadas futuras.

---

## ÉPICOS DE ALTA RESOLUÇÃO (ERAS)

### [EP-01]: Integração Supabase Auth

- **OBJETIVO:** Implementar fluxo completo de autenticação (Email/Senha ou Magic Link) para garantir identidade única por usuário.
- **STATUS:** [ ]
- **ESCALABILIDADE:** Permite rastreabilidade individual de ações e preferências de perfil.

### [EP-02]: Transição Multiusuário & Perfis

- **OBJETIVO:** Vincular registros de despesas e compras aos UUIDs reais do Supabase Auth, abandonando a lógica de nomes "hardcoded".
- **STATUS:** [ ]
- **ESCALABILIDADE:** Suporta a adição de novos membros à casa ou múltiplos domicílios no futuro.

### [EP-03]: Row Level Security (RLS) & Privacidade

- **OBJETIVO:** Blindar o banco de dados via políticas PostgreSQL, garantindo que usuários só acessem dados de sua própria casa/grupo.
- **STATUS:** [ ]
- **ESCALABILIDADE:** Proteção de dados por design (Security by Design) para conformidade e segurança do usuário.
