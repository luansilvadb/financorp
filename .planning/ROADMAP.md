# Divi - Roadmap v1.0

**Milestone:** v1.0 Refatoração UI/UX com Forui.dev  
**Created:** 2026-04-05  
**Total Phases:** 8  
**Total Requirements:** 113 (85 active + 15 future + 13 docs)  
**Status:** Ready for execution

---

## Phase Overview

| # | Phase | Goal | Requirements | Success Criteria | Depends On |
|---|-------|------|--------------|------------------|------------|
| 1 | Flutter Upgrade & Foundation | Upgrade Flutter SDK e configurar Forui.dev no root do app | INFRA-01 a INFRA-10 | App compila e roda com Flutter 3.41.0+ e FTheme ativo | — |
| 2 | Base Components Migration | Migrar buttons, cards, inputs, avatars e alerts para Forui | COMP-01 a COMP-19 | Todos componentes base renderizam corretamente com Forui | Phase 1 |
| 3 | Navigation & Layout | Migrar bottom nav, FAB, period navigation e estrutura de telas | NAV-01 a NAV-12 | Navegação funciona idêntica ao anterior com componentes Forui | Phase 2 |
| 4 | Forms & Modals | Migrar bottom sheets, validação e forms específicos | FORM-01 a FORM-17 | Todos os forms abrem, validam e submetem corretamente | Phase 2, 3 |
| 5 | LedgerScreen Complete | Migrar tela principal (tabs Resumo e Despesas) completamente | SCREEN-01 a SCREEN-06, PERF-01 a PERF-08 | LedgerScreen funcional com performance igual ou superior | Phase 2, 3, 4 |
| 6 | Remaining Screens & Shared | Migrar ArchiveScreen, StatementScreen e widgets compartilhados | SCREEN-07 a SCREEN-15 | Todas as telas secundárias funcionais | Phase 5 |
| 7 | Testing & QA | Executar suite completa de testes e QA manual | TEST-01 a TEST-25 | Zero regressões críticas, performance validated | Phase 6 |
| 8 | Cleanup & Documentation | Remover deps antigas, otimizar bundle, documentar migração | PERF-09 a PERF-15, DOC-01 a DOC-12 | Bundle size otimizado, documentação completa | Phase 7 |

---

## Phase 1: Flutter Upgrade & Foundation

**Goal:** Upgrade Flutter SDK de ^3.1.0 para 3.41.0+ e configurar Forui.dev no root do app sem quebrar funcionalidades existentes.

**Requirements:**
- INFRA-01: Upgrade Flutter SDK de ^3.1.0 para 3.41.0+ sem quebrar dependências existentes
- INFRA-02: Adicionar dependência `forui: ^0.18.0` ao pubspec.yaml
- INFRA-03: Configurar FTheme no root do app (main.dart) com tema neutral.dark.touch
- INFRA-04: Adicionar FLocalizations delegates e supportedLocales
- INFRA-05: Remover dependências obsoletas (google_fonts, phosphor_flutter, animations) após migração completa
- INFRA-06: Criar configuração de tema customizado se necessário (via `dart forui theme create`)
- INFRA-07: Verificar compatibilidade de todas as dependências com Flutter 3.41.0+
- INFRA-08: Configurar data-driven fixes para migração automática (`dart fix --apply`)
- INFRA-09: Atualizar CI/CD pipeline para usar Flutter 3.41.0+
- INFRA-10: Documentar processo de rollback em caso de falha crítica

**Success Criteria:**
1. App compila e executa em emulator/device com Flutter 3.41.0+
2. FTheme wrapper ativo no MaterialApp sem erros no console
3. Tema neutral.dark.touch aplicado (verificar visualmente cores e tipografia)
4. Todas as telas existentes ainda renderizam (mesmo com widgets antigos)
5. Riverpod providers continuam funcionando (testar navegação entre tabs)
6. Supabase integration operacional (testar fetch de dados)
7. Hot reload funciona corretamente após mudanças de tema
8. Build release succeeds sem warnings críticos
9. Rollback documentado e testado em branch separada
10. CI/CD pipeline atualizada e passing

**Estimated Effort:** 3-5 dias

---

## Phase 2: Base Components Migration

**Goal:** Migrar todos os componentes base (buttons, cards, inputs, avatars, alerts) para Forui.dev mantendo contratos de API e comportamento visual consistente.

