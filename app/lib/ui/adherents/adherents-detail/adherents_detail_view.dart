import 'package:flutter/material.dart';
import 'package:judoseclin/domain/entities/adherents.dart';
import 'package:judoseclin/ui/common/widgets/appbar/custom_appbar.dart';
import 'package:judoseclin/ui/common/widgets/images/image_fond_ecran.dart';
import '../../../core/utils/generete_and_download_pdf.dart';
import '../../common/widgets/buttons/custom_buttom.dart';
import '../../cotisations/interactor/cotisation_interactor.dart';
import '../interactor/adherents_interactor.dart';
import 'info_field_adherents.dart';
import 'info_field_adherents_cotisation.dart';

class AdherentsDetailView extends StatelessWidget {
  final String adherentId;
  final AdherentsInteractor adherentsInteractor;
  final CotisationInteractor cotisationInteractor;
  final Adherents adherent;

  const AdherentsDetailView({
    super.key,
    required this.adherentId,
    required this.adherentsInteractor,
    required this.cotisationInteractor,
    required this.adherent,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ''),
      drawer: MediaQuery.sizeOf(context).width > 750 ? null : CustomDrawer(),
      body: DecoratedBox(
        position: DecorationPosition.background,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageFondEcran.imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: InfoFieldAdherents(
                  adherentsInteractor: adherentsInteractor,
                  adherentId: adherentId.toString(),
                ),
              ),
              const SizedBox(height: 60),
              InfoFieldAdherentsCotisation(
                adherentId: adherentId.toString(),
                cotisationInteractor: cotisationInteractor,
              ),

              /*CustomButton(
                    label: 'Ajouter la cotisation',
                    onPressed: () =>
                        context.go('/admin/add/cotisation/$adherentId'),
                  ),*/
              CustomButton(
                label: "Télécharger la fiche PDF",
                onPressed: () {
                  generateAndPrintPdf(adherentId, adherentsInteractor);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
