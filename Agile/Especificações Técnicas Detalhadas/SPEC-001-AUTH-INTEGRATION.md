# SPEC-001: Supabase Auth Integration v4.0.0

- **VERSÃO:** v4.0.0
- **CONTEXTO:** SPRINT-001 / EP-01 (Era da Confiança & Identidade)
- **STATUS:** READY

---

## 1. OBJETIVO TÉCNICO

Estabelecer a camada de identidade do DIVI, permitindo que usuários se autentiquem via email/senha. Isso é o pré-requisito para a implementação de RLS (Row Level Security) e para a personalização da experiência por usuário. O sistema deve gerenciar o estado de autenticação de forma reativa através do Riverpod.

## 2. CONTRATOS E INTERFACES

### 2.1 API / Funções (AuthRepository)

```typescript
abstract class IAuthRepository {
  // Retorna o usuário atual ou null se não autenticado
  User? get currentUser;

  // Stream de mudanças no estado de autenticação
  Stream<AuthState> get authStateChanges;

  // Realiza login com email e senha
  Future<AuthResponse> signIn(String email, String password);

  // Realiza logout
  Future<void> signOut();
}
```

### 2.2 Schema Extensions (PostgreSQL)

```sql
-- Não requer alteração de schema imediata,
-- mas prepara o uso de auth.uid() nas policies.
ALTER TABLE public.despesas ADD COLUMN user_id UUID REFERENCES auth.users(id) DEFAULT auth.uid();
ALTER TABLE public.compras_cartao ADD COLUMN user_id UUID REFERENCES auth.users(id) DEFAULT auth.uid();
```

## 3. LÓGICA DE EXECUÇÃO E REGRAS DE CONCURRÊNCIA

1. **Inicialização:** No boot do app (Splash Screen), o `authProvider` deve verificar a sessão persistente do Supabase.
2. **Reatividade:** O `authProvider` (StateNotifier ou AsyncNotifier) deve emitir estados: `Initial`, `Loading`, `Authenticated(User)`, `Unauthenticated`, `Error(message)`.
3. **Persistência:** A sessão deve ser mantida localmente pelo SDK do Supabase.
4. **Proteção:** Rotas principais e o `DiviEngine` devem aguardar o estado `Authenticated`.

## 4. DIAGRAMA DE SEQUÊNCIA

[USER] -> [LOGIN_VIEW]: Insere Credenciais
[LOGIN_VIEW] -> [AUTH_PROVIDER]: login(email, pass)
[AUTH_PROVIDER] -> [SUPABASE_AUTH]: signInWithPassword()
[SUPABASE_AUTH] -> [POSTGRES]: Valida Credenciais
[SUPABASE_AUTH] <- [POSTGRES]: JWT / Session
[AUTH_PROVIDER] <- [SUPABASE_AUTH]: AuthResponse
[AUTH_PROVIDER] -> [APP_STATE]: Update Authenticated
[LOGIN_VIEW] <- [AUTH_PROVIDER]: Success
[USER] <- [MAIN_VIEW]: Home Screen Exibida

## 5. EDGE CASES E TRATAMENTO DE ERROS

- **CENÁRIO A: Credenciais Inválidas** -> Exibir SnackBar com mensagem amigável (Email ou senha incorretos).
- **CENÁRIO B: Sem Conexão no Login** -> Timeout controlado e erro de rede amigável.
- **CENÁRIO C: Sessão Expirada** -> Redirecionamento automático para a tela de login via listener global.

## 6. BDD (BEHAVIOR DRIVEN DEVELOPMENT)

**CENÁRIO: Login com Sucesso**

- **DADO QUE** o usuário está na tela de login
- **QUANDO** ele insere um email válido e a senha correta
- **ENTÃO** o sistema deve autenticar o usuário e redirecioná-lo para a tela principal (Home)

**CENÁRIO: Tentativa de Acesso Não Autenticado**

- **DADO QUE** o usuário não realizou login
- **QUANDO** o app é inicializado
- **ENTÃO** a Splash Screen deve redirecioná-lo para a tela de Login

**CENÁRIO: Logout do Usuário**

- **DADO QUE** o usuário está autenticado
- **QUANDO** ele clica no botão de "Sair" (Logout)
- **ENTÃO** a sessão deve ser encerrada e o usuário deve voltar para a tela de Login
