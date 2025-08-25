import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:demo/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Counter increments when FAB is tapped', (tester) async {
    // Start the app
    app.main();
    await tester.pumpAndSettle();

    // Verify initial UI
    expect(find.text('Flutter Demo Home Page'), findsOneWidget);
    expect(find.text('You have tapped the button this many times:'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);

    // Tap the FloatingActionButton (tooltip: 'Increment')
    await tester.tap(find.byTooltip('Increment'));
    await tester.pumpAndSettle();

    // Verify the counter incremented
    expect(find.text('1'), findsOneWidget);
    expect(find.text('0'), findsNothing);
  });
}
