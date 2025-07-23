import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:judoseclin/domain/entities/adherents.dart';
import 'package:judoseclin/domain/entities/cotisation.dart';
import 'package:judoseclin/ui/common/widgets/appbar/custom_appbar.dart';
import 'package:judoseclin/ui/common/widgets/images/image_fond_ecran.dart';
import '../../../core/utils/generete_and_download_pdf.dart';
import '../../common/widgets/buttons/custom_buttom.dart';
import '../../cotisations/cotisation_interactor.dart';
import '../adherents_interactor.dart';
import 'info_field_adherents.dart';
import 'info_field_adherents_cotisation.dart';

class AdherentsDetailView extends StatelessWidget {
  final String adherentId;
  final AdherentsInteractor adherentsInteractor;
  final CotisationInteractor cotisationInteractor;
  final Adherents adherent;
  final Cotisation cotisation;

  const AdherentsDetailView({
    super.key,
    required this.adherentId,
    required this.adherentsInteractor,
    required this.cotisationInteractor,
    required this.adherent,
    required this.cotisation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ''),
      drawer: MediaQuery.sizeOf(context).width > 750 ? null : const Drawer(),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageFondEcran.imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InfoFieldAdherents(
                adherentsInteractor: adherentsInteractor,
                adherentId: adherentId,
              ),

              const SizedBox(height: 40),

              SizedBox(
                height: 300,
                child: FutureBuilder<Iterable<Cotisation>>(
                  future: cotisationInteractor.fetchCotisationsByAdherentId(adherentId),
                  builder: (context, snapshot) {
                    debugPrint('FutureBuilder status: ${snapshot.connectionState}');
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      debugPrint('Chargement des cotisations...');
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      debugPrint('Erreur chargement cotisations: ${snapshot.error}');
                      return Center(child: Text('Erreur: ${snapshot.error}'));
                    }
                    final cotisations = snapshot.data?.toList() ?? [];
                    debugPrint('Nombre de cotisations reçues: ${cotisations.length}');
                    if (cotisations.isEmpty) {
                      return const Center(child: Text('Aucune cotisation trouvée'));
                    }
                    return ListView.builder(
                      itemCount: cotisations.length,
                      itemBuilder: (context, index) {
                        debugPrint('Affichage cotisation #$index: id=${cotisations[index].id}');
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: InfoFieldAdherentsCotisation(
                            cotisationInteractor: cotisationInteractor,
                            adherentId: adherentId,

                          ),
                        );
                      },
                    );
                  },
                ),
              ),



          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 600),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 15,
                runSpacing: 10,
                children: [
                  CustomButton(
                    label: 'Ajouter la cotisation',
                    onPressed: () {
                      context.go('/admin/add/cotisation/$adherentId');
                    },
                  ),
                  CustomButton(
                    label: 'Télécharger la fiche PDF',
                    onPressed: () {
                      generateAndPrintPdf(adherentId, adherentsInteractor,cotisationInteractor);
                    },
                  ),
                ],
              ),
            )
          ),
              const SizedBox(height: 30),
            ],

          ),
        ),
      ),
    );
  }
}
