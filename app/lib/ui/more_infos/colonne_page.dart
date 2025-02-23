import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:judoseclin/theme.dart';
import 'package:url_launcher/url_launcher.dart';

import 'oriented_size_box.dart';

class ColonnePage extends HookWidget {
  final String docUrl;
  final double fraction;
  final Size size;
  const ColonnePage({
    super.key,
    required this.docUrl,
    required this.fraction,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final contenu = useState<String>("...");
    rootBundle.loadString(docUrl).then((value) {
      contenu.value = value;
    });

    return OrientedSizedBox(
      size: size,
      fraction: fraction,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
          child: MarkdownBody(
            data: contenu.value,
            styleSheet: getMDTheme(context, Colors.black),
            onTapLink: (text, url, title) {
              if (url != null) {
                launchUrl(Uri.parse(url));
              }
            },
          ),
        ),
      ),
    );
  }
}
