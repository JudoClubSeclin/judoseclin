import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

extension StringArrayExtensions on List<String> {
  List<Widget> toMarkdown() => map((e) => Markdown(data: e)).toList();

  // List<Widget> toMenu() => ToggleButtons();
}