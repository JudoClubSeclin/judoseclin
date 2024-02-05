import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:judoseclin/ui/common/adherents/interactor/adherents_interactor.dart';
import 'package:judoseclin/ui/common/adherents/view/adherents-detail/info_field_adherents.dart';
import 'package:judoseclin/ui/common/cotisations/interactor/cotisation_interactor.dart';
import 'package:judoseclin/ui/common/widgets/appbar/custom_appbar.dart';
import 'package:judoseclin/ui/common/widgets/images/image_fond_ecran.dart';

import '../../../widgets/buttons/custom_buttom.dart';
import 'info_field_adherents_cotisation.dart';

class AdherentsDetailView extends StatelessWidget {
  final String adherentId;
  final AdherentsInteractor adherentsInteractor;
  final CotisationInteractor cotisationInteractor;

  const AdherentsDetailView(
      {super.key,
      required this.adherentId,
      required this.adherentsInteractor,
      required this.cotisationInteractor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'Détail adherent'),
        body: DecoratedBox(
            position: DecorationPosition.background,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage(ImageFondEcran.imagePath),
              fit: BoxFit.cover,
            )),
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(children: [
                  Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      //spacing: 4.0, // Espacement horizontal entre les éléments
                      runSpacing: 30.0, // Espacement vertical entre les lignes
                      children: [
                        InfoFieldAdherents(
                          adherentsInteractor: adherentsInteractor,
                          adherentId: '',
                        ),
                        InfoFieldAdherentsCotisation(
                          adherentId: '',
                          cotisationInteractor: cotisationInteractor,
                        ),
                        CustomButton(
                          label: 'Ajouter la cotisation',
                          onPressed: () =>
                              context.go('/admin/add/cotisation/$adherentId'),
                        )
                      ])
                ]))));
  }
}
