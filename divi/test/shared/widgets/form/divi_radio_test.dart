import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:divi/shared/widgets/form/divi_radio.dart';

void main() {
  group('DiviRadio Widget Tests', () {
    testWidgets('should render radio button with label', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: FThemes.neutral.light.desktop.toApproximateMaterialTheme(),
          home: Scaffold(
            body: DiviRadio(
              label: 'Option 1',
              value: 'option1',
              groupValue: 'option1',
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.text('Option 1'), findsOneWidget);
      expect(find.byType(FRadio), findsOneWidget);
    });

    testWidgets('should call onChanged when selected', (WidgetTester tester) async {
      String? selectedValue;

      await tester.pumpWidget(
        MaterialApp(
          theme: FThemes.neutral.light.desktop.toApproximateMaterialTheme(),
          home: Scaffold(
            body: DiviRadio(
              label: 'Option 1',
              value: 'option1',
              groupValue: 'option2',
              onChanged: (value) => selectedValue = value,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(FRadio));
      // Pump and settle to allow forui tappable animations to complete
      await tester.pumpAndSettle();

      expect(selectedValue, 'option1');
    });

    testWidgets('should support disabled state', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: FThemes.neutral.light.desktop.toApproximateMaterialTheme(),
          home: Scaffold(
            body: DiviRadio(
              label: 'Disabled Option',
              value: 'option1',
              groupValue: 'option1',
              onChanged: (value) {},
              enabled: false,
            ),
          ),
        ),
      );

      expect(find.byType(FRadio), findsOneWidget);
    });
  });

  group('DiviRadioGroup Widget Tests', () {
    final options = ['Option 1', 'Option 2', 'Option 3'];

    testWidgets('should render radio group with label and options', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: FThemes.neutral.light.desktop.toApproximateMaterialTheme(),
          home: Scaffold(
            body: DiviRadioGroup(
              label: 'Test Group',
              options: options,
              value: 'Option 1',
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.text('Test Group'), findsOneWidget);
      expect(find.text('Option 1'), findsOneWidget);
      expect(find.text('Option 2'), findsOneWidget);
      expect(find.text('Option 3'), findsOneWidget);
    });

    testWidgets('should call onChanged when option selected', (WidgetTester tester) async {
      String? selectedValue;
      String currentValue = 'Option 1';

      await tester.pumpWidget(
        MaterialApp(
          theme: FThemes.neutral.light.desktop.toApproximateMaterialTheme(),
          home: StatefulBuilder(
            builder: (context, setState) => Scaffold(
              body: StatefulBuilder(
                builder: (context, setInnerState) {
                  return DiviRadioGroup(
                    label: 'Test Group',
                    options: options,
                    value: currentValue,
                    onChanged: (value) {
                      selectedValue = value;
                      setInnerState(() => currentValue = value!);
                    },
                  );
                },
              ),
            ),
          ),
        ),
      );

      // Find the FRadio widget for Option 2 and tap on it
      await tester.tap(find.byType(FRadio).at(1));
      await tester.pumpAndSettle();

      expect(selectedValue, 'Option 2');
    });
  });
}
