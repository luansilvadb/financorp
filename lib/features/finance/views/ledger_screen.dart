import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../shared/providers/month_year_provider.dart';
import '../../../shared/constants.dart';
import '../../../core/engine/finance_engine.dart';
import '../../../shared/widgets/group_summary.dart';
import '../../../shared/widgets/divi_empty_state.dart';
import '../../../shared/widgets/offline_banner.dart';
import '../../../shared/widgets/divi_toasts.dart';

import 'widgets/z_report_card.dart';
import 'widgets/finance_widgets.dart';
import 'widgets/add_expense_sheet.dart';
import 'widgets/pote_status_card.dart';
import 'statement_screen.dart';

class LedgerScreen extends ConsumerStatefulWidget {
  const LedgerScreen({super.key});

  @override
  ConsumerState<LedgerScreen> createState() => _LedgerScreenState();
}

class _LedgerScreenState extends ConsumerState<LedgerScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _monthScrollController = ScrollController();
  String _searchQuery = "";
  bool _hasLoadedOnce = false;

  @override
  void initState() {
    super.initState();
    // Centraliza o mês atual após o primeiro frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToMonth(ref.read(periodProvider).mes);
    });
  }

  void _scrollToMonth(int index) {
    if (!_monthScrollController.hasClients) return;

    // Agora o cálculo é direto porque o sidePadding compensa o início
    // Largura (80) + Margem (12) = 92
    const double itemWidth = 92.0;
    double offset = index * itemWidth;

    _monthScrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutBack, // Curva mais " viva"
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _monthScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final period = ref.watch(periodProvider);
    final hasSummary = ref.watch(diviEngineProvider.select((s) => s.resumo.isNotEmpty));

    // Show skeleton if data not loaded yet
    if (!_hasLoadedOnce && !hasSummary) {
      // Mark as loaded after first frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        setState(() => _hasLoadedOnce = true);
      });
      return SafeArea(bottom: false, child: _buildLoadingSkeleton());
    }

    final financeState = ref.watch(diviEngineProvider);
    return SafeArea(bottom: false, child: _buildContent(financeState, period));
  }

  Widget _buildContent(dynamic financeState, Period period) {
    final now = DateTime.now();
    final isCurrentMonth =
        period.mes == (now.month - 1) && period.ano == now.year;
    final hasData = financeState.resumo.isNotEmpty;
    final hasAnyDataInSystem =
        financeState.despesas.isNotEmpty || financeState.compras.isNotEmpty;

    return OfflineBanner(
      isOffline: false, // Simulated offline status (always online for now)
      child: ListView(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 120,
          top: 8,
        ),
        children: [
          _buildHeader(period),
          const SizedBox(height: 16),
          // Apply muted opacity for historical months
          Opacity(
            opacity: isCurrentMonth ? 1.0 : 0.85,
            child: Column(
              children: [
                const GroupSummary(),
                const SizedBox(height: 16),
                _buildTimestamp(),
                const SizedBox(height: 16),
                const PoteStatusCard(),
                const SizedBox(height: 16),
                const ZReportCard(),
                const SizedBox(height: 16),
                _buildSearchBar(),
                const SizedBox(height: 16),
                ..._buildResidentList(financeState),
              ],
            ),
          ),
          // Welcome state for first-time users
          if (!hasAnyDataInSystem) ...[
            const SizedBox(height: 40),
            DiviEmptyState(
              icon: Icons.account_balance_wallet_outlined,
              title: 'Bem-vindo ao DIVI',
              subtitle: 'Suas contas em paz, com quem divide a vida.',
              action: ElevatedButton.icon(
                onPressed: () => _openAddExpenseSheet(),
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Adicionar primeira despesa'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryOlive,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                    fontFamily: 'Space Mono',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
          // Empty state for months with no data
          if (hasAnyDataInSystem && !hasData) ...[
            const SizedBox(height: 40),
            _buildEmptyState(period),
          ],
        ],
      ),
    );
  }

  Widget _buildTimestamp() {
    final now = DateTime.now();
    final timeStr = DateFormat.Hm('pt_BR').format(now);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.access_time, size: 12, color: kSlate400),
        const SizedBox(width: 4),
        Text(
          'Atualizado às $timeStr',
          style: TextStyle(
            fontSize: 10,
            color: kTextSecondary,
            fontFamily: 'Space Mono',
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingSkeleton() {
    return ListView(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 120, top: 8),
      children: [
        // Header skeleton
        _sizedBox(height: 40),
        const SizedBox(height: 16),
        // GroupSummary skeleton
        _buildSkeletonCard(height: 80),
        const SizedBox(height: 16),
        // Timestamp skeleton
        _sizedBox(height: 16),
        // ZReportCard skeleton
        _buildSkeletonCard(height: 120),
        const SizedBox(height: 16),
        // Search bar skeleton
        _buildSkeletonCard(height: 48),
        const SizedBox(height: 16),
        // Resident cards skeletons
        _buildSkeletonCard(height: 100),
        const SizedBox(height: 16),
        _buildSkeletonCard(height: 100),
        const SizedBox(height: 16),
        _buildSkeletonCard(height: 100),
      ],
    );
  }

  Widget _buildSkeletonCard({required double height}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.3, end: 0.6),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Container(
          height: height,
          decoration: BoxDecoration(
            color: kSlate100.withValues(alpha: value),
            borderRadius: BorderRadius.circular(16),
          ),
        );
      },
    );
  }

  Widget _sizedBox({required double height}) {
    return SizedBox(height: height);
  }

  Widget _buildEmptyState(Period period) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: [
            Icon(
              Icons.folder_off,
              size: 64,
              color: kInkFaded.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              "Nenhuma despesa registrada em ${mesesFull[period.mes]}",
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: kInkFaded,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              "${period.ano}",
              style: TextStyle(
                fontFamily: 'Space Mono',
                fontSize: 12,
                color: kInkFaded.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _openAddExpenseSheet(),
              icon: const Icon(Icons.add, size: 18),
              label: const Text("Adicionar retroativa"),
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryOlive,
                foregroundColor: Colors.white,
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

  void _openAddExpenseSheet() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const AddExpenseSheet(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
        transitionDuration: const Duration(milliseconds: 200),
        opaque: false,
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: kSurfacePaper.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kPaperDepth),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _searchQuery = value.toLowerCase();
          });
        },
        textAlignVertical: TextAlignVertical.center,
        style: const TextStyle(
          fontFamily: 'Space Mono',
          fontSize: 12,
          color: kTextPrimary,
        ),
        decoration: InputDecoration(
          hintText: "BUSCAR MORADOR...",
          hintStyle: const TextStyle(
            fontFamily: 'Space Mono',
            fontSize: 10,
            color: kTextSecondary,
          ),
          border: InputBorder.none,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Icon(Icons.search, size: 16, color: kTextSecondary),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 40,
            minHeight: 0,
          ),
          suffixIcon: _searchQuery.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    _searchController.clear();
                    setState(() {
                      _searchQuery = "";
                    });
                  },
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

  List<Widget> _buildResidentList(FinanceState financeState) {
    if (financeState.resumo.isEmpty) return [];

    return financeState.resumo.keys
        .where((String name) =>
            name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .map<Widget>((String name) {
      // Map colors for known residents (TODO: Move to resident profile/model)
      Color highlightColor = kPrimaryColor;
      if (name == 'Giovanna') highlightColor = kPaid;
      if (name == 'Luciana') highlightColor = const Color(0xFFF59E0B);

      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: ResidentSummaryCard(
          title: name,
          subtitle: "MORADOR",
          data: financeState.resumo[name]!,
          highlightColor: highlightColor,
          onTap: () => _pushStatement(name),
        ),
      );
    }).toList();
  }

  void _pushStatement(String username) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => StatementScreen(residentName: username),
      ),
    );
  }

  Widget _buildHeader(Period period) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Year Selector on the Left
            Align(
              alignment: Alignment.centerLeft,
              child: _buildYearSelector(period),
            ),
            // Centered DIVI Title
            Semantics(
              label: "Logotipo DIVI",
              child: Text(
                "DIVI",
                style: TextStyle(
                  fontFamily: 'Young Serif',
                  color: kTextPrimary,
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -1.2,
                  shadows: const [
                    Shadow(
                      color: Color(0xFFFF9500),
                      offset: Offset(-1.2, 0),
                    ),
                    Shadow(
                      color: Color(0xFF00FBFF),
                      offset: Offset(1.2, 0),
                    ),
                  ],
                ),
              ),
            ),

            // Reset button on the Right
            Align(
              alignment: Alignment.centerRight,
              child:
                  period.mes != (DateTime.now().month - 1) ||
                      period.ano != DateTime.now().year
                  ? IconButton(
                      onPressed: () {
                        final currentMonth = DateTime.now().month - 1;
                        ref.read(periodProvider.notifier).resetToToday();
                        _scrollToMonth(currentMonth);
                        DiviToasts.show(context, "VOLTANDO PARA HOJE");
                      },
                      icon: Icon(Icons.refresh, size: 20, color: kPrimaryColor),
                      tooltip: 'Voltar para Hoje',
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildMonthSelector(period),
      ],
    );
  }

  Widget _buildYearSelector(Period period) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () => ref.read(periodProvider.notifier).prevYear(),
          visualDensity: VisualDensity.compact,
          icon: Icon(Icons.chevron_left, size: 14, color: kInkFaded),
        ),
        Text(
          "${period.ano}",
          style: const TextStyle(
            fontFamily: 'Space Mono',
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: kInk,
          ),
        ),
        IconButton(
          onPressed: () => ref.read(periodProvider.notifier).nextYear(),
          visualDensity: VisualDensity.compact,
          icon: Icon(Icons.chevron_right, size: 14, color: kInkFaded),
        ),
      ],
    );
  }

  Widget _buildMonthSelector(Period period) {
    final double screenWidth = MediaQuery.of(context).size.width;
    // 40 é a metade da largura do item (80)
    final double sidePadding = screenWidth / 2 - 40;

    return Container(
      height: 44, // Aumentado um pouco para acomodar o "tray"
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // "Tray" ou Trilho de fundo para dar enquadramento
          Container(
            height: 32,
            width: screenWidth - 32,
            decoration: BoxDecoration(
              color: kPaperDepth.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          ListView.builder(
            controller: _monthScrollController,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: 12,
            padding: EdgeInsets.symmetric(horizontal: sidePadding),
            itemBuilder: (context, index) {
              final isSelected = period.mes == index;
              return GestureDetector(
                onTap: () {
                  ref.read(periodProvider.notifier).setMes(index);
                  _scrollToMonth(index);
                  HapticFeedback.selectionClick();
                },
                child: Container(
                  // Removido AnimatedContainer e duração para eliminar o fade
                  margin: const EdgeInsets.only(right: 12),
                  width: 80,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? kTextPrimary : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: kTextPrimary.withValues(alpha: 0.15),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : [],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    mesesFull[index]
                        .substring(0, 3)
                        .toUpperCase(), // Cortando para 3 letras
                    style: TextStyle(
                      fontFamily: 'Space Mono',
                      fontSize: 10,
                      letterSpacing: 1,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: isSelected ? kSurfacePaper : kTextSecondary,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
