import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:divi/shared/widgets/form/divi_input.dart';

void main() {
  group('DiviInput Widget Tests', () {
    testWidgets('should render input field with label', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: FThemes.neutral.light.desktop.toApproximateMaterialTheme(),
          home: Form(
            child: Scaffold(
              body: DiviInput(
                label: 'Test Label',
              ),
            ),
          ),
        ),
      );

      // The input should display the label
      expect(find.text('Test Label'), findsOneWidget);
      
      // The input field itself should be present
      expect(find.byType(FTextFormField), findsOneWidget);
    });

    testWidgets('should support validator parameter', (WidgetTester tester) async {
      String? validationResult;
      
      await tester.pumpWidget(
        MaterialApp(
          theme: FThemes.neutral.light.desktop.toApproximateMaterialTheme(),
          home: Form(
            child: Scaffold(
              body: DiviInput(
                label: 'Test Label',
                validator: (value) {
                  validationResult = (value == null || value.isEmpty) ? 'Required' : null;
                  return validationResult;
                },
              ),
            ),
          ),
        ),
      );

      // The widget should accept the validator without error
      expect(find.byType(FTextFormField), findsOneWidget);
    });

    testWidgets('should call onChanged when text is entered', (WidgetTester tester) async {
      String? enteredText;
      
      await tester.pumpWidget(
        MaterialApp(
          theme: FThemes.neutral.light.desktop.toApproximateMaterialTheme(),
          home: Form(
            child: Scaffold(
              body: DiviInput(
                label: 'Test Label',
                onChanged: (value) => enteredText = value,
              ),
            ),
          ),
        ),
      );

      // Find the text field and enter text
      await tester.enterText(find.byType(EditableText), 'Hello World');
      await tester.pump();

      expect(enteredText, 'Hello World');
    });

    testWidgets('should display hint text when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: FThemes.neutral.light.desktop.toApproximateMaterialTheme(),
          home: Form(
            child: Scaffold(
              body: DiviInput(
                label: 'Test Label',
                hintText: 'Enter something...',
              ),
            ),
          ),
        ),
      );

      expect(find.text('Enter something...'), findsOneWidget);
    });

    testWidgets('should support obscureText for password fields', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: FThemes.neutral.light.desktop.toApproximateMaterialTheme(),
          home: Form(
            child: Scaffold(
              body: DiviInput(
                label: 'Password',
                obscureText: true,
              ),
            ),
          ),
        ),
      );

      // Find the EditableText widget and check obscureText property
      final editableText = tester.widget<EditableText>(find.byType(EditableText));
      expect(editableText.obscureText, true);
    });

    testWidgets('should support keyboardType parameter', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: FThemes.neutral.light.desktop.toApproximateMaterialTheme(),
          home: Form(
            child: Scaffold(
              body: DiviInput(
                label: 'Number Input',
                keyboardType: TextInputType.number,
              ),
            ),
          ),
        ),
      );

      final editableText = tester.widget<EditableText>(find.byType(EditableText));
      expect(editableText.keyboardType, TextInputType.number);
    });

    testWidgets('should support initialValue parameter', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: FThemes.neutral.light.desktop.toApproximateMaterialTheme(),
          home: Form(
            child: Scaffold(
              body: DiviInput(
                label: 'Test Label',
                initialValue: 'Initial Value',
              ),
            ),
          ),
        ),
      );

      expect(find.text('Initial Value'), findsOneWidget);
    });

    testWidgets('should support enabled parameter', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: FThemes.neutral.light.desktop.toApproximateMaterialTheme(),
          home: Form(
            child: Scaffold(
              body: DiviInput(
                label: 'Disabled Input',
                enabled: false,
              ),
            ),
          ),
        ),
      );

      // The widget should still be present but disabled
      expect(find.byType(FTextFormField), findsOneWidget);
    });
  });
}
