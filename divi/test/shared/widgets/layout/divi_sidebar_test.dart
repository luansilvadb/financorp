import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:divi/shared/widgets/layout/divi_sidebar.dart';

void main() {
  group('DiviSidebar Widget Tests', () {
    testWidgets('should render sidebar with menu items', (WidgetTester tester) async {
      final items = [
        const DiviSidebarItem(icon: Icons.home, label: 'Home'),
        const DiviSidebarItem(icon: Icons.settings, label: 'Settings'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DiviSidebar(
              items: items,
              selectedIndex: 0,
              onItemSelected: (index) {},
            ),
          ),
        ),
      );

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('should call onItemSelected when item tapped', (WidgetTester tester) async {
      int? selectedIndex;
      final items = [
        const DiviSidebarItem(icon: Icons.home, label: 'Home'),
        const DiviSidebarItem(icon: Icons.settings, label: 'Settings'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) => Scaffold(
              body: DiviSidebar(
                items: items,
                selectedIndex: 0,
                onItemSelected: (index) {
                  selectedIndex = index;
                  setState(() {});
                },
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Settings'));
      await tester.pump();

      expect(selectedIndex, 1);
    });
  });
}
