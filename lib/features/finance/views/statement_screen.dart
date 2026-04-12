import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'dart:async';

import 'package:divi/shared/constants.dart';
import 'package:divi/core/engine/finance_engine.dart';
import 'package:divi/shared/widgets/skeuomorphic.dart';
import 'package:divi/core/providers/app_providers.dart';
import 'package:divi/shared/providers/month_year_provider.dart';
import 'package:divi/shared/widgets/divi_toasts.dart';
import 'package:divi/shared/widgets/divi_avatar.dart';
import 'package:divi/shared/models/domain.dart';

import 'widgets/finance_widgets.dart';
import 'widgets/spike_modal_sheet.dart';

class StatementScreen extends ConsumerStatefulWidget {
  final String residentName;

  const StatementScreen({super.key, required this.residentName});

  @override
  ConsumerState<StatementScreen> createState() => _StatementScreenState();
}

class _StatementScreenState extends ConsumerState<StatementScreen> {
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();

  // Search and filter state
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  String _filterStatus = "todos"; // todos, pago, pendente
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() => _searchQuery = _searchController.text.toLowerCase());
      }
    });
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() => _searchQuery = "");
  }

  List<_TransactionItem> _filterTransactions(List<_TransactionItem> items) {
    return items.where((item) {
      // Search filter
      if (_searchQuery.isNotEmpty) {
        final matchesSearch = item.title.toLowerCase().contains(_searchQuery);
        if (!matchesSearch) return false;
      }

      // Status filter
      if (_filterStatus == "pago" && !item.isPaid) return false;
      if (_filterStatus == "pendente" && item.isPaid) return false;

      return true;
    }).toList();
  }

  Future<void> _handleRefresh() async {
    DiviToasts.show(context, "Checando com o grupo...", isError: false);
    HapticFeedback.mediumImpact();

    // Invalidate providers to force refresh from Supabase
    ref.invalidate(despesasProvider);
    ref.invalidate(pagamentosProvider);
    ref.invalidate(cartaoProvider);

    // Small delay to show loading state
    await Future.delayed(const Duration(milliseconds: 800));

    if (mounted) {
      DiviToasts.show(context, "Dados atualizados!", isError: false);
    }
  }

  Future<void> _handleQuitarTudo(
    BuildContext context,
    WidgetRef ref,
    double amount,
  ) async {
    final confirmed = await _showConfirmQuitarDialog(context, amount);
    if (confirmed != true) return;

    setState(() => _isLoading = true);

    try {
      final period = ref.read(periodProvider);
      final financeState = ref.read(diviEngineProvider);

      // IDs das despesas da casa que este morador ainda não pagou
      final pendingHouseExpenseIds = financeState.despesas.values
          .where((item) => !(item.pagosPorPessoa[widget.residentName] ?? false))
          .map((item) => item.despesa.id)
          .whereType<String>()
          .toList();

      await Future.wait([
        ref
            .read(cartaoProvider.notifier)
            .markAllAsPaid(widget.residentName, period.mes, period.ano),
        ref
            .read(pagamentosProvider.notifier)
            .markAllAsPaid(
              widget.residentName,
              period.mes,
              period.ano,
              pendingHouseExpenseIds,
            ),
      ]);

      if (context.mounted) {
        HapticFeedback.heavyImpact();
        DiviToasts.show(context, "TUDO QUITADO!", isError: false);
      }
    } catch (e) {
      if (context.mounted) {
        DiviToasts.show(context, "ERRO AO QUITAR", isError: true);
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<bool?> _showConfirmQuitarDialog(BuildContext context, double amount) {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'pt_BR');

    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: kPaper,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text(
          "CONFIRMAR PAGAMENTO",
          style: TextStyle(
            fontFamily: 'Space Mono',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: kInk,
            letterSpacing: 1.2,
          ),
        ),
        content: Text(
          "Deseja marcar todas as pendências de ${widget.residentName} (${formatCurrency.format(amount)}) como pagas?",
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            color: kInk.withValues(alpha: 0.7),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              "CANCELAR",
              style: TextStyle(
                fontFamily: 'Space Mono',
                fontWeight: FontWeight.bold,
                color: kInkFaded,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: kPaid,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text(
              "QUITAR AGORA",
              style: TextStyle(
                fontFamily: 'Space Mono',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final financeState = ref.watch(diviEngineProvider);
    final period = ref.watch(periodProvider);
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'pt_BR');

    final summary = ref.watch(diviEngineProvider.select((s) => s.resumo[widget.residentName]));
    final totalToPay = summary?.totalGeral ?? 0.0;

    final houseExpensesData = financeState.despesas.values.toList();
    final purchases = financeState.comprasPorPessoa[widget.residentName] ?? [];

    // Combine all transactions and sort by date (newest first)
    final allTransactions = [
      ...houseExpensesData.map(
        (item) => _TransactionItem(
          title: item.despesa.nome,
          date: DateTime(
            period.ano,
            period.mes + 1,
            item.despesa.diaVencimento,
          ),
          dateStr: "Vencimento dia ${item.despesa.diaVencimento}",
          amount: item.despesa.valor / 3,
          isPaid: item.pagosPorPessoa[widget.residentName] ?? false,
          type: _TransactionType.expense,
          despesaItem: item,
        ),
      ),
      ...purchases.map(
        (c) => _TransactionItem(
          title: c.descricao,
          date: _parseDate(c.data),
          dateStr: c.data,
          amount: c.valor,
          isPaid: c.pago,
          type: _TransactionType.purchase,
          compra: c,
        ),
      ),
    ];

    allTransactions.sort((a, b) => b.date.compareTo(a.date));

    // Apply filters
    final filteredTransactions = _filterTransactions(allTransactions);
    final totalCount = allTransactions.length;
    final filteredCount = filteredTransactions.length;

    return Scaffold(
      backgroundColor: kPaper,
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        color: kPaid,
        child: CustomScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: [
            // Skeuomorphic Header
            SliverAppBar(
              expandedHeight: 220,
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.chevron_left, color: kInk),
                onPressed: () => Navigator.pop(context),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(32),
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Hole Punches
                      const Positioned(
                        top: 40,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            HolePunch(),
                            SizedBox(width: 60),
                            HolePunch(),
                          ],
                        ),
                      ),
                      // Content
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 32),
                            // Avatar
                            DiviAvatar(pessoa: widget.residentName, size: 48),
                            const SizedBox(height: 12),
                            Text(
                              widget.residentName.toUpperCase(),
                              style: const TextStyle(
                                fontFamily: 'Space Mono',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: kInkFaded,
                                letterSpacing: 2,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              formatCurrency.format(totalToPay.abs()),
                              style: TextStyle(
                                fontFamily: 'Young Serif',
                                fontSize: 36,
                                color: totalToPay > 0 ? kPrimaryColor : kPaid,
                              ),
                            ),
                            Text(
                              totalToPay > 0
                                  ? "TOTAL DEVIDO"
                                  : (totalToPay < 0 ? "A RECEBER" : "QUITADO"),
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                                color: totalToPay > 0 ? kPrimaryColor : kPaid,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Sua parte em ${mesesFull[period.mes]} ${period.ano}",
                              style: TextStyle(
                                fontFamily: 'Space Mono',
                                fontSize: 10,
                                color: kInkFaded,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // List of Items
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 100),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Search bar
                  _buildSearchBar(),
                  const SizedBox(height: 12),
                  // Filter chips
                  _buildFilterChips(),
                  const SizedBox(height: 16),
                  // Filtered count indicator
                  if (_searchQuery.isNotEmpty || _filterStatus != "todos")
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        "$filteredCount de $totalCount transações",
                        style: TextStyle(
                          fontFamily: 'Space Mono',
                          fontSize: 10,
                          color: kInkFaded,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  // Transaction list
                  if (filteredTransactions.isNotEmpty)
                    ..._buildGroupedTransactionList(filteredTransactions, ref),
                  // Empty states
                  if (filteredTransactions.isEmpty && (allTransactions.isNotEmpty))
                    _buildNoResultsEmptyState(),
                  if (allTransactions.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Text(
                          "Nenhum registro este mês.",
                          style: TextStyle(
                            fontFamily: 'Space Mono',
                            color: kInkFaded,
                          ),
                        ),
                      ),
                    ),
                ]),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: totalToPay > 0
          ? FloatingActionButton.extended(
              onPressed: _isLoading
                  ? null
                  : () => _handleQuitarTudo(context, ref, totalToPay),
              label: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(kPaper),
                      ),
                    )
                  : const Text(
                      "QUITAR TUDO",
                      style: TextStyle(
                        fontFamily: 'Space Mono',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              backgroundColor: _isLoading ? kInkFaded : kPaid,
              foregroundColor: kPaper,
            )
          : null,
    );
  }

  List<Widget> _buildGroupedTransactionList(
    List<_TransactionItem> items,
    WidgetRef ref,
  ) {
    final widgets = <Widget>[];
    int currentWeek = -1;

    for (final item in items) {
      // Calculate week of month (simplified: week 1 is days 1-7, etc.)
      final week = ((item.date.day - 1) / 7).floor() + 1;

      if (week != currentWeek) {
        currentWeek = week;
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 16, bottom: 12),
            child: Text(
              "SEMANA $currentWeek",
              style: const TextStyle(
                fontFamily: 'Space Mono',
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: kInkFaded,
                letterSpacing: 1.2,
              ),
            ),
          ),
        );
      }

      if (item.type == _TransactionType.expense) {
        final d = item.despesaItem!.despesa;
        widgets.add(
          ReceiptItemCard(
            title: item.title,
            date: item.dateStr,
            amount: item.amount,
            isPaid: item.isPaid,
            isHouseExpense: true,
            onToggle: () {
              if (d.id != null) {
                ref.read(pagamentosProvider.notifier).togglePagamento(
                      d.id!,
                      widget.residentName,
                      item.isPaid,
                    );
              }
            },
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => SpikeModalSheet(despesa: d),
              );
            },
            onDelete: () => _showDeleteDialog(
              context,
              ref,
              title: d.nome,
              onConfirm: () {
                if (d.id != null) {
                  ref.read(despesasProvider.notifier).deleteDespesa(d.id!);
                }
              },
            ),
          ),
        );
      } else {
        final c = item.compra!;
        widgets.add(
          ReceiptItemCard(
            title: item.title,
            date: item.dateStr,
            amount: item.amount,
            isPaid: item.isPaid,
            onToggle: () {
              ref.read(cartaoProvider.notifier).togglePagamento(c);
            },
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => SpikeModalSheet(compra: c),
              );
            },
            onDelete: () => _showDeleteDialog(
              context,
              ref,
              title: c.descricao,
              onConfirm: () {
                if (c.id != null) {
                  ref.read(cartaoProvider.notifier).deleteCompra(c.id!);
                }
              },
            ),
          ),
        );
      }
    }

    return widgets;
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kLine),
      ),
      child: TextField(
        controller: _searchController,
        textAlignVertical: TextAlignVertical.center,
        style: const TextStyle(
          fontFamily: 'Space Mono',
          fontSize: 12,
          color: kInk,
        ),
        decoration: InputDecoration(
          hintText: "BUSCAR TRANSAÇÃO...",
          hintStyle: const TextStyle(
            fontFamily: 'Space Mono',
            fontSize: 10,
            color: kInkFaded,
          ),
          border: InputBorder.none,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Icon(Icons.search, size: 16, color: kInkFaded),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 40,
            minHeight: 0,
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? GestureDetector(
                  onTap: _clearSearch,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Icon(Icons.cancel, size: 18, color: kInkFaded),
                  ),
                )
              : null,
          suffixIconConstraints: const BoxConstraints(
            minWidth: 40,
            minHeight: 0,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildChip("Todas", "todos"),
          const SizedBox(width: 8),
          _buildChip("Pago", "pago"),
          const SizedBox(width: 8),
          _buildChip("Pendente", "pendente"),
        ],
      ),
    );
  }

  Widget _buildChip(String label, String value) {
    final isSelected = _filterStatus == value;
    return FilterChip(
      label: Text(
        label,
        style: TextStyle(
          fontFamily: 'Space Mono',
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: isSelected ? kPaid : kInkFaded,
        ),
      ),
      selected: isSelected,
      onSelected: (selected) {
        setState(() => _filterStatus = value);
      },
      selectedColor: kSemanticPaid.withValues(alpha: 0.2),
      checkmarkColor: kSemanticPaid,
      side: BorderSide(color: isSelected ? kSemanticPaid : kLine, width: 1),
    );
  }

  Widget _buildNoResultsEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: kInkFaded.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              "Sem resultados para '$_searchQuery'",
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: kInkFaded,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: _clearSearch,
              icon: const Icon(Icons.clear, size: 16),
              label: const Text("Limpar busca"),
              style: TextButton.styleFrom(
                foregroundColor: kPrimaryColor,
                textStyle: const TextStyle(
                  fontFamily: 'Space Mono',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DateTime _parseDate(String dateStr) {
    try {
      return DateFormat('dd/MM/yyyy', 'pt_BR').parse(dateStr);
    } catch (e) {
      return DateTime.now();
    }
  }

  void _showDeleteDialog(
    BuildContext context,
    WidgetRef ref, {
    required String title,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: kPaper,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text(
          "EXCLUIR REGISTRO",
          style: TextStyle(
            fontFamily: 'Space Mono',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: kInk,
            letterSpacing: 1.2,
          ),
        ),
        content: Text(
          "Você tem certeza que deseja remover '$title' das contas?",
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            color: kInk.withValues(alpha: 0.7),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "CANCELAR",
              style: TextStyle(
                fontFamily: 'Space Mono',
                fontWeight: FontWeight.bold,
                color: kInkFaded,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              onConfirm();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text(
              "EXCLUIR",
              style: TextStyle(
                fontFamily: 'Space Mono',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum _TransactionType { expense, purchase }

class _TransactionItem {
  final String title;
  final DateTime date;
  final String dateStr;
  final double amount;
  final bool isPaid;
  final _TransactionType type;
  final DespesaItemRecord? despesaItem;
  final CompraCartao? compra;

  _TransactionItem({
    required this.title,
    required this.date,
    required this.dateStr,
    required this.amount,
    required this.isPaid,
    required this.type,
    this.despesaItem,
    this.compra,
  });
}
