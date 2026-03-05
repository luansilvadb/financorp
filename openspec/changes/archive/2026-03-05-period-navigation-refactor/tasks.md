## 1. Refatoração do Estado (Provider)

- [x] 1.1 Atualizar `PeriodNotifier` em `lib/shared/providers/month_year_provider.dart` com métodos `nextMonth()`, `prevMonth()`, `nextYear()`, `prevYear()` e `resetToToday()`.
- [x] 1.2 Implementar a lógica de wrap-around no `nextMonth`/`prevMonth` para decrementar/incrementar o ano automaticamente.

## 2. Refatoração da UI (Cabeçalho)

- [x] 2.1 Modificar `_monthYearSelector` em `lib/main.dart` para incluir botões de navegação de ano (`IconButton`).
- [x] 2.2 Adicionar o botão "Hoje" no cabeçalho com a ação `ref.read(periodProvider.notifier).resetToToday()`.
- [x] 2.3 Atualizar `_monthBtn` para usar os novos métodos de transição do provider.
- [x] 2.4 Aplicar destaque visual (pontinho ou cor diferenciada) no mês que corresponde ao calendário atual.

## 3. Validação e Testes

- [x] 3.1 Validar a transição Dezembro -> Janeiro em 2026 para 2027.
- [x] 3.2 Validar a transição Janeiro -> Dezembro de volta para o ano anterior.
- [x] 3.3 Verificar se a troca de ano isolada (setas do ano) mantém o mês e atualiza a lista de despesas corretamente.
- [x] 3.4 Confirmar se o botão "Hoje" reseta o app para o período corrente.
