import 'package:flutter/material.dart';
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
import 'features/finance/views/widgets/spike_modal_sheet.dart';
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
        textTheme: GoogleFonts.interTextTheme().apply(
          bodyColor: kInk,
          displayColor: kInk,
        ),
        scaffoldBackgroundColor: kPaper,
        colorScheme: ColorScheme.fromSeed(
          seedColor: kPrimaryColor,
          surface: kPaper,
          onSurface: kInk,
          error: kPrimaryColor,
        ),
      ),
      builder: (context, child) {
        return Stack(
          children: [
            if (child != null) child,
            const PaperBackground(),
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
  void initState() {
    super.initState();
    // Default the app to the current month when it launches
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(periodProvider.notifier).resetToToday();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _aba,
        children: const [
          LedgerScreen(),
          ArchiveScreen(),
        ],
      ),
      bottomNavigationBar: PaperBottomNav(
        currentIndex: _aba,
        onTap: (index) => setState(() => _aba = index),
        onFabTap: () {
          // Temporarily use the old add flows until Spike is ready
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const SpikeModalSheet(),
          );
        },
      ),
    );
  }
}
