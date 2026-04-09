# Diretrizes de Especificação Técnica (Verbosidade Exaustiva)

Para que a **Mente Brilhante Ω** funcione, o Tech Lead (usuário) não deve ter dúvidas sobre a implementação. As especificações em `.agile/spec/` devem conter:

## 1. Contratos de Interface (API/Types)
- **Definição exata**: Use blocos de código TypeScript/Python Typed.
- **Exemplo**:
  ```typescript
  interface UserProfile {
    id: string; // UUID v4
    email: string; // Validated via regex
    preferences?: JSON; // Optional, default {}
  }
  ```

## 2. Diagramas de Fluxo e Sequência (Texto/Mermaid)
- **Ordem exata**: Descreva o "Happy Path" e os caminhos de erro.
- **Exemplo**:
  ```mermaid
  sequenceDiagram
    Client->>API: POST /login
    API->>DB: Validate Creds
    DB-->>API: Success
    API-->>Client: JWT Token
  ```

## 3. Regras de Negócio e Casos de Borda
- **Não economize palavras**: Documente o que acontece se o banco estiver fora do ar ou se o usuário enviar dados duplicados.

## 4. Testes BDD (Behavior Driven Development)
- **Cenário**: Login bem sucedido.
- **Dado** que o usuário existe no banco com senha '123'.
- **Quando** ele envia post para `/login` com '123'.
- **Então** o status deve ser 200 e o token deve ser retornado.

### Padrão de Nomenclatura:
`TECHNICAL_SPEC_V[X]_[DESCRIÇÃO].md`
(Devem ser salvas obrigatoriamente em `.agile/spec/`)
