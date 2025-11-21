import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:landing_page/src/ui/ui_module.dart';

void main() {
  testWidgets('WithImageOnly utilise le bon chemin image', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LandingPage(),
      ),
    );

    // Vérifie que DecorationImage a été créé avec ton chemin
    final containerFinder = find.byType(Container);
    final containerWidget = tester.widget<Container>(containerFinder.first);

    final decoration = containerWidget.decoration as BoxDecoration;
    final image = decoration.image!.image as AssetImage;

    expect(image.assetName, "assets/images/bg-appbar-1.png");
    expect(image.package, "landing_page");
  });
}
