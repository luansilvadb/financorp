import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:divi/shared/widgets/form/divi_textarea.dart';

void main() {
  group('DiviTextarea Widget Tests', () {
    testWidgets('should render textarea with label', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: FThemes.neutral.light.desktop.toApproximateMaterialTheme(),
          home: Form(
            child: Scaffold(
              body: DiviTextarea(
                label: 'Test Textarea',
              ),
            ),
          ),
        ),
      );

      expect(find.text('Test Textarea'), findsOneWidget);
      expect(find.byType(FTextFormField), findsOneWidget);
    });

    testWidgets('should display hint text when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: FThemes.neutral.light.desktop.toApproximateMaterialTheme(),
          home: Form(
            child: Scaffold(
              body: DiviTextarea(
                label: 'Test Textarea',
                hintText: 'Enter multiple lines...',
              ),
            ),
          ),
        ),
      );

      expect(find.text('Enter multiple lines...'), findsOneWidget);
    });

    testWidgets('should call onChanged when text is entered', (WidgetTester tester) async {
      String? enteredText;

      await tester.pumpWidget(
        MaterialApp(
          theme: FThemes.neutral.light.desktop.toApproximateMaterialTheme(),
          home: Form(
            child: Scaffold(
              body: DiviTextarea(
                label: 'Test Textarea',
                onChanged: (value) => enteredText = value,
              ),
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(EditableText), 'Hello World');
      await tester.pump();

      expect(enteredText, 'Hello World');
    });

    testWidgets('should support multiline input', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: FThemes.neutral.light.desktop.toApproximateMaterialTheme(),
          home: Form(
            child: Scaffold(
              body: DiviTextarea(
                label: 'Test Textarea',
                maxLines: 5,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(FTextFormField), findsOneWidget);
    });

    testWidgets('should support initialValue parameter', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: FThemes.neutral.light.desktop.toApproximateMaterialTheme(),
          home: Form(
            child: Scaffold(
              body: DiviTextarea(
                label: 'Test Textarea',
                initialValue: 'Initial text',
              ),
            ),
          ),
        ),
      );

      expect(find.text('Initial text'), findsOneWidget);
    });

    testWidgets('should support enabled parameter', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: FThemes.neutral.light.desktop.toApproximateMaterialTheme(),
          home: Form(
            child: Scaffold(
              body: DiviTextarea(
                label: 'Disabled Textarea',
                enabled: false,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(FTextFormField), findsOneWidget);
    });
  });
}
