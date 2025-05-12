import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pamp/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Application démarre et affiche Livrables', (tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.text('Livrables'), findsOneWidget);
  });
}