import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:divi/shared/widgets/form/divi_select.dart';

void main() {
  group('DiviSelect Widget Tests', () {
    final testOptions = [
      'Option 1',
      'Option 2',
      'Option 3',
    ];

    testWidgets('should render select field with label', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: FThemes.neutral.light.desktop.toApproximateMaterialTheme(),
          home: Form(
            child: Scaffold(
              body: DiviSelect(
                label: 'Test Label',
                options: testOptions,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Test Label'), findsOneWidget);
      expect(find.byType(FSelectFormField<String>), findsOneWidget);
    });

    testWidgets('should display hint text when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: FThemes.neutral.light.desktop.toApproximateMaterialTheme(),
          home: Form(
            child: Scaffold(
              body: DiviSelect(
                label: 'Test Label',
                options: testOptions,
                hint: 'Select an option',
              ),
            ),
          ),
        ),
      );

      expect(find.text('Select an option'), findsOneWidget);
    });

    testWidgets('should call onChanged when selection changes', (WidgetTester tester) async {
      String? selectedValue;
      
      await tester.pumpWidget(
        MaterialApp(
          theme: FThemes.neutral.light.desktop.toApproximateMaterialTheme(),
          home: Form(
            child: Scaffold(
              body: DiviSelect(
                label: 'Test Label',
                options: testOptions,
                onChanged: (value) => selectedValue = value,
              ),
            ),
          ),
        ),
      );

      // Tap to open dropdown
      await tester.tap(find.byType(FSelectFormField<String>));
      await tester.pumpAndSettle();

      // Select an option
      await tester.tap(find.text('Option 1').last);
      await tester.pumpAndSettle();

      expect(selectedValue, 'Option 1');
    });

    testWidgets('should support enabled parameter', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: FThemes.neutral.light.desktop.toApproximateMaterialTheme(),
          home: Form(
            child: Scaffold(
              body: DiviSelect(
                label: 'Test Label',
                options: testOptions,
                enabled: false,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(FSelectFormField<String>), findsOneWidget);
    });
  });
}
