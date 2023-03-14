import 'package:flutter/material.dart';
import 'package:judoseclin/landing_page/more_infos/more_info.dart';
import 'package:judoseclin/landing_page/splash/news_container.dart';
import 'package:judoseclin/theme.dart';

import 'splash/logo_and_name.dart';
import 'splash/show_more_button.dart';

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
                  MoreInfo(),
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
