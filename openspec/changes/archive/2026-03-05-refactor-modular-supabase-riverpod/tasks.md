# Tasks: Refactor Modular com Supabase & Riverpod

## 1. Setup e Infraestrutura
- [x] 1.1 Adicionar dependências no `pubspec.yaml`: `flutter_riverpod`, `supabase_flutter`.
- [x] 1.2 Criar estrutura de pastas conforme definido no `design.md`.
- [x] 1.3 Configurar inicialização do Supabase no `main.dart`.
- [x] 1.4 Mover utilitários de currency e formatação para `lib/core/utils/`.

## 2. Modelos e Camada de Dados
- [x] 2.1 Criar classes de modelo em `lib/shared/models/` com métodos `fromJson` e `toMap`.
- [x] 2.2 Implementar `FinanceRepository` em `lib/features/finance/data/` para CRUD de despesas e pagamentos.
- [x] 2.3 Implementar `CartaoRepository` em `lib/features/cartao/data/` para gerenciar compras.

## 3. Gerenciamento de Estado (Riverpod)
- [x] 3.1 Criar `month_year_provider.dart` para controle do período global.
- [x] 3.2 Criar `despesas_provider.dart` e `pagamentos_provider.dart` usando `AsyncNotifier`.
- [x] 3.3 Criar `cartao_provider.dart` para gerenciar as compras do mês.
- [x] 3.4 Implementar `resumo_provider.dart` que consolida os cálculos para o dashboard.

## 4. Migração de UI e Modularização
- [x] 4.1 Extrair `_buildDespesasTab` para `lib/features/finance/views/despesas_tab.dart`.
- [x] 4.2 Extrair `_buildCartaoTab` para `lib/features/cartao/views/cartao_tab.dart`.
- [x] 4.3 Extrair `_buildResumoTab` para `lib/features/finance/views/resumo_tab.dart`.
- [x] 4.4 Refatorar `HomeScreen` em `lib/main.dart` para ser um `ConsumerWidget` e delegar para os novos módulos.
- [x] 4.5 Verificar paridade visual e funcional completa.
