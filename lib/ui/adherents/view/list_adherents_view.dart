import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:judoseclin/ui/common/routes/router_config.dart';
import 'package:judoseclin/ui/common/theme/theme.dart';
import 'package:judoseclin/ui/common/widgets/images/image_fond_ecran.dart';

import '../../common/widgets/appbar/custom_appbar.dart';
import '../interactor/adherents_interactor.dart';

class ListAdherentsView extends StatelessWidget {
  const ListAdherentsView({
    super.key,
    required adherentsRepository,
    required AdherentsInteractor interactor,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: adherentsRepository.firestore.collection('adherents').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Text('Erreur : ${snapshot.error}');
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text('Aucun adhérent trouvé.');
        }

        final adherents = snapshot.data!.docs;

        return Scaffold(
          appBar: CustomAppBar(
            title: 'Liste des adherents',
            actions: [
              GestureDetector(
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(child: Text('')),
                ),
              ),
            ],
          ),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageFondEcran.imagePath),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                // Titre en dehors de la liste
                Center(
                  child: Text(
                    'Liste des adherents',
                    style: titleStyleMedium(context),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: adherents.length,
                    itemBuilder: (context, index) {
                      final adherent = adherents[index];

                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Card(
                                color: Colors.transparent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: BorderSide(
                                    color: Colors.red[400]!,
                                    width: 2.0,
                                  ),
                                ),
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      Text(adherent['firstName'] as String),
                                      const SizedBox(
                                          width:
                                              8.0), // Espace entre le prénom et le nom
                                      Text(adherent['lastName'] as String),
                                    ],
                                  ),
                                  subtitle: Text(adherent['email'] as String),
                                  // Ajoutez ici le nom de l'adhérent
                                  onTap: () {
                                    String adherentsId = adherent.id.toString();
                                    if (adherentsId.isNotEmpty) {
                                      context.go(
                                          '/admin/list/adherents/$adherentsId');
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Adhérent introuvable')),
                                      );
                                    }
                                  },
                                )),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
