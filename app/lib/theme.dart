import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

ThemeData theme = ThemeData(
  primarySwatch: Colors.red,
  secondaryHeaderColor: Colors.blueGrey,
  primaryColor: Colors.black
);

MarkdownStyleSheet getMDTheme(BuildContext context, Color fontColor) =>
    MarkdownStyleSheet(
      p: Theme.of(context).textTheme.bodyLarge?.copyWith(color: fontColor),
      h1: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: fontColor,
            fontFamily: "Hiromisake",
            height: 2,
          ),
      h2: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: fontColor,
            fontFamily: "Hiromisake",
            height: 2,
          ),
      h3: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: fontColor,
            height: 2,
          ),
      listBullet:
          Theme.of(context).textTheme.bodyLarge?.copyWith(color: fontColor),
      listBulletPadding: const EdgeInsets.only(top: 10, left: 20),
    );



TextStyle titleStyle(BuildContext context) {
  Size size = MediaQuery.of(context).size; // Correction : utilisation de MediaQuery.of
  double titlefont = size.width / 10; // Correction : suppression de la nullabilité
  return TextStyle(
    fontSize: titlefont,
    color: Theme.of(context).primaryColor, // Correction : accès au thème via Theme.of
    fontFamily: "Hiromisake",
    shadows: [
      Shadow(
        offset: Offset(1.0, 1.0),
        blurRadius: 3.0,
        color: Colors.white,
      ),
    ],
  );
}


TextStyle titleStyleLarge(BuildContext context) {
  Size size = MediaQuery.of(context).size; // Correction : utilisation de MediaQuery.of
  double titlefont = size.width / 10; // Correction : suppression de la nullabilité
  return TextStyle(
    fontSize: titlefont,
    color: Theme.of(context).primaryColor, // Correction : utilisation de Theme.of
    fontFamily: "Hiromisake",
    shadows: [
      Shadow(
        offset: Offset(1.0, 1.0),
        blurRadius: 3.0,
        color: Colors.white,
      ),
    ], // Correction : position correcte des parenthèses
  );
}


TextStyle titleStyleMedium(BuildContext context) {
  Size size = MediaQuery.of(context).size; // Correction : utilisation de MediaQuery.of
  double titlefont = size.width / 18; // Correction : suppression de la nullabilité
  return TextStyle(
    fontSize: titlefont,
    color: Theme.of(context).primaryColor, // Correction : utilisation de Theme.of
    fontFamily: "Hiromisake",
    shadows: [
      Shadow(
        offset: Offset(1.0, 1.0),
        blurRadius: 3.0,
        color: Colors.white,
      ),
    ], // Correction : position correcte des parenthèses
  );
}

TextStyle titleStyleSmall(BuildContext context) {
  Size size = MediaQuery.of(context).size; // Correction : utilisation de MediaQuery.of
  double titlefont = size.width / 30; // Correction : suppression de la nullabilité
  return TextStyle(
    fontSize: titlefont,
    color: Theme.of(context).primaryColor, // Correction : utilisation de Theme.of
    fontFamily: "Hiromisake",
    shadows: [
      Shadow(
        offset: Offset(1.0, 1.0),
        blurRadius: 3.0,
        color: Colors.white,
      ),
    ], // Correction : position correcte des parenthèses
  );
}

TextStyle textStyleText(BuildContext context) {
  Size size = MediaQuery.of(context).size; // Correction : utilisation de MediaQuery.of
  double titlefont = size.width / 10; // Correction : suppression de la nullabilité
  return TextStyle(
    fontSize: titlefont,
    color: Theme.of(context).primaryColor, // Correction : utilisation de Theme.of
    fontFamily: "Hiromisake",
    shadows: [
      Shadow(
        offset: Offset(1.0, 1.0),
        blurRadius: 3.0,
        color: Colors.white,
      ),
    ], // Correction : position correcte des parenthèses
  );
}

TextStyle? textStyleInput(BuildContext context, String inputText) {
  int baseFontSize = 20;
  double textFontSize =
      inputText.length > 20 ? baseFontSize - 1.5 : baseFontSize.toDouble();

  return Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontSize: textFontSize,
            color: Colors.black,
            fontFamily: "robot",
            // Ajoute d'autres propriétés de style si nécessaire
          ) ??
      const TextStyle();
}
