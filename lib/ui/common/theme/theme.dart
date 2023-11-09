import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

ThemeData theme = ThemeData(
  primarySwatch: Colors.red,
  secondaryHeaderColor: Colors.blueGrey,
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
  Size size = MediaQuery.sizeOf(context);
  double? titlefont = size.width / 10;
  return Theme.of(context).textTheme.headlineLarge?.copyWith(
        fontSize: titlefont,
        color: Colors.black,
        fontFamily: "Hiromisake",
        shadows: [
          const Shadow(
            offset: Offset(1.0, 1.0),
            blurRadius: 3.0,
            color: Colors.black,
          ),
        ],
      ) ??
      const TextStyle();
}

TextStyle titleStyleMedium(BuildContext context) {
  Size size = MediaQuery.sizeOf(context);
  double? titlefont = size.width / 18;
  return Theme.of(context).textTheme.headlineLarge?.copyWith(
        fontSize: titlefont,
        color: Colors.black,
        fontFamily: "Hiromisake",
        shadows: [
          const Shadow(
            offset: Offset(1.0, 1.0),
            blurRadius: 3.0,
            color: Colors.black,
          ),
        ],
      ) ??
      const TextStyle();
}

TextStyle titleStyleSmall(BuildContext context) {
  Size size = MediaQuery.sizeOf(context);
  double? titlefont = size.width / 30;
  return Theme.of(context).textTheme.headlineLarge?.copyWith(
        fontSize: titlefont,
        color: Colors.black,
        fontFamily: "robot",
        shadows: [
          const Shadow(
            offset: Offset(1.0, 1.0),
            blurRadius: 3.0,
            color: Colors.black,
          ),
        ],
      ) ??
      const TextStyle();
}
