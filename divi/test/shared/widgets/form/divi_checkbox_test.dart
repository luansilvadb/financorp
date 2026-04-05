import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:divi/shared/widgets/form/divi_checkbox.dart';

void main() {
  group('DiviCheckbox Widget Tests', () {
    testWidgets('should render checkbox with label', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: FThemes.neutral.light.desktop.toApproximateMaterialTheme(),
          home: Scaffold(
            body: DiviCheckbox(
              label: 'Test Checkbox',
              value: false,
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.text('Test Checkbox'), findsOneWidget);
      expect(find.byType(FCheckbox), findsOneWidget);
    });

    testWidgets('should call onChanged when tapped', (WidgetTester tester) async {
      bool? newValue;

      await tester.pumpWidget(
        MaterialApp(
          theme: FThemes.neutral.light.desktop.toApproximateMaterialTheme(),
          home: StatefulBuilder(
            builder: (context, setState) => Scaffold(
              body: DiviCheckbox(
                label: 'Test Checkbox',
                value: false,
                onChanged: (value) {
                  newValue = value;
                  setState(() {});
                },
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(FCheckbox));
      await tester.pumpAndSettle();

      expect(newValue, true);
    });

    testWidgets('should display error text when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: FThemes.neutral.light.desktop.toApproximateMaterialTheme(),
          home: Scaffold(
            body: DiviCheckbox(
              label: 'Test Checkbox',
              value: false,
              onChanged: (value) {},
              errorText: 'This field is required',
            ),
          ),
        ),
      );

      expect(find.text('This field is required'), findsOneWidget);
    });

    testWidgets('should support disabled state', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: FThemes.neutral.light.desktop.toApproximateMaterialTheme(),
          home: Scaffold(
            body: DiviCheckbox(
              label: 'Disabled Checkbox',
              value: false,
              onChanged: (value) {},
              enabled: false,
            ),
          ),
        ),
      );

      expect(find.byType(FCheckbox), findsOneWidget);
    });
  });
}
