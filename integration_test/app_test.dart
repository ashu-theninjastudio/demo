import 'package:demo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  // Initialize integration test binding so tests can run on real devices/emulators
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
      as IntegrationTestWidgetsFlutterBinding;

  testWidgets('Counter increments via FAB tap', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Initial state
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Interact and verify
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.text('1'), findsOneWidget);

    // Capture a screenshot artifact during the integration run (device-only)
    await binding.takeScreenshot('counter_after_increment');
  });

  testWidgets('Golden: Home page initial and after tap', (WidgetTester tester) async {
    // Make layout deterministic for golden comparison
    await tester.binding.setSurfaceSize(const Size(400, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const MyApp());

    // Initial screen golden
    await expectLater(
      find.byType(MyApp),
      matchesGoldenFile('goldens/home_initial.png'),
    );

    // Interact and capture post-interaction golden
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(MyApp),
      matchesGoldenFile('goldens/home_after_tap.png'),
    );
  });
}
