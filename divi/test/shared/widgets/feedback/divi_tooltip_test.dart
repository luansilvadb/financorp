import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:divi/shared/widgets/feedback/divi_tooltip.dart';

void main() {
  group('DiviTooltip Widget Tests', () {
    testWidgets('should show tooltip on long press', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: DiviTooltip(
                message: 'Test Tooltip',
                child: const Text('Hover me'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Hover me'), findsOneWidget);
      
      // Long press to show tooltip
      await tester.longPress(find.text('Hover me'));
      await tester.pump();

      expect(find.text('Test Tooltip'), findsOneWidget);
    });
  });
}
