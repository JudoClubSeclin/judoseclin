import 'package:flutter/material.dart';
import 'package:judoseclin/ui/common/widgets/buttons/connexion_button.dart';

import '../../configuration_locale.dart';
import '../../data/repository/competition_repository.dart';
import '../landing_page/landing_home.dart';
import '../landing_page/landing_show_button.dart';
import '../more_infos/more_info.dart';
import '../news/landing_news.dart';

class Landing extends StatelessWidget {
  final CompetitionRepository competitionRepository;

  const Landing({super.key, required this.competitionRepository});

  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController();

    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [const LandingHome(), const LandingNews(), MoreInfo()],
            ),
            Positioned(
              top: 40.0, // Ajustez la position verticale
              right: 10.0, // Ajustez la position horizontale
              child:
                  ConfigurationLocale.instance.peutSeConnecter
                      ? const ConnexionButton()
                      : const SizedBox(),
            ),
            ShowButton(scrollController: controller),
          ],
        ),
      ),
    );
  }
}
