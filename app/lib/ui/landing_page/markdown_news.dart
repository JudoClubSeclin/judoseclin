import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../theme.dart';

class MarkdownedNews extends StatelessWidget {
  final String text;

  const MarkdownedNews({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Markdown(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      data: text,
      styleSheet: getMDTheme(context, Colors.white),
    );
  }
}
