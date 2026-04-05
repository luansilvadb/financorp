import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:divi/shared/widgets/data/divi_card.dart';

void main() {
  group('DiviCard Widget Tests', () {
    testWidgets('should render card with child', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DiviCard(
              child: Text('Card content'),
            ),
          ),
        ),
      );

      expect(find.text('Card content'), findsOneWidget);
      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('should render with elevation', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DiviCard(
              elevation: 8,
              child: Text('Elevated card'),
            ),
          ),
        ),
      );

      final card = tester.widget<Card>(find.byType(Card));
      expect(card.elevation, 8);
    });

    testWidgets('should render with custom margin', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DiviCard(
              margin: EdgeInsets.all(16),
              child: Text('Custom margin'),
            ),
          ),
        ),
      );

      expect(find.text('Custom margin'), findsOneWidget);
    });
  });
}
