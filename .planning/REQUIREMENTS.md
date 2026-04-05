# Divi - Requirements v1.0

**Milestone:** v1.0 Refatoração UI/UX com Forui.dev  
**Created:** 2026-04-05  
**Status:** Draft (pending roadmap mapping)

---

## INFRA - Infraestrutura Base

### Flutter Upgrade & Setup
- [ ] **INFRA-01**: Upgrade Flutter SDK de ^3.1.0 para 3.41.0+ sem quebrar dependências existentes
- [ ] **INFRA-02**: Adicionar dependência `forui: ^0.18.0` ao pubspec.yaml
- [ ] **INFRA-03**: Configurar FTheme no root do app (main.dart) com tema neutral.dark.touch
- [ ] **INFRA-04**: Adicionar FLocalizations delegates e supportedLocales
- [ ] **INFRA-05**: Remover dependências obsoletas (google_fonts, phosphor_flutter, animations) após migração completa
- [ ] **INFRA-06**: Criar configuração de tema customizado se necessário (via `dart forui theme create`)

### Build & Tooling
- [ ] **INFRA-07**: Verificar compatibilidade de todas as dependências com Flutter 3.41.0+
- [ ] **INFRA-08**: Configurar data-driven fixes para migração automática (`dart fix --apply`)
- [ ] **INFRA-09**: Atualizar CI/CD pipeline para usar Flutter 3.41.0+
- [ ] **INFRA-10**: Documentar processo de rollback em caso de falha crítica

---

## COMP - Componentes Base

### Buttons & Actions
- [ ] **COMP-01**: Migrar todos os botões de ação para FButton mantendo contratos de API
- [ ] **COMP-02**: Preservar estados de loading, disabled e variantes (primary, secondary, danger)
- [ ] **COMP-03**: Manter ícones dos botões usando Forui Icons (substituir phosphor_flutter)

### Cards & Containers
- [ ] **COMP-04**: Substituir CardSkeleton base por FCard/FItemGroup
- [ ] **COMP-05**: Migrar summary cards (saldo, totais) para FCard com layout customizado
- [ ] **COMP-06**: Migrar expense cards para FCard + FItemGroup preservando densidade de informação
- [ ] **COMP-07**: Migrar person cards para FCard + FAvatar
- [ ] **COMP-08**: Manter sombras, bordas arredondadas e espaçamento consistentes com design Forui

### Forms & Inputs
- [ ] **COMP-09**: Migrar todos os TextFields para FTextField com formatters existentes
- [ ] **COMP-10**: Implementar currency input com FTextField + intl formatters
- [ ] **COMP-11**: Migrar date pickers para FCalendar ou manter DateTime picker nativo
- [ ] **COMP-12**: Migrar seletores de pessoa para FSelect/FDropdown
- [ ] **COMP-13**: Preservar validação de forms e mensagens de erro

### Avatars & Badges
- [ ] **COMP-14**: Migrar avatares de usuário para FAvatar com fallback para iniciais
- [ ] **COMP-15**: Implementar badges para contadores (número de despesas, status)
- [ ] **COMP-16**: Usar FBadge para indicadores visuais (pendente, pago, atrasado)

### Alerts & Notifications
- [ ] **COMP-17**: Substituir DiviToasts por FAlert + FToaster
- [ ] **COMP-18**: Implementar variantes de alerta (success, error, warning, info)
- [ ] **COMP-19**: Manter comportamento non-blocking das notificações

---

## NAV - Navegação & Layout

### Bottom Navigation
- [ ] **NAV-01**: Substituir PaperBottomNav por FBottomNavigationBar
- [ ] **NAV-02**: Manter IndexedStack para preservação de estado das tabs
- [ ] **NAV-03**: Adaptar lógica de `_aba` index state para FBottomNavigationBar
- [ ] **NAV-04**: Testar performance de switching entre tabs com Forui nav

### Floating Action Button
- [ ] **NAV-05**: Migrar FAB para FButton com posição e comportamento idênticos
- [ ] **NAV-06**: Manter animação de abertura do modal de adicionar transação

### Period Navigation
- [ ] **NAV-07**: Migrar navegação de período (mês/ano) usando FBreadcrumb ou widget custom com Forui
- [ ] **NAV-08**: Preservar funcionalidade de avançar/retroceder períodos
- [ ] **NAV-09**: Manter indicador visual do período atual selecionado

### Screen Structure
- [ ] **NAV-10**: Envolver telas principais com FScaffold onde apropriado
- [ ] **NAV-11**: Manter estrutura de tabs (Resumo, Despesas) no LedgerScreen
- [ ] **NAV-12**: Preservar navegação para ArchiveScreen e StatementScreen

---

## FORM - Forms & Modals

