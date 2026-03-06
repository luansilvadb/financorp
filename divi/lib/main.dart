import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Core & Shared
import 'shared/providers/month_year_provider.dart';
import 'shared/constants.dart';

// Features
import 'features/finance/views/despesas_tab.dart';
import 'features/cartao/views/cartao_tab.dart';
import 'features/finance/views/resumo_tab.dart';
import 'features/finance/views/widgets/add_expense_sheet.dart';
import 'features/cartao/views/widgets/add_purchase_sheet.dart';
import 'shared/widgets/premium_bottom_nav.dart';
import 'core/views/splash_screen.dart';

// ============================================================
// App Entry
// ============================================================

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: CasaApp()));
}

class CasaApp extends StatelessWidget {
  const CasaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DIVI',
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: scaffoldMessengerKey,
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(),
        scaffoldBackgroundColor: kBackgroundLight,
        colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
      ),
      home: SplashScreen(
        initializationFuture: _initialize(),
        onInitialized: () {
          // Navigator is already available within the child context of SplashScreen's Material parent
          // but we'll use the local context in the SplashScreen or a global key if needed.
        },
      ),
    );
  }

  Future<void> _initialize() async {
    // Load environment variables
    await dotenv.load(fileName: ".env");

    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL'] ?? '',
      anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
    );
  }
}

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _aba = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: IndexedStack(
              index: _aba,
              children: const [DespesasTab(), CartaoTab(), ResumoTab()],
            ),
          ),
        ],
      ),
      floatingActionButton: _aba == 2
          ? null
          : FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => _aba == 0
                      ? const AddExpenseSheet()
                      : const AddPurchaseSheet(),
                );
              },
              backgroundColor: kPrimaryColor,
              shape: const CircleBorder(),
              elevation: 4,
              child: PhosphorIcon(PhosphorIcons.plus(PhosphorIconsStyle.bold),
                  color: Colors.white, size: 32),
            ),
      bottomNavigationBar: PremiumBottomNav(
        currentIndex: _aba,
        onTap: (index) => setState(() => _aba = index),
        items: [
          PremiumNavItem(
            iconRegular: PhosphorIcons.receipt(PhosphorIconsStyle.regular),
            iconFill: PhosphorIcons.receipt(PhosphorIconsStyle.fill),
            label: "Despesas",
          ),
          PremiumNavItem(
            iconRegular: PhosphorIcons.creditCard(PhosphorIconsStyle.regular),
            iconFill: PhosphorIcons.creditCard(PhosphorIconsStyle.fill),
            label: "Cartão",
          ),
          PremiumNavItem(
            iconRegular: PhosphorIcons.chartBar(PhosphorIconsStyle.regular),
            iconFill: PhosphorIcons.chartBar(PhosphorIconsStyle.fill),
            label: "Resumo",
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final period = ref.watch(periodProvider);
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 24,
        left: 16,
        right: 16,
        bottom: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PhosphorIcon(PhosphorIcons.intersect(PhosphorIconsStyle.regular),
                  color: kPrimaryColor, size: 32),
              Row(
                children: [
                  if (period.mes != (DateTime.now().month - 1) ||
                      period.ano != DateTime.now().year)
                    TextButton.icon(
                      onPressed: () =>
                          ref.read(periodProvider.notifier).resetToToday(),
                      icon: PhosphorIcon(
                          PhosphorIcons.calendarBlank(
                              PhosphorIconsStyle.regular),
                          size: 18,
                          color: kPrimaryColor),
                      label: const Text(
                        "HOJE",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: kPrimaryColor.withOpacity(0.1),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () {},
                    icon: PhosphorIcon(
                        PhosphorIcons.magnifyingGlass(
                            PhosphorIconsStyle.regular),
                        color: kSlate900),
                    style: IconButton.styleFrom(
                      backgroundColor: kSlate100,
                      padding: const EdgeInsets.all(8),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            "DIVI",
            style: TextStyle(
              color: kSlate900,
              fontSize: 28,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 16),
          _monthYearSelector(period),
        ],
      ),
    );
  }

  Widget _monthYearSelector(Period period) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: kSlate100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _monthBtn(period, period.mes - 1, isPrev: true),
          _monthBtn(period, period.mes, isCurrent: true),
          _monthBtn(period, period.mes + 1, isNext: true),
          Container(
            width: 1,
            height: 24,
            color: kSlate200,
            margin: const EdgeInsets.symmetric(horizontal: 4),
          ),
          InkWell(
            onTap: () => ref.read(periodProvider.notifier).prevYear(),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: PhosphorIcon(
                  PhosphorIcons.caretLeft(PhosphorIconsStyle.bold),
                  size: 18,
                  color: kSlate400),
            ),
          ),
          Center(
            child: Text(
              "${period.ano}",
              style: const TextStyle(
                color: kSlate900,
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
          ),
          InkWell(
            onTap: () => ref.read(periodProvider.notifier).nextYear(),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: PhosphorIcon(
                  PhosphorIcons.caretRight(PhosphorIconsStyle.bold),
                  size: 18,
                  color: kSlate400),
            ),
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }

  Widget _monthBtn(
    Period period,
    int m, {
    bool isCurrent = false,
    bool isPrev = false,
    bool isNext = false,
  }) {
    int targetMonth = m;
    if (targetMonth < 0) targetMonth = 11;
    if (targetMonth > 11) targetMonth = 0;

    final isActualToday =
        ref.watch(periodProvider.notifier).isToday(targetMonth);

    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (isPrev) {
            ref.read(periodProvider.notifier).prevMonth();
          } else if (isNext) {
            ref.read(periodProvider.notifier).nextMonth();
          } else {
            // Se clicar no atual, não faz nada ou reseta se quiser
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isCurrent ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isCurrent
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                mesesFull[targetMonth],
                style: TextStyle(
                  color: isCurrent ? kPrimaryColor : kSlate400,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
              if (isActualToday) ...[
                const SizedBox(width: 4),
                Container(
                  width: 4,
                  height: 4,
                  decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
