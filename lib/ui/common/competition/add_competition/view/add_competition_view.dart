import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:judoseclin/ui/common/competition/add_competition/bloc/add_competition_bloc.dart';
import 'package:judoseclin/ui/common/competition/add_competition/bloc/add_competition_event.dart';
import 'package:judoseclin/ui/common/theme/theme.dart';
import 'package:judoseclin/ui/common/widgets/appbar/custom_appbar.dart';
import 'package:judoseclin/ui/common/widgets/buttons/custom_buttom.dart';
import 'package:judoseclin/ui/common/widgets/images/image_fond_ecran.dart';
import 'package:judoseclin/ui/common/widgets/inputs/custom_textfield.dart';

import '../bloc/add_competition_state.dart';

class AddCompetitionView extends StatelessWidget {
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

  AddCompetitionView({super.key, this.publishDate});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCompetitionBloc, AddCompetitionState>(
      builder: (context, state) {
        if (state is AddCompetitionSignUpLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AddCompetitionSignUpErrorState) {
          return Text(state.error);
        } else if (state is AddCompetitionSignUpSuccessState) {
          return _buildForm(context, state.addCompetitionId);
        } else {
          return _buildForm(context, '');
        }
      },
    );
  }

  Widget _buildForm(BuildContext context, String addCompetitionId) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Ajouter une compétition'),
      body: DecoratedBox(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(ImageFondEcran.imagePath),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                        labelText: 'Adresse', controller: addressController),
                    CustomTextField(
                        labelText: 'Titre', controller: titleController)
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                        labelText: 'Sous titre',
                        controller: subtitleController),
                    CustomTextField(
                        labelText: 'date', controller: dateController)
                  ],
                ),
                const SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  CustomTextField(
                      labelText: 'Poussin', controller: poussinController),
                  CustomTextField(
                      labelText: 'Benjamin', controller: benjaminController),
                ]),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                        labelText: 'Minime', controller: minimeController),
                    CustomTextField(
                        labelText: 'cadet', controller: cadetController)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                        labelText: 'junior senior',
                        controller: juniorSeniorController),
                  ],
                ),
                const SizedBox(height: 20),
                CustomButton(
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
                              publishDate:
                                  publishDate, // Assurez-vous de spécifier la date de publication ici
                              poussin: poussinController.text.trim(),
                              benjamin: benjaminController.text.trim(),
                              minime: minimeController.text.trim(),
                              cadet: cadetController.text.trim(),
                              juniorSenior: juniorSeniorController.text.trim(),
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
                      debugPrint('Erreur d\'enregistrement des données: $e');
                    }
                  },
                  label: 'publier',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