**Requirements:**
- COMP-01: Migrar todos os botões de ação para FButton mantendo contratos de API
- COMP-02: Preservar estados de loading, disabled e variantes (primary, secondary, danger)
- COMP-03: Manter ícones dos botões usando Forui Icons (substituir phosphor_flutter)
- COMP-04: Substituir CardSkeleton base por FCard/FItemGroup
- COMP-05: Migrar summary cards (saldo, totais) para FCard com layout customizado
- COMP-06: Migrar expense cards para FCard + FItemGroup preservando densidade de informação
- COMP-07: Migrar person cards para FCard + FAvatar
- COMP-08: Manter sombras, bordas arredondadas e espaçamento consistentes com design Forui
- COMP-09: Migrar todos os TextFields para FTextField com formatters existentes
- COMP-10: Implementar currency input com FTextField + intl formatters
- COMP-11: Migrar date pickers para FCalendar ou manter DateTime picker nativo
- COMP-12: Migrar seletores de pessoa para FSelect/FDropdown
- COMP-13: Preservar validação de forms e mensagens de erro
- COMP-14: Migrar avatares de usuário para FAvatar com fallback para iniciais
- COMP-15: Implementar badges para contadores (número de despesas, status)
- COMP-16: Usar FBadge para indicadores visuais (pendente, pago, atrasado)
- COMP-17: Substituir DiviToasts por FAlert + FToaster
- COMP-18: Implementar variantes de alerta (success, error, warning, info)
- COMP-19: Manter comportamento non-blocking das notificações

**Success Criteria:**
1. Todos os botões na app usam FButton e respondem a toques
2. Estados de button (disabled, loading) visualmente distintos e funcionais
3. Ícones renderizados via Forui Icons (phosphor_flutter removido)
4. Cards exibem conteúdo com espaçamento e sombras consistentes
5. Summary cards mostram saldo/totais com formatação correta
6. Expense cards mantêm densidade de informação (não perder dados visíveis)
7. Person cards exibem avatar + nome corretamente
8. TextFields aceitam input e aplicam formatters (currency, date)
9. Validação de forms exibe erros inline nos campos
10. Avatares mostram imagem ou iniciais como fallback
11. Badges exibem contadores e status visualmente claros
12. Toasts/alerts aparecem e desaparecem automaticamente
13. Variantes de alerta (success/error/warning/info) com cores distintas
14. Widget tests passing para todos componentes migrados
15. Visual QA: nenhum componente com layout broken ou overflow

**Estimated Effort:** 5-7 dias

---

## Phase 3: Navigation & Layout

**Goal:** Migrar sistema de navegação (bottom nav, FAB, period navigation) e estrutura de telas para componentes Forui mantendo UX idêntica.

**Requirements:**
- NAV-01: Substituir PaperBottomNav por FBottomNavigationBar
- NAV-02: Manter IndexedStack para preservação de estado das tabs
- NAV-03: Adaptar lógica de `_aba` index state para FBottomNavigationBar
- NAV-04: Testar performance de switching entre tabs com Forui nav
- NAV-05: Migrar FAB para FButton com posição e comportamento idênticos
- NAV-06: Manter animação de abertura do modal de adicionar transação
- NAV-07: Migrar navegação de período (mês/ano) usando FBreadcrumb ou widget custom com Forui
- NAV-08: Preservar funcionalidade de avançar/retroceder períodos
- NAV-09: Manter indicador visual do período atual selecionado
- NAV-10: Envolver telas principais com FScaffold onde apropriado
- NAV-11: Manter estrutura de tabs (Resumo, Despesas) no LedgerScreen
- NAV-12: Preservar navegação para ArchiveScreen e StatementScreen

**Success Criteria:**
1. Bottom navigation bar renderiza com 2 tabs (Ledger, Archive)
2. Tab switching preserva estado (scroll position, dados carregados)
3. Índice de tab ativa sincronizado com estado `_aba`
4. Performance de switching <100ms (sem lag perceptível)
5. FAB posicionado corretamente (bottom-right) e abre modal ao tocar
6. Animação de FAB para modal suave e consistente
7. Period navigation permite avançar/retroceder meses
8. Período atual destacado visualmente (bold, cor diferente)
9. FScaffold aplicado em telas principais sem quebrar layout
10. Estrutura de tabs no LedgerScreen intacta (Resumo, Despesas)
11. Navegação para ArchiveScreen funciona via bottom nav
12. Deep links para StatementScreen funcionam se existirem
13. No visual glitches durante navigation transitions
14. Back button behavior correto em Android
15. Integration test: navegar entre todas as telas sem crashes

