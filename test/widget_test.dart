import 'package:flutter_test/flutter_test.dart';
import 'package:ai_cybershield/main.dart';

void main() {
  testWidgets('AI CyberShield app loads successfully', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(MyApp), findsOneWidget);
  });
}
