import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:divi/shared/widgets/data/divi_avatar.dart';

void main() {
  group('DiviAvatar Widget Tests', () {
    testWidgets('should render avatar with text', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DiviAvatar(
              label: 'JD',
            ),
          ),
        ),
      );

      expect(find.text('JD'), findsOneWidget);
    });

    testWidgets('should render avatar with image', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DiviAvatar(
              imageUrl: 'https://example.com/avatar.png',
              label: 'JD',
            ),
          ),
        ),
      );

      // CircleAvatar should be present even if image fails to load
      expect(find.byType(CircleAvatar), findsOneWidget);
    });

    testWidgets('should support custom size', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DiviAvatar(
              label: 'JD',
              radius: 30,
            ),
          ),
        ),
      );

      final avatar = tester.widget<CircleAvatar>(find.byType(CircleAvatar));
      expect(avatar.radius, 30);
    });
  });
}
