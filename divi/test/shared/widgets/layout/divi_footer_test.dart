import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:divi/shared/widgets/layout/divi_footer.dart';

void main() {
  group('DiviFooter Widget Tests', () {
    testWidgets('should render footer with text', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DiviFooter(
              text: '© 2026 DIVI',
            ),
          ),
        ),
      );

      expect(find.text('© 2026 DIVI'), findsOneWidget);
    });

    testWidgets('should render with custom background color', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DiviFooter(
              text: '© 2026 DIVI',
              backgroundColor: Colors.blue,
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      expect(container, isNotNull);
    });

    testWidgets('should render with actions', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DiviFooter(
              text: '© 2026 DIVI',
              actions: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Privacy'),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Privacy'), findsOneWidget);
    });
  });
}
