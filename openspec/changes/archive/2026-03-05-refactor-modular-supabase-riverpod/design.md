# Design: Refactor Modular com Supabase & Riverpod

## Contexto
O aplicativo está consolidado em um único arquivo `main.dart` com estado volátil (`setState`). Para escalar, precisamos de persistência real e uma estrutura que suporte o crescimento.

## Metas / Não-Metas
### Metas
- Implementar infraestrutura para Supabase.
- Migrar lógica de negócio para Riverpod Providers.
- Dividir o código em módulos por funcionalidade (Feature-First).
- Garantir que a UI atual permaneça idêntica visualmente (Pixel Perfect transition).

### Não-Metas
- Mudar o design visual (UI/UX) nesta fase.
- Implementar autenticação completa (será feito em uma Change futura, mas o design deve prever).

## Decisões de Design

### 1. Estrutura de Pastas (Feature-First)
```text
lib/
├── core/
│   ├── supabase/        # Supabase client & init
│   └── utils/           # BRL Formatters, parsers
├── shared/
│   ├── models/          # Despesa, CompraCartao (Data Models)
│   ├── widgets/         # Componentes transversais
│   └── providers/       # month_year_provider
├── features/
│   ├── finance/
│   │   ├── data/        # finance_repository.dart
│   │   ├── providers/   # despesas_provider, pagamentos_provider
│   │   └── views/       # despesas_tab.dart, resumo_tab.dart
│   └── cartao/
│       ├── data/        # cartao_repository.dart
│       ├── providers/   # cartao_provider
│       └── views/       # cartao_tab.dart
└── main.dart            # Root with ProviderScope & HomeScreen Scaffold
```

### 2. Persidência (Supabase Schema)
- **Tabela `despesas`**: `id (uuid)`, `nome (text)`, `valor (numeric)`, `dia_vencimento (int)`.
- **Tabela `compras_cartao`**: `id (uuid)`, `descricao (text)`, `valor (numeric)`, `pessoa (text)`, `data (date)`, `mes (int)`, `ano (int)`.
- **Tabela `pagamentos`**: `id (uuid)`, `despesa_id (fk)`, `pessoa (text)`, `mes (int)`, `ano (int)`, `pago (bool)`.

### 3. Gerenciamento de Estado (Riverpod)
- **`FinanceRepository`**: Classe responsável por todas as chamadas ao Supabase.
- **`despesasProvider`**: `AsyncNotifierProvider` que sincroniza a lista de despesas.
- **`pagamentosProvider`**: Gerencia o estado de "Pago/Pendente" de forma reativa.
- **`resumoProvider`**: Provider calculado que consome dados das despesas e cartões para gerar o sumário consolidado.

## Riscos / Trade-offs
- **Complexidade do Setup**: Requer chaves de API do Supabase funcionando.
- **Migração de Estado**: O desafio é garantir que as funções de cálculo (`totalCartao`, `pendenteCasa`) sejam portadas corretamente para Providers sem introduzir bugs.
- **Offline**: Sem suporte offline inicial; o app exigirá conexão para salvar dados.