**Estimated Effort:** 3-4 dias

---

## Phase 4: Forms & Modals

**Goal:** Migrar sistema de forms e modals (bottom sheets, validação, date pickers) para Forui mantendo UX fluida e validation robusta.

**Requirements:**
- FORM-01: Avaliar FDialog como substituto para SpikeModalSheet
- FORM-02: Se FDialog insuficiente, criar adapter: Forui widgets dentro de custom bottom sheet
- FORM-03: Preservar gesture handling (swipe to dismiss) em modals
- FORM-04: Manter keyboard behavior (auto-scroll, não obscurecer inputs)
- FORM-05: Integrar validação de forms com FAlert para mensagens de erro
- FORM-06: Exibir erros inline nos campos com FTextField
- FORM-07: Mostrar toast de sucesso/erro após submissão com FToaster
- FORM-08: Validar campos obrigatórios antes de permitir submissão
- FORM-09: Migrar form de adicionar despesa (SpikeModalSheet → Forui)
- FORM-10: Migrar form de adicionar compra no cartão
- FORM-11: Migrar form de registrar pagamento
- FORM-12: Migrar form de editar transação existente
- FORM-13: Migrar form de adicionar/editar pessoa
- FORM-14: Migrar confirmação de exclusão para FDialog
- FORM-15: Implementar date picker com FCalendar para seleção de datas
- FORM-16: Manter time picker nativo ou integrar com Forui se disponível
- FORM-17: Validar ranges de data (não permitir datas futuras para despesas)

**Success Criteria:**
1. Decisão documentada: FDialog vs custom bottom sheet (com rationale)
2. Adapter implementado se necessário (Forui widgets em custom modal)
3. Swipe to dismiss funciona em todos os modals
4. Keyboard não obscurece inputs focados (auto-scroll funcional)
5. Validação exibe erros inline vermelhos abaixo dos campos
6. FAlert mostra mensagens de erro claras e específicas
7. FToaster exibe feedback de sucesso/erro após submissão
8. Campos obrigatórios bloqueiam submissão se vazios
9. Form de adicionar despesa abre, valida e salva corretamente
10. Form de compra no cartão calcula parcelas corretamente
11. Form de pagamento processa e atualiza saldos
12. Form de editar transação carrega dados existentes e permite update
13. Form de pessoa adiciona/edita membros da casa
14. Confirmação de exclusão previne ações acidentais
15. Date picker abre e permite seleção intuitiva
16. Time picker funcional para horários de transações
17. Validação de data bloqueia datas futuras para despesas
18. All forms tested end-to-end com dados válidos e inválidos
19. No crashes ou freezes durante interação com forms
20. Visual QA: forms responsivos em diferentes screen sizes

**Estimated Effort:** 5-7 dias

---

## Phase 5: LedgerScreen Complete

**Goal:** Migrar tela principal (LedgerScreen) completamente para Forui com tabs Resumo e Despesas funcionais, mantendo performance e cálculos em tempo real.

**Requirements:**
- SCREEN-01: Migrar tab "Resumo" completamente para componentes Forui
- SCREEN-02: Migrar tab "Despesas" completamente para componentes Forui
- SCREEN-03: Preservar cálculos em tempo real do Finance Engine
- SCREEN-04: Manter scroll performance em listas longas de despesas
- SCREEN-05: Implementar empty states com FAlert quando não houver dados
- SCREEN-06: Manter pull-to-refresh para sincronização com Supabase
- PERF-01: Minimizar rebuilds desnecessários usando const constructors
- PERF-02: Quebrar widgets grandes em componentes menores para rebuilds granulares
- PERF-03: Usar ConsumerWidget/ConsumerStatefulWidget apropriadamente com Riverpod
- PERF-04: Evitar wrapping excessivo com FTheme (usar apenas no root)
- PERF-05: Usar ListView.builder para listas dinâmicas de despesas
- PERF-06: Implementar paginação ou lazy loading se listas >100 itens
- PERF-07: Profile scroll performance em dispositivos de baixo desempenho
- PERF-08: Otimizar widget tree depth em cards de despesa