### Bottom Sheet Migration
- [ ] **FORM-01**: Avaliar FDialog como substituto para SpikeModalSheet
- [ ] **FORM-02**: Se FDialog insuficiente, criar adapter: Forui widgets dentro de custom bottom sheet
- [ ] **FORM-03**: Preservar gesture handling (swipe to dismiss) em modals
- [ ] **FORM-04**: Manter keyboard behavior (auto-scroll, não obscurecer inputs)

### Form Validation
- [ ] **FORM-05**: Integrar validação de forms com FAlert para mensagens de erro
- [ ] **FORM-06**: Exibir erros inline nos campos com FTextField
- [ ] **FORM-07**: Mostrar toast de sucesso/erro após submissão com FToaster
- [ ] **FORM-08**: Validar campos obrigatórios antes de permitir submissão

### Specific Forms
- [ ] **FORM-09**: Migrar form de adicionar despesa (SpikeModalSheet → Forui)
- [ ] **FORM-10**: Migrar form de adicionar compra no cartão
- [ ] **FORM-11**: Migrar form de registrar pagamento
- [ ] **FORM-12**: Migrar form de editar transação existente
- [ ] **FORM-13**: Migrar form de adicionar/editar pessoa
- [ ] **FORM-14**: Migrar confirmação de exclusão para FDialog

### Date & Time Pickers
- [ ] **FORM-15**: Implementar date picker com FCalendar para seleção de datas
- [ ] **FORM-16**: Manter time picker nativo ou integrar com Forui se disponível
- [ ] **FORM-17**: Validar ranges de data (não permitir datas futuras para despesas)

---

## SCREEN - Telas Completas

### LedgerScreen (Tela Principal)
- [ ] **SCREEN-01**: Migrar tab "Resumo" completamente para componentes Forui
- [ ] **SCREEN-02**: Migrar tab "Despesas" completamente para componentes Forui
- [ ] **SCREEN-03**: Preservar cálculos em tempo real do Finance Engine
- [ ] **SCREEN-04**: Manter scroll performance em listas longas de despesas
- [ ] **SCREEN-05**: Implementar empty states com FAlert quando não houver dados
- [ ] **SCREEN-06**: Manter pull-to-refresh para sincronização com Supabase

### ArchiveScreen (Histórico)
- [ ] **SCREEN-07**: Migrar lista de períodos arquivados para FCard + ListView
- [ ] **SCREEN-08**: Manter navegação para períodos específicos
- [ ] **SCREEN-09**: Preservar visualização read-only de períodos passados

### StatementScreen (Extrato)
- [ ] **SCREEN-10**: Migrar extrato detalhado para componentes Forui
- [ ] **SCREEN-11**: Manter filtros e agrupamentos por pessoa/categoria
- [ ] **SCREEN-12**: Preservar export/compartilhamento de extrato se existir

### Shared Components
- [ ] **SCREEN-13**: Migrar todos os widgets compartilhados em lib/shared/widgets/
- [ ] **SCREEN-14**: Atualizar PaperBackground se ainda necessário (ou remover)
- [ ] **SCREEN-15**: Migrar loading skeletons para FSpinner ou shimmer effects

---

## PERF - Performance & Otimização

### Rebuild Optimization
- [ ] **PERF-01**: Minimizar rebuilds desnecessários usando const constructors
- [ ] **PERF-02**: Quebrar widgets grandes em componentes menores para rebuilds granulares
- [ ] **PERF-03**: Usar ConsumerWidget/ConsumerStatefulWidget apropriadamente com Riverpod
- [ ] **PERF-04**: Evitar wrapping excessivo com FTheme (usar apenas no root)

### List Performance
- [ ] **PERF-05**: Usar ListView.builder para listas dinâmicas de despesas
- [ ] **PERF-06**: Implementar paginação ou lazy loading se listas >100 itens
- [ ] **PERF-07**: Profile scroll performance em dispositivos de baixo desempenho
- [ ] **PERF-08**: Otimizar widget tree depth em cards de despesa

### Bundle Size
- [ ] **PERF-09**: Medir bundle size antes e depois da migração
- [ ] **PERF-10**: Remover dependências antigas promptly após migração completa
- [ ] **PERF-11**: Habilitar tree shaking (automático no Flutter release builds)
- [ ] **PERF-12**: Otimizar assets (imagens, fonts) se necessário

### Memory & Rendering
- [ ] **PERF-13**: Monitorar memory usage durante navegação entre telas
- [ ] **PERF-14**: Verificar frame build time (<16ms para 60fps)
- [ ] **PERF-15**: Testar com datasets realistas (50+ pessoas, 200+ despesas/mês)

---

## TEST - Testing & Quality Assurance

### Widget Tests
- [ ] **TEST-01**: Criar golden tests para componentes Forui migrados
- [ ] **TEST-02**: Testar FButton em todos os estados (normal, disabled, loading)
- [ ] **TEST-03**: Testar FCard com diferentes conteúdos e layouts
- [ ] **TEST-04**: Testar FTextField com validação e formatters
- [ ] **TEST-05**: Testar FBottomNavigationBar switching entre tabs

