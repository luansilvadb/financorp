import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_casa_transparente/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('App should render', (WidgetTester tester) async {
    // We need to wrap with ProviderScope because the app uses Riverpod
    await tester.pumpWidget(const ProviderScope(child: CasaApp()));

    // The main screen shows "Gestão Financeira" in the header
    expect(find.text('Gestão Financeira'), findsOneWidget);
  });
}
