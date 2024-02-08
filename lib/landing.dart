import 'package:flutter/material.dart';
import 'package:judoseclin/ui/common/competition/competition_repository/competition_repository.dart';
import 'package:judoseclin/ui/common/landing_page/landing_home.dart';
import 'package:judoseclin/ui/common/landing_page/landing_news.dart';
import 'package:judoseclin/ui/common/landing_page/landing_show_button.dart';
import 'package:judoseclin/ui/common/widgets/buttons/connexion_button.dart';

import 'configuration_locale.dart';
import 'more_info.dart';

class Landing extends StatelessWidget {
  final CompetitionRepository competitionRepository =
      ConcretedCompetitionRepository();

  Landing({
    super.key,
  });

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
              children: [
                const LandingHome(),
                const LandingNews(),
                MoreInfo(competitionRepository: competitionRepository)
              ],
            ),
            Positioned(
                top: 40.0, // Ajustez la position verticale
                right: 10.0, // Ajustez la position horizontale
                child: ConfigurationLocale.instance.peutSeConnecter
                    ? const ConnexionButton()
                    : const SizedBox()),
            ShowButton(scrollController: controller),
          ],
        ),
      ),
    );
  }
}
