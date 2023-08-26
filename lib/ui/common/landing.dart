import 'package:flutter/material.dart';
import 'package:judoseclin/ui/common/landing_page/landing_home.dart';
import 'package:judoseclin/ui/common/landing_page/landing_news.dart';
import 'package:judoseclin/ui/common/landing_page/show_button.dart';
import 'package:judoseclin/ui/common/more_infos/more_info.dart';

import 'theme.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Judo Club Seclinois',
      theme: theme,
      home: Scaffold(
        body: SingleChildScrollView(
          controller: controller,
          child: Stack(
            children: [
             const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  LandingHome(),
                  LandingNews(),
                  MoreInfo()

                ],
              ),
              ShowButton(scrollController: controller),
            ],
          ),
        ),
      )
    );
  }
}
