import 'package:flutter_test/flutter_test.dart';
import 'package:app_casa_transparente/main.dart';

void main() {
  testWidgets('App should render', (WidgetTester tester) async {
    await tester.pumpWidget(const CasaApp());
    expect(find.text('Casa da Família'), findsOneWidget);
  });
}
