import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/material.dart';

extension StringArrayExtensions on List<String> {
  List<Widget> toMardown() => map((e) => Markdown(data: e)).toList();
}
