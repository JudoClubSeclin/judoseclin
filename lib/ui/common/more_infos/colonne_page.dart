import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:judoseclin/ui/common/more_infos/oriented_size_box.dart';
import 'package:judoseclin/ui/common/theme.dart';


import 'package:url_launcher/url_launcher.dart';

class ColonnePage extends HookWidget {
  final String docUrl;
  final double fraction;
  final Size size;
  const ColonnePage(
      {
    Key? key,
        required this.docUrl,
        required this.fraction,
        required this.size
        }): super(key: key);

  @override
  Widget build(BuildContext context) {
    final contenu = useState<String>("...");
    rootBundle.loadString(docUrl).then((value){
      contenu.value = value;
    });

    return OrientedSizedBox(
      size: size,
      fraction: fraction,
      child:  Card(

        color: Colors.white,
        child: SizedBox(
         height: MediaQuery.sizeOf(context).height *1.33,

        child: Padding(

          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
          child: MarkdownBody(
            data: contenu.value,
            styleSheet: getMDTheme(context, Colors.black),
            onTapLink: (text, url, title){
              if(url != null){
                launchUrl(Uri.parse(url));
    }
              }

          ),
        ),
      ),
      )
    );
  }
}
