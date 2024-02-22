import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:judoseclin/ui/common/widgets/appbar/custom_appbar.dart';
import 'package:judoseclin/ui/common/widgets/images/image_fond_ecran.dart';

import '../../../common/widgets/buttons/custom_buttom.dart';
import '../../../cotisations/interactor/cotisation_interactor.dart';
import '../../interactor/adherents_interactor.dart';
import 'info_field_adherents.dart';
import 'info_field_adherents_cotisation.dart';

class AdherentsDetailView extends StatelessWidget {
  final String adherentId;
  final AdherentsInteractor adherentsInteractor;
  final CotisationInteractor cotisationInteractor;

  const AdherentsDetailView({
    super.key,
    required this.adherentId,
    required this.adherentsInteractor,
    required this.cotisationInteractor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).size.width > 750
          ? const CustomAppBar(title: '')
          : AppBar(title: const Text('')), // Use a placeholder title
      drawer: MediaQuery.of(context).size.width <= 750 ? const CustomDrawer() : null,
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
              const SizedBox(
                height: 60,
              ),
              InfoFieldAdherentsCotisation(
                adherentId: adherentId.toString(),
                cotisationInteractor: cotisationInteractor,
              ),
              CustomButton(
                label: 'Ajouter la cotisation',
                onPressed: () =>
                    context.go('/admin/add/cotisation/$adherentId'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
