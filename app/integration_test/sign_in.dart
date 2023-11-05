import 'package:anotei/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('it succesfully sign in', (WidgetTester tester) async {
    await tester.pumpWidget(app);
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const Key('emailField')), 'test@test.com');

    await tester.enterText(find.byKey(const Key('passwordField')), 'password');

    await tester.tap(find.byKey(const Key('loginButton')));

    await tester.pumpAndSettle();

    await expectLater(find.text('Anotei'), findsOneWidget);
  });
}
