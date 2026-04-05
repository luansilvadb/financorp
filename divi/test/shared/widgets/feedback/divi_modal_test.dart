import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:divi/shared/widgets/feedback/divi_modal.dart';

void main() {
  group('DiviModal Widget Tests', () {
    testWidgets('should show modal dialog', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => DiviModal.show(
                  context: context,
                  title: 'Test Modal',
                  content: const Text('Modal content'),
                ),
                child: const Text('Show Modal'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Modal'));
      await tester.pumpAndSettle();

      expect(find.text('Test Modal'), findsOneWidget);
      expect(find.text('Modal content'), findsOneWidget);
    });
  });
}
