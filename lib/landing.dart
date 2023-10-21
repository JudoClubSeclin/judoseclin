import 'package:flutter/material.dart';
import 'package:judoseclin/ui/common/landing_page/landing_home.dart';
import 'package:judoseclin/ui/common/landing_page/landing_news.dart';
import 'package:judoseclin/ui/common/widgets/buttons/connexion_button.dart';
import 'package:judoseclin/ui/common/widgets/buttons/landing_show_button.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController();

    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Stack(
          children: [
            const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                LandingHome(),
                LandingNews(),
              ],
            ),
            const Positioned(
              top: 40.0, // Ajustez la position verticale
              right: 10.0, // Ajustez la position horizontale
              child: ConnexionButton(),
            ),
            ShowButton(scrollController: controller),
          ],
        ),
      ),
    );
  }
}
