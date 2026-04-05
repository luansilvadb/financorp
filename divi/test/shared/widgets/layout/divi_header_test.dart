import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:divi/shared/widgets/layout/divi_header.dart';

void main() {
  group('DiviHeader Widget Tests', () {
    testWidgets('should render header with title', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DiviHeader(
              title: 'Test Header',
            ),
          ),
        ),
      );

      expect(find.text('Test Header'), findsOneWidget);
    });

    testWidgets('should render with optional subtitle', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DiviHeader(
              title: 'Test Header',
              subtitle: 'Test Subtitle',
            ),
          ),
        ),
      );

      expect(find.text('Test Header'), findsOneWidget);
      expect(find.text('Test Subtitle'), findsOneWidget);
    });

    testWidgets('should render actions when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DiviHeader(
              title: 'Test Header',
              actions: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.add), findsOneWidget);
    });
  });
}
