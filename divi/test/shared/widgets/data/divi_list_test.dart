import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:divi/shared/widgets/data/divi_list.dart';

void main() {
  group('DiviList Widget Tests', () {
    testWidgets('should render list with items', (WidgetTester tester) async {
      final items = ['Item 1', 'Item 2', 'Item 3'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DiviList(
              items: items,
              itemBuilder: (context, item) => Text(item),
            ),
          ),
        ),
      );

      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
      expect(find.text('Item 3'), findsOneWidget);
    });

    testWidgets('should call onTap when item tapped', (WidgetTester tester) async {
      final items = ['Item 1', 'Item 2'];
      String? tappedItem;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DiviList(
              items: items,
              itemBuilder: (context, item) => Text(item),
              onTap: (item) => tappedItem = item,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Item 2'));
      await tester.pump();

      expect(tappedItem, 'Item 2');
    });
  });
}
