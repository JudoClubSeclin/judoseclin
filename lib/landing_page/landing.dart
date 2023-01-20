import 'package:flutter/material.dart';
import 'package:judoseclin/landing_page/news_container.dart';
import 'package:judoseclin/theme.dart';

import 'logo_and_name.dart';
import 'show_more_button.dart';

class Landing extends StatelessWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController();
    return MaterialApp(
      title: "Judo Club Seclin",
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: Scaffold(
        body: SingleChildScrollView(
          controller: controller,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  LogoAndName(),
                  NewsContainer(),
                ],
              ),
              ShowMoreButton(scrollController: controller),
            ],
          ),
        ),
      ),
    );
  }
}
