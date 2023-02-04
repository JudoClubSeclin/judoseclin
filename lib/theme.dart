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
          ),
      h2: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: fontColor,
            fontFamily: "Hiromisake",
          ),
      h3: Theme.of(context).textTheme.headlineSmall?.copyWith(color: fontColor),
      listBullet:
          Theme.of(context).textTheme.bodyLarge?.copyWith(color: fontColor),
    );