**Success Criteria:**
1. Tab "Resumo" exibe summary cards com saldos e totais corretos
2. Tab "Despesas" lista todas as despesas do período com filtros
3. Finance Engine calcula totais em tempo real (sem discrepâncias)
4. Scroll em listas de 100+ despesas mantém 60fps
5. Empty state exibe FAlert informativo quando sem dados
6. Pull-to-refresh sincroniza com Supabase e atualiza UI
7. Const constructors usados em widgets estáticos
8. Widgets quebrados em componentes reutilizáveis (<300 lines cada)
9. ConsumerWidget usado corretamente (rebuilds apenas quando necessário)
10. FTheme apenas no root (verificar widget tree)
11. ListView.builder implementado para dynamic lists
12. Paginação ou lazy loading ativo se >100 items
13. Scroll performance acceptable em device entry-level (teste real)
14. Widget tree depth otimizado (<15 levels em cards)
15. Benchmark: rebuild times <16ms (60fps maintained)
16. Memory usage stable during extended use (<200MB)
17. No jank ou frame drops durante scroll rápido
18. Visual consistency: todos elementos alinhados e proporcionais
19. Integration test: adicionar despesa → aparece na lista → resumo atualiza
20. Regression test: cálculos idênticos à versão anterior

**Estimated Effort:** 5-7 dias

---

## Phase 6: Remaining Screens & Shared

**Goal:** Migrar telas secundárias (ArchiveScreen, StatementScreen) e todos os widgets compartilhados para completar a cobertura de UI.

**Requirements:**
- SCREEN-07: Migrar lista de períodos arquivados para FCard + ListView
- SCREEN-08: Manter navegação para períodos específicos
- SCREEN-09: Preservar visualização read-only de períodos passados
- SCREEN-10: Migrar extrato detalhado para componentes Forui
- SCREEN-11: Manter filtros e agrupamentos por pessoa/categoria
- SCREEN-12: Preservar export/compartilhamento de extrato se existir
- SCREEN-13: Migrar todos os widgets compartilhados em lib/shared/widgets/
- SCREEN-14: Atualizar PaperBackground se ainda necessário (ou remover)
- SCREEN-15: Migrar loading skeletons para FSpinner ou shimmer effects

**Success Criteria:**
1. ArchiveScreen lista períodos arquivados em cards clicáveis
2. Tap em período arquvado navega para visualização read-only
3. Períodos passados mostram dados mas não permitem edição
4. StatementScreen exibe extrato detalhado com filtros funcionais
5. Filtros por pessoa/categoria refinam resultados corretamente
6. Export/compartilhamento de extrato funciona se feature existe
7. Todos widgets em lib/shared/widgets/ migrados para Forui
8. PaperBackground removido ou atualizado para usar Forui tokens
9. Loading states usam FSpinner ou shimmer effects nativos
10. No deprecated widgets remaining em código
11. Visual consistency: todas telas seguem mesmo design system
12. Navigation flows: Archive → período específico → back funciona
13. Statement filters: aplicar/remover filtros atualiza UI instantaneamente
14. Shared widgets reutilizáveis em múltiplas telas sem issues
15. Integration test: navegar por todas as telas sem crashes
16. Performance: ArchiveScreen carrega em <500ms
17. Performance: StatementScreen filtra em <200ms
18. Accessibility: font scaling não quebra layouts
19. Visual QA: screenshots comparativos antes/depois aprovados
20. Code review: zero warnings de linter relacionados a UI

**Estimated Effort:** 4-5 dias

---

## Phase 7: Testing & QA

**Goal:** Executar suite completa de testes automatizados e QA manual para garantir zero regressões críticas e performance validated.

