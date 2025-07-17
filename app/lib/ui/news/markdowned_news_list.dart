import 'package:flutter/widgets.dart';

import '../../domain/entities/news.dart';
import 'markdown_news.dart';


extension MarkdownNewsList on List<News> {
  List<Widget> toMarkdown() =>
      map((e) => MarkdownedNews(text: e.toMarkdownText())).toList();
}