### Integration Tests
- [ ] **TEST-06**: Testar fluxo completo: adicionar despesa → verificar no resumo
- [ ] **TEST-07**: Testar fluxo de pagamento: selecionar despesas → processar pagamento
- [ ] **TEST-08**: Testar navegação de período: avançar/retroceder → dados corretos
- [ ] **TEST-09**: Testar form de compra no cartão: parcelamento → cálculo correto
- [ ] **TEST-10**: Testar archive: acessar período antigo → dados read-only

### Regression Tests
- [ ] **TEST-11**: Verificar cálculos financeiros idênticos aos anteriores
- [ ] **TEST-12**: Confirmar sincronização com Supabase funcionando
- [ ] **TEST-13**: Validar que Riverpod providers continuam operacionais
- [ ] **TEST-14**: Testar offline mode se implementado
- [ ] **TEST-15**: Verificar deep links/app links se existirem

### Performance Tests
- [ ] **TEST-16**: Benchmark rebuild times antes/depois da migração
- [ ] **TEST-17**: Medir scroll FPS em listas longas
- [ ] **TEST-18**: Profile memory usage durante uso prolongado
- [ ] **TEST-19**: Testar cold start time do app
- [ ] **TEST-20**: Verificar hot reload funcionando corretamente

### Manual QA
- [ ] **TEST-21**: QA visual completo em iOS (se aplicável)
- [ ] **TEST-22**: QA visual completo em Android
- [ ] **TEST-23**: Testar em diferentes tamanhos de tela (small, medium, large)
- [ ] **TEST-24**: Validar acessibilidade (font scaling, contrast ratios)
- [ ] **TEST-25**: Beta test com usuários reais antes de produção

---

## DOC - Documentação

### Developer Documentation
- [ ] **DOC-01**: Documentar padrão de migração de widgets custom → Forui
- [ ] **DOC-02**: Criar guia de estilo usando componentes Forui
- [ ] **DOC-03**: Documentar decisões de arquitetura (por que Forui, trade-offs)
- [ ] **DOC-04**: Atualizar README com stack atualizado
- [ ] **DOC-05**: Documentar adapter pattern para preservação de contratos

### Migration Guide
- [ ] **DOC-06**: Criar checklist de migração para futuros desenvolvedores
- [ ] **DOC-07**: Documentar pitfalls encontrados e soluções
- [ ] **DOC-08**: Registrar métricas de performance antes/depois
- [ ] **DOC-09**: Documentar processo de rollback (lições aprendidas)

### API Documentation
- [ ] **DOC-10**: Atualizar documentação de widgets públicos se APIs mudaram
- [ ] **DOC-11**: Documentar novos componentes Forui utilizados
- [ ] **DOC-12]: Criar exemplos de código para padrões comuns

---

## Future Requirements (Deferred to v1.1+)

*Requisitos identificados mas fora do escopo deste milestone:*

### Advanced Forui Features
- [ ] FAccordion para detalhes expansíveis de despesas
- [ ] FAutocomplete para busca rápida de pessoas
- [ ] Custom Forui theme para identidade visual única
- [ ] FTooltip avançado com rich content

### UX Enhancements
- [ ] Animações customizadas além do motion system do Forui
- [ ] Gestures avançados (swipe actions em listas)
- [ ] Haptic feedback integrado com ações UI
- [ ] Micro-interações polidas

### Performance Advanced
- [ ] Code splitting para reduzir initial bundle
- [ ] Deferred loading de features não críticas
- [ ] Image optimization avançada (WebP, caching strategies)
- [ ] Service workers para offline-first (se PWA)

---

## Out of Scope

*Explicitamente excluído deste milestone:*

1. **Novas funcionalidades de negócio** - Apenas refatoração UI, sem adicionar features
2. **Mudanças no Finance Engine** - Lógica de cálculos permanece inalterada
3. **Alterações no schema do Supabase** - Backend não é afetado
4. **Migração de Riverpod para outro state manager** - Riverpod continua
5. **Suporte a web/desktop** - Foco em mobile (iOS/Android)
6. **Internacionalização completa** - Apenas adicionar delegates do Forui, não traduzir app
7. **Dark mode customizado** - Usar temas padrão do Forui
8. **Acessibilidade avançada** - Manter nível atual, sem melhorias significativas
9. **Testes E2E completos** - Apenas testes críticos de integração
10. **CI/CD overhaul** - Apenas atualizar versão do Flutter

---

## Traceability

*Esta seção será preenchida pelo roadmapper com mapeamento REQ → Phase*

| Requirement | Phase | Status | Notes |
|-------------|-------|--------|-------|
| INFRA-01 | TBD | Pending | |
| INFRA-02 | TBD | Pending | |
| ... | ... | ... | ... |

---

*Last updated: 2026-04-05*
*Milestone: v1.0 Refatoração UI/UX com Forui.dev*
*Total requirements: ~100 (85 active + 15 future)*