**Requirements:**
- TEST-01: Criar golden tests para componentes Forui migrados
- TEST-02: Testar FButton em todos os estados (normal, disabled, loading)
- TEST-03: Testar FCard com diferentes conteúdos e layouts
- TEST-04: Testar FTextField com validação e formatters
- TEST-05: Testar FBottomNavigationBar switching entre tabs
- TEST-06: Testar fluxo completo: adicionar despesa → verificar no resumo
- TEST-07: Testar fluxo de pagamento: selecionar despesas → processar pagamento
- TEST-08: Testar navegação de período: avançar/retroceder → dados corretos
- TEST-09: Testar form de compra no cartão: parcelamento → cálculo correto
- TEST-10: Testar archive: acessar período antigo → dados read-only
- TEST-11: Verificar cálculos financeiros idênticos aos anteriores
- TEST-12: Confirmar sincronização com Supabase funcionando
- TEST-13: Validar que Riverpod providers continuam operacionais
- TEST-14: Testar offline mode se implementado
- TEST-15: Verificar deep links/app links se existirem
- TEST-16: Benchmark rebuild times antes/depois da migração
- TEST-17: Medir scroll FPS em listas longas
- TEST-18: Profile memory usage durante uso prolongado
- TEST-19: Testar cold start time do app
- TEST-20: Verificar hot reload funcionando corretamente
- TEST-21: QA visual completo em iOS (se aplicável)
- TEST-22: QA visual completo em Android
- TEST-23: Testar em diferentes tamanhos de tela (small, medium, large)
- TEST-24: Validar acessibilidade (font scaling, contrast ratios)
- TEST-25: Beta test com usuários reais antes de produção

**Success Criteria:**
1. Golden tests criados e passing para 10+ componentes críticos
2. FButton tests: todos os estados cobertos e passing
3. FCard tests: diferentes layouts validados
4. FTextField tests: validação e formatters funcionando
5. Bottom nav tests: tab switching sem errors
6. Integration test: fluxo adicionar despesa end-to-end passing
7. Integration test: fluxo de pagamento complete passing
8. Integration test: period navigation com dados corretos
9. Integration test: parcelamento calcula corretamente
10. Integration test: archive read-only enforced
11. Cálculos financeiros: diff = 0 vs versão anterior (tolerância ±0.01)
12. Supabase sync: CRUD operations successful
13. Riverpod providers: all watchers updating correctly
14. Offline mode: cached data accessible if implemented
15. Deep links: navigate to correct screens if exist
16. Rebuild times: improved or same as before (≤ previous baseline)
17. Scroll FPS: ≥55fps em listas de 100+ items
18. Memory usage: <200MB after 10min de uso contínuo
19. Cold start: <3s do launch ao first screen
20. Hot reload: works without full restart
21. iOS QA: zero visual regressions (if applicable)
22. Android QA: zero visual regressions across devices
23. Screen sizes: layouts adapt correctly (small/medium/large)
24. Accessibility: font scaling 150% não quebra UI, contrast WCAG AA
25. Beta test: ≥80% positive feedback, zero critical bugs reported

**Estimated Effort:** 5-7 dias

---

## Phase 8: Cleanup & Documentation

**Goal:** Remover dependências antigas, otimizar bundle size, e documentar completamente o processo de migração para referência futura.

**Requirements:**
- PERF-09: Medir bundle size antes e depois da migração
- PERF-10: Remover dependências antigas promptly após migração completa
- PERF-11: Habilitar tree shaking (automático no Flutter release builds)
- PERF-12: Otimizar assets (imagens, fonts) se necessário
- PERF-13: Monitorar memory usage durante navegação entre telas
- PERF-14: Verificar frame build time (<16ms para 60fps)
- PERF-15: Testar com datasets realistas (50+ pessoas, 200+ despesas/mês)
- DOC-01: Documentar padrão de migração de widgets custom → Forui
- DOC-02: Criar guia de estilo usando componentes Forui
- DOC-03: Documentar decisões de arquitetura (por que Forui, trade-offs)
- DOC-04: Atualizar README com stack atualizado
- DOC-05: Documentar adapter pattern para preservação de contratos
- DOC-06: Criar checklist de migração para futuros desenvolvedores
- DOC-07: Documentar pitfalls encontrados e soluções
- DOC-08: Registrar métricas de performance antes/depois
- DOC-09: Documentar processo de rollback (lições aprendidas)
- DOC-10: Atualizar documentação de widgets públicos se APIs mudaram
- DOC-11: Documentar novos componentes Forui utilizados
- DOC-12: Criar exemplos de código para padrões comuns

