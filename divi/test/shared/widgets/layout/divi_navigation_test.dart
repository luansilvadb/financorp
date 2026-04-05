import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:divi/shared/widgets/layout/divi_navigation.dart';

void main() {
  group('DiviNavigation Widget Tests', () {
    testWidgets('should render navigation bar with items', (WidgetTester tester) async {
      final items = [
        const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        const BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: DiviNavigation(
              items: items,
              currentIndex: 0,
              onTap: (index) {},
            ),
          ),
        ),
      );

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('should call onTap when item tapped', (WidgetTester tester) async {
      int? tappedIndex;
      final items = [
        const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        const BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: DiviNavigation(
              items: items,
              currentIndex: 0,
              onTap: (index) => tappedIndex = index,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Settings'));
      await tester.pump();

      expect(tappedIndex, 1);
    });
  });
}
