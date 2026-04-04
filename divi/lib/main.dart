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

bool _isConfigured = true;

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
          if (!_isConfigured) {
            runApp(const ConfigErrorScreen());
          }
        },
      ),
    );
  }

  Future<void> _initialize() async {
    // Load environment variables
    try {
      await dotenv.load(fileName: ".env");
    } catch (e) {
      // Ignore if .env file is missing, assume environment variables are passed via --dart-define
    }

    final url = const String.fromEnvironment('SUPABASE_URL', defaultValue: '');
    final anonKey = const String.fromEnvironment('SUPABASE_ANON_KEY', defaultValue: '');

    String finalUrl = url;
    String finalKey = anonKey;

    if (finalUrl.isEmpty) {
      finalUrl = dotenv.env['SUPABASE_URL'] ?? '';
    }
    if (finalKey.isEmpty) {
      finalKey = dotenv.env['SUPABASE_ANON_KEY'] ?? '';
    }

    if (finalUrl.isEmpty || finalKey.isEmpty) {
      _isConfigured = false;
      return;
    }

    try {
      await Supabase.initialize(
        url: finalUrl,
        anonKey: finalKey,
      );
    } catch (e) {
      _isConfigured = false;
    }
  }
}

class ConfigErrorScreen extends StatelessWidget {
  const ConfigErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFF4F1EA),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Color(0xFFE63819)),
                const SizedBox(height: 24),
                const Text(
                  "SUPABASE_URL or SUPABASE_ANON_KEY is missing.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C2C2C),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "If you are deploying to Vercel, you must pass your Supabase credentials either via a .env file or by modifying the Build Command in Vercel to:\n\nflutter build web --dart-define=SUPABASE_URL=\$SUPABASE_URL --dart-define=SUPABASE_ANON_KEY=\$SUPABASE_ANON_KEY",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B6B6B),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
