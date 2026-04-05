import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:divi/shared/widgets/data/divi_badge.dart';

void main() {
  group('DiviBadge Widget Tests', () {
    testWidgets('should render badge with count', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DiviBadge(
              count: 5,
              child: const Icon(Icons.notifications),
            ),
          ),
        ),
      );

      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('should show dot when showZero is false and count is 0', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DiviBadge(
              count: 0,
              showZero: false,
              child: const Icon(Icons.notifications),
            ),
          ),
        ),
      );

      // Badge should not be visible when count is 0 and showZero is false
      expect(find.byType(Positioned), findsNothing);
    });

    testWidgets('should render with custom color', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DiviBadge(
              count: 3,
              color: Colors.green,
              child: const Icon(Icons.notifications),
            ),
          ),
        ),
      );

      expect(find.text('3'), findsOneWidget);
    });
  });
}
