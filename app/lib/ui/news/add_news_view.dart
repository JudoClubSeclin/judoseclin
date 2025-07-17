import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:judoseclin/theme.dart';
import 'package:judoseclin/ui/common/widgets/appbar/custom_appbar.dart';
import 'package:judoseclin/ui/common/widgets/buttons/custom_buttom.dart';
import 'package:judoseclin/ui/common/widgets/images/image_fond_ecran.dart';
import 'package:judoseclin/ui/common/widgets/inputs/custom_textfield.dart';
import 'package:judoseclin/ui/news/news_state.dart';
import 'package:judoseclin/ui/news/news_bloc.dart';
import 'package:judoseclin/ui/news/news_event.dart';

class AddNewsView extends StatelessWidget {
  final titreController = TextEditingController();
  final contenuController = TextEditingController();
  final publicationController = TextEditingController();

  AddNewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewsBloc, NewsState>(
      listener: (context, state) {
        if (state is NewsSuccessState) {
          Future.microtask(() {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('News ajoutée avec succès !')),
            );
            Navigator.of(context).pop();
          });
        } else if (state is NewsErrorState) {
          Future.microtask(() {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Erreur : ${state.error}')),
            );
          });
        }
      },

      child: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return _buildForm(context);
          }
        },
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ''),
      drawer: MediaQuery.sizeOf(context).width > 749 ? null : CustomDrawer(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageFondEcran.imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Ajouter une news",
                  style: titleStyleMedium(context),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 40.0,
                  runSpacing: 20.0,
                  children: [
                    CustomTextField(
                      labelText: 'titre',
                      controller: titreController,
                    ),
                    const SizedBox(height: 40.0),
                    CustomTextField(
                      labelText: 'detail',
                      controller: contenuController,
                    ),
                    const SizedBox(height: 40.0),
                    CustomTextField(
                      labelText: 'date de publication',
                      controller: publicationController,
                    ),
                    const SizedBox(height: 40.0),
                    CustomButton(
                      onPressed: () async {
                        try {
                          DateTime parsedDate = DateFormat('dd/MM/yyyy')
                              .parse(publicationController.text.trim());

                          context.read<NewsBloc>().add(AddNewsSignUpEvent(
                                id: '',
                                titre: titreController.text.trim(),
                                contenu: contenuController.text.trim(),
                                publication: parsedDate,
                              ));

                          // Réinitialiser les contrôleurs de texte
                          titreController.clear();
                          contenuController.clear();
                          publicationController.clear();
                        } catch (e) {
                          debugPrint(
                              "Erreur lors de l'enregistrement des données: $e");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Date invalide ou autre erreur"),
                            ),
                          );
                        }
                      },
                      label: 'Enregistrer',
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
