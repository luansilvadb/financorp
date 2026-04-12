import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';

// Core & Shared
import 'shared/providers/month_year_provider.dart';
import 'shared/constants.dart';
import 'shared/widgets/paper_background.dart';
import 'shared/widgets/paper_bottom_nav.dart';

// Features
import 'features/finance/views/ledger_screen.dart';
import 'features/finance/views/archive_screen.dart';
import 'features/finance/views/widgets/add_expense_sheet.dart';
import 'features/cartao/views/widgets/add_purchase_sheet.dart';
import 'core/views/splash_screen.dart';

// ============================================================
// App Entry
// ============================================================

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: CasaApp()));
}


class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.stylus,
      };

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}

class CasaApp extends StatelessWidget {
  const CasaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DIVI',
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: scaffoldMessengerKey,
      scrollBehavior: AppScrollBehavior(),
      theme: ThemeData(
        useMaterial3: true,
        // Color scheme — Mesa Calma (olive-based)
        colorScheme: ColorScheme.fromSeed(
          seedColor: kPrimaryOlive,
          surface: kSurfacePaper,
          onSurface: kTextPrimary,
          primary: kPrimaryOlive,
          onPrimary: Colors.white,
          error: kSemanticOverdue,
        ),
        scaffoldBackgroundColor: kSurfacePaper,

        // Typography — Young Serif (display), Inter (body), Space Mono (labels)
        textTheme: TextTheme(
          displayLarge: GoogleFonts.youngSerif(
            fontSize: 32,
            fontWeight: FontWeight.w400,
          ),
          headlineLarge: GoogleFonts.youngSerif(
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
          headlineMedium: GoogleFonts.youngSerif(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          bodyLarge: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          bodyMedium: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          labelLarge: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          labelMedium: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          labelSmall: GoogleFonts.spaceMono(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ).apply(bodyColor: kTextPrimary, displayColor: kTextPrimary),

        // Card theme — zero elevation (recibos deitam, não flutuam)
        cardTheme: const CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),

        // Button themes — olive primary, outline secondary
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: kPrimaryOlive,
            foregroundColor: Colors.white,
            textStyle: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: kPrimaryOlive, width: 1.5),
            foregroundColor: kPrimaryOlive,
            textStyle: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        // Input decoration
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: kSurfacePaper,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: kPaperDepth),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: kPrimaryOlive, width: 1.5),
          ),
        ),
      ),
      builder: (context, child) {
        return Stack(
          children: [
            const PaperBackground(),
            // ignore: use_null_aware_elements
            if (child != null) child,
          ],
        );
      },
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
    // Initialize locale data for intl/DateFormat
    await initializeDateFormatting('pt_BR', null);

    // Load environment variables if .env exists in assets
    try {
      final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
      final assets = manifest.listAssets();
      if (assets.contains('.env') || assets.contains('assets/.env')) {
        await dotenv.load(fileName: ".env");
      }
    } catch (e) {
      // Ignore if .env file is missing, assume environment variables are passed via --dart-define
    }

    final url = const String.fromEnvironment('SUPABASE_URL', defaultValue: '');
    final anonKey = const String.fromEnvironment('SUPABASE_ANON_KEY', defaultValue: '');

    if (url.isNotEmpty && anonKey.isNotEmpty) {
      await Supabase.initialize(
        url: url,
        anonKey: anonKey,
      );
    } else {
      await Supabase.initialize(
        url: dotenv.env['SUPABASE_URL'] ?? '',
        anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
      );
    }
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
  void initState() {
    super.initState();
    // Default the app to the current month when it launches
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(periodProvider.notifier).resetToToday();
    });
  }

  void _showAddModeSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        decoration: const BoxDecoration(
          color: kSurfacePaper,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "O QUE VOCÊ DESEJA ADICIONAR?",
              style: TextStyle(
                fontFamily: 'Space Mono',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                color: kTextSecondary,
              ),
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: kPrimaryOlive.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.receipt_outlined, color: kPrimaryOlive),
              ),
              title: const Text(
                "Despesa Fixa",
                style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, color: kTextPrimary),
              ),
              subtitle: const Text(
                "Contas mensais (aluguel, luz...)",
                style: TextStyle(fontFamily: 'Inter', fontSize: 12, color: kTextSecondary),
              ),
              onTap: () {
                Navigator.pop(ctx);
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const AddExpenseSheet(),
                );
              },
            ),
            const Divider(color: kPaperDepth, height: 32),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: kPrimaryOlive.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.credit_card_outlined, color: kPrimaryOlive),
              ),
              title: const Text(
                "Compra no Cartão",
                style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, color: kTextPrimary),
              ),
              subtitle: const Text(
                "Gastos avulsos e compras do dia a dia",
                style: TextStyle(fontFamily: 'Inter', fontSize: 12, color: kTextSecondary),
              ),
              onTap: () {
                Navigator.pop(ctx);
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const AddPurchaseSheet(),
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _aba,
        children: [
          LedgerScreen(),
          ArchiveScreen(),
        ],
      ),
      bottomNavigationBar: PaperBottomNav(
        currentIndex: _aba,
        onTap: (index) => setState(() => _aba = index),
        onFabTap: _showAddModeSelector,
      ),
    );
  }
}
