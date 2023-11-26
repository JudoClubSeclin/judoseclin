import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:judoseclin/ui/common/theme/theme.dart';
import 'package:judoseclin/ui/common/widgets/images/image_fond_ecran.dart';

import '../../widgets/appbar/custom_appbar.dart';

class ListAdherentsView extends StatelessWidget {
  const ListAdherentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('adherents').snapshots(),
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
          return const Text('Aucun adherents  trouvé.');
        }

        final adherents = snapshot.data!.docs;

        return Scaffold(
          appBar: CustomAppBar(
            title: '',
            actions: [
              GestureDetector(
                onTap: () {},
                child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Center(child: Text(''))),
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
                          side: BorderSide(color: Colors.red[400]!, width: 2.0),
                        ),
                        child: ListTile(
                          title: Wrap(
                            children: [
                              Text('Liste des adherents',
                                  style: titleStyleMedium(context)),
                            ],
                          ),
                          onTap: () {
                            String adherentsId = adherent.id.toString();
                            if (adherentsId.isNotEmpty) {
                              context.go('account/adherents/$adherentsId');
                            } else {
                              // L'ID est vide, donc vous pouvez afficher un message d'erreur ou effectuer une autre action si nécessaire.
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('adherent introuvable')),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
