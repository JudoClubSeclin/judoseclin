import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../configuration_locale.dart';
import '../../../common/theme/theme.dart';
import '../../../common/widgets/appbar/custom_appbar.dart';
import '../../../common/widgets/buttons/custom_buttom.dart';
import '../../../common/widgets/images/image_fond_ecran.dart';
import '../../../common/widgets/inputs/custom_textfield.dart';
import '../bloc/add_competition_bloc.dart';
import '../bloc/add_competition_event.dart';

class FormWidget extends StatelessWidget {
  final addressController = TextEditingController();
  final titleController = TextEditingController();
  final subtitleController = TextEditingController();
  final dateController = TextEditingController();
  final poussinController = TextEditingController();
  final benjaminController = TextEditingController();
  final minimeController = TextEditingController();
  final cadetController = TextEditingController();
  final juniorSeniorController = TextEditingController();
  final DateTime? publishDate;
  final String addCompetitionId;

  FormWidget(
    BuildContext context, {
    super.key,
    this.publishDate,
    required this.addCompetitionId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).size.width > 750
          ? const CustomAppBar(title: '')
          : AppBar(title: const Text('')), // Use a placeholder title
      drawer: MediaQuery.of(context).size.width <= 750
          ? const CustomDrawer()
          : null,
      body: DecoratedBox(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(ImageFondEcran.imagePath),
          fit: BoxFit.cover,
        )),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Ajouter une compétition',
                  style: titleStyleMedium(context),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 40,
                  runSpacing: 20,
                  children: [
                    CustomTextField(
                        labelText: 'Adresse', controller: addressController),
                    const SizedBox(width: 20),
                    CustomTextField(
                        labelText: 'Titre', controller: titleController),
                    const SizedBox(height: 20),
                    CustomTextField(
                        labelText: 'Sous titre',
                        controller: subtitleController),
                    const SizedBox(width: 20),
                    CustomTextField(
                        labelText: 'date', controller: dateController),
                    const SizedBox(height: 20),
                    CustomTextField(
                        labelText: 'Poussin', controller: poussinController),
                    const SizedBox(width: 20),
                    CustomTextField(
                        labelText: 'Benjamin', controller: benjaminController),
                    const SizedBox(height: 20),
                    CustomTextField(
                        labelText: 'Minime', controller: minimeController),
                    const SizedBox(width: 20),
                    CustomTextField(
                        labelText: 'cadet', controller: cadetController),
                    const SizedBox(height: 20),
                    CustomTextField(
                        labelText: 'junior senior',
                        controller: juniorSeniorController),
                    const SizedBox(width: 20),
                  ],
                ),
                const SizedBox(height: 20),
                ConfigurationLocale.instance.peutSeConnecter
                    ? CustomButton(
                        onPressed: () async {
                          try {
                            // Convertir la chaîne de date en objet DateTime
                            DateTime parsedDate = DateFormat('dd/MM/yyyy')
                                .parse(dateController.text.trim());

                            // Créer la date de publication (utiliser DateTime.now() pour la date actuelle)
                            DateTime publishDate = DateTime.now();

                            // Utiliser la date convertie dans votre AddCompetitionSignUpEvent
                            context.read<AddCompetitionBloc>().add(
                                  AddCompetitionSignUpEvent(
                                    id: '',
                                    address: addressController.text.trim(),
                                    title: titleController.text.trim(),
                                    subtitle: subtitleController.text.trim(),
                                    date: parsedDate,
                                    publishDate: publishDate,
                                    poussin: poussinController.text.trim(),
                                    benjamin: benjaminController.text.trim(),
                                    minime: minimeController.text.trim(),
                                    cadet: cadetController.text.trim(),
                                    juniorSenior:
                                        juniorSeniorController.text.trim(),
                                  ),
                                );

                            // Réinitialiser les contrôleurs de texte
                            addressController.clear();
                            titleController.clear();
                            subtitleController.clear();
                            dateController.clear();
                            poussinController.clear();
                            benjaminController.clear();
                            minimeController.clear();
                            cadetController.clear();
                            juniorSeniorController.clear();
                          } catch (e) {
                            debugPrint(
                                'Erreur d\'enregistrement des données: $e');
                          }
                        },
                        label: 'publier',
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
