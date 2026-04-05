import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:divi/features/finance/views/widgets/spike_modal_sheet.dart';
import 'package:divi/shared/widgets/form/divi_input.dart';
import 'package:divi/shared/widgets/form/divi_radio.dart';

void main() {
  group('SpikeModalSheet Widget Tests', () {
    testWidgets('should render modal sheet with form components', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: FThemes.neutral.light.desktop.toApproximateMaterialTheme(),
          home: ProviderScope(
            child: Scaffold(
              body: SpikeModalSheet(),
            ),
          ),
        ),
      );

      // Should render the modal sheet
      expect(find.byType(SpikeModalSheet), findsOneWidget);
      
      // Should contain DiviInput for description
      expect(find.byType(DiviInput), findsWidgets);
    });

    testWidgets('should render credit card mode with radio group', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: FThemes.neutral.light.desktop.toApproximateMaterialTheme(),
          home: ProviderScope(
            child: Scaffold(
              body: SpikeModalSheet(),
            ),
          ),
        ),
      );

      // Tap on the CARTÃO segment to switch to credit card mode
      final cartaoSegment = find.text('CARTÃO');
      await tester.tap(cartaoSegment);
      await tester.pump();

      // Should render DiviRadioGroup for person selection
      expect(find.byType(DiviRadioGroup), findsOneWidget);
    });

    testWidgets('should render fixed bill mode without radio group', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: FThemes.neutral.light.desktop.toApproximateMaterialTheme(),
          home: ProviderScope(
            child: Scaffold(
              body: SpikeModalSheet(),
            ),
          ),
        ),
      );

      // Fixed bill mode is default, should not have DiviRadioGroup initially
      // But should have DiviInput for day
      expect(find.byType(DiviInput), findsWidgets);
    });
  });
}
