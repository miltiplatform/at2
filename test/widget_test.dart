import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_5/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MainApp());

    // Vérifie que l'app démarre correctement
    expect(find.text('Aucun produit ajouté'), findsOneWidget);

    // Exemple: si vous avez un bouton '+' pour ajouter un produit, vous pouvez tester un tap ici
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();

    // Vérifier les changements après interaction
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
  });
}
