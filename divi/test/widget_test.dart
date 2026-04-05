import 'package:flutter_test/flutter_test.dart';
import 'package:divi/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('App should render', (WidgetTester tester) async {
    // We need to wrap with ProviderScope because the app uses Riverpod
    await tester.pumpWidget(const ProviderScope(child: CasaApp()));
    
    // Pump a few frames to allow initial build
    await tester.pump(const Duration(milliseconds: 500));

    // The app shows "DIVI" as the title (MaterialApp title)
    // or shows the splash screen with the logo
    expect(find.byType(CasaApp), findsOneWidget);
  });
}
