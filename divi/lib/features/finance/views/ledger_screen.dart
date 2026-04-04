import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../shared/providers/month_year_provider.dart';
import '../../../shared/constants.dart';
import '../../../core/engine/finance_engine.dart';

import 'widgets/z_report_card.dart';
import 'widgets/finance_widgets.dart';
import 'package:divi/shared/widgets/divi_toasts.dart';
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
    final financeState = ref.watch(diviEngineProvider);

    return SafeArea(
      bottom: false,
      child: ListView(
        padding:
            const EdgeInsets.only(left: 16, right: 16, bottom: 120, top: 8),
        children: [
          _buildHeader(period),
          const SizedBox(height: 16),
          const ZReportCard(),
          const SizedBox(height: 16),
          _buildSearchBar(),
          const SizedBox(height: 16),
          ..._buildResidentList(financeState),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kLine),
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
          color: kInk,
        ),
        decoration: InputDecoration(
          hintText: "BUSCAR MORADOR...",
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
            child: Icon(
              Icons.search,
              size: 16,
              color: kInkFaded,
            ),
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
                    child: Icon(
                      Icons.cancel,
                      size: 18,
                      color: kInkFaded,
                    ),
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

  List<Widget> _buildResidentList(dynamic financeState) {
    final residents = [
      {
        'name': 'Luan',
        'subtitle': 'MORADOR',
        'color': kPrimaryColor,
      },
      {
        'name': 'Giovanna',
        'subtitle': 'MORADOR',
        'color': kPaid,
      },
      {
        'name': 'Luciana',
        'subtitle': 'MORADOR',
        'color': const Color(0xFFF59E0B),
      },
    ];

    final filtered = residents.where((r) {
      if (_searchQuery.isEmpty) return true;
      return r['name'].toString().toLowerCase().contains(_searchQuery);
    }).toList();

    return filtered.map((r) {
      final name = r['name'] as String;
      if (financeState.resumo[name] == null) return const SizedBox.shrink();

      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: ResidentSummaryCard(
          title: name,
          subtitle: r['subtitle'] as String,
          data: financeState.resumo[name]!,
          highlightColor: r['color'] as Color,
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
            const Align(
              alignment: Alignment.center,
              child: Text(
                "DIVI",
                style: TextStyle(
                  fontFamily: 'Young Serif',
                  color: kInk,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.2,
                  shadows: [
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
              child: period.mes != (DateTime.now().month - 1) ||
                      period.ano != DateTime.now().year
                  ? IconButton(
                      onPressed: () {
                        final currentMonth = DateTime.now().month - 1;
                        ref.read(periodProvider.notifier).resetToToday();
                        _scrollToMonth(currentMonth);
                        DiviToasts.show(context, "VOLTANDO PARA HOJE");
                      },
                      icon: Icon(
                          Icons.refresh,
                          size: 20,
                          color: kPrimaryColor),
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
          icon: Icon(Icons.chevron_left,
              size: 14, color: kInkFaded),
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
          icon: Icon(Icons.chevron_right,
              size: 14, color: kInkFaded),
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
              color: kLine.withOpacity(0.1),
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
                  decoration: BoxDecoration(
                    color: isSelected ? kInk : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                                color: kInk.withOpacity(0.15),
                                blurRadius: 10,
                                offset: const Offset(0, 4))
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
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? kPaper : kInkFaded,
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
