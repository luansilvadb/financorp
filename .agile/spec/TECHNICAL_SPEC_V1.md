# ESPECIFICAÇÃO TÉCNICA V1.0.0 - Supabase Auth Base

## 1. CONTEXTO E ARQUITETURA
Implementação da camada de autenticação base utilizando `supabase_flutter` e gerenciamento de estado via `Riverpod`.

## 2. CONTRATOS DE API & INTEGRAÇÃO
**Inicialização do Cliente (main.dart):**
```dart
await Supabase.initialize(
  url: dotenv.env['SUPABASE_URL']!,
  anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
);
```

**Interface do AuthRepository:**
```dart
abstract class IAuthRepository {
  Future<AuthResponse> signInWithEmailPassword(String email, String password);
  Future<AuthResponse> signUpWithEmailPassword(String email, String password);
  Future<void> signOut();
  Stream<AuthState> get authStateChanges;
}
```

## 3. GERENCIAMENTO DE ESTADO E CONCORRÊNCIA
- O `AuthNotifier` deve reagir de forma assíncrona às mudanças de estado de sessão provenientes de `supabase.auth.onAuthStateChange`.
- Durante as chamadas assíncronas (ex: signIn), o estado da UI deve transitar para `loading` garantindo a prevenção de execuções concorrentes indesejadas (Race Conditions).

## 4. CENÁRIOS BDD
**Cenário: Login bem sucedido**
- **Dado** que o serviço Supabase está ativo e o usuário possui credenciais válidas.
- **Quando** o método `signInWithEmailPassword` for invocado.
- **Então** o repositório deve retornar uma `AuthResponse` válida.
- **E** o `AuthNotifier` deve propagar a mudança de estado logado para a aplicação.

## 5. TRATAMENTO DE ERROS E EDGE CASES
- Exceções do tipo `AuthException` do Supabase devem ser interceptadas e mapeadas para erros de domínio amigáveis para a UI.
- O sistema deve lidar com falhas de rede de forma graciosa sem travamento total.