**Success Criteria:**
1. Bundle size medido e documentado (antes vs depois)
2. Dependências antigas removidas: google_fonts, phosphor_flutter, animations
3. Tree shaking habilitado e verificado em release build
4. Assets otimizados se necessário (compressão, formatos modernos)
5. Memory usage profiled e within acceptable range (<200MB)
6. Frame build time consistently <16ms (60fps maintained)
7. Stress test: 50+ pessoas, 200+ despesas/mês performa bem
8. Migration pattern documentado com exemplos de código
9. Style guide criado mostrando uso correto de componentes Forui
10. Architecture decisions registrados (ADR ou seção em PROJECT.md)
11. README atualizado com nova stack (Forui, Flutter 3.41+)
12. Adapter pattern documentado com rationale e exemplos
13. Migration checklist criado para reuso futuro
14. Pitfalls documentados com soluções aplicadas
15. Performance metrics registradas (before/after comparison)
16. Rollback process documentado com lessons learned
17. Public API changes documented se houve breaking changes
18. Forui components catalog criado listando todos utilizados
19. Code examples provided para patterns comuns (forms, lists, cards)
20. Final code review: zero TODOs related to migration remaining

**Estimated Effort:** 3-4 dias

---

## Future Requirements (v1.1+)

*Estes requisitos foram identificados mas deferidos para milestones futuros:*

### Advanced Forui Features
- FAccordion para detalhes expansíveis de despesas
- FAutocomplete para busca rápida de pessoas
- Custom Forui theme para identidade visual única
- FTooltip avançado com rich content

### UX Enhancements
- Animações customizadas além do motion system do Forui
- Gestures avançados (swipe actions em listas)
- Haptic feedback integrado com ações UI
- Micro-interações polidas

### Performance Advanced
- Code splitting para reduzir initial bundle
- Deferred loading de features não críticas
- Image optimization avançada (WebP, caching strategies)
- Service workers para offline-first (se PWA)

---

## Dependencies Graph

```
Phase 1 (Foundation)
    ↓
Phase 2 (Base Components)
    ↓           ↓
Phase 3     Phase 4 (Forms)
(Navigation)    ↓
    ↓           ↓
    └────→ Phase 5 (LedgerScreen)
                ↓
        Phase 6 (Remaining Screens)
                ↓
        Phase 7 (Testing & QA)
                ↓
        Phase 8 (Cleanup & Docs)
```

**Critical Path:** 1 → 2 → 3 → 5 → 6 → 7 → 8 (Phase 4 can parallelize with 3)

**Total Estimated Effort:** 33-46 dias (~6-9 weeks)

---

## Risk Mitigation

### High Risks
1. **Flutter upgrade breaks dependencies** → Mitigation: Test in branch first, have rollback plan (INFRA-10)
2. **Bottom sheet migration fails** → Mitigation: Hybrid approach (FORM-02), keep custom if needed
3. **Performance regression** → Mitigation: Continuous profiling (PERF-07, PERF-14), optimize iteratively

### Medium Risks
4. **Theme inconsistencies** → Mitigation: Visual QA per phase (TEST-21, TEST-22)
5. **Contract violations** → Mitigation: Adapter pattern (DOC-05), maintain public APIs
6. **Insufficient test coverage** → Mitigation: Comprehensive test plan (Phase 7), beta testing (TEST-25)

---

## Success Metrics

### Technical Metrics
- ✅ Flutter 3.41.0+ running in production
- ✅ 100% of UI components migrated to Forui
- ✅ Zero critical regressions in financial calculations
- ✅ Performance equal or better than baseline (FPS, rebuild times, memory)
- ✅ Bundle size increase <10% (acceptable tradeoff)

### Process Metrics
- ✅ All 8 phases completed sequentially
- ✅ 113 requirements mapped and verified
- ✅ Comprehensive test suite passing (25+ tests)
- ✅ Documentation complete (12 doc requirements)
- ✅ Stakeholder sign-off on visual changes

### User Experience Metrics
- ✅ No disruption to core user flows
- ✅ Visual consistency across all screens
- ✅ Accessibility maintained (WCAG AA compliance)
- ✅ Beta test satisfaction ≥80%
- ✅ Zero critical bugs in first week post-launch

---

*Last updated: 2026-04-05*
*Milestone: v1.0 Refatoração UI/UX com Forui.dev*
*Roadmap created by: gsd-new-milestone workflow*
