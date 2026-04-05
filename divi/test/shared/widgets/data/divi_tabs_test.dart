import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:divi/shared/widgets/data/divi_tabs.dart';

void main() {
  group('DiviTabs Widget Tests', () {
    testWidgets('should render tabs with labels', (WidgetTester tester) async {
      final tabs = ['Tab 1', 'Tab 2', 'Tab 3'];

      await tester.pumpWidget(
        MaterialApp(
          home: DefaultTabController(
            length: tabs.length,
            child: Scaffold(
              appBar: DiviTabs(
                tabs: tabs,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Tab 1'), findsOneWidget);
      expect(find.text('Tab 2'), findsOneWidget);
      expect(find.text('Tab 3'), findsOneWidget);
    });
  });
}
