import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:judoseclin/theme.dart';
import 'package:judoseclin/ui/common/widgets/images/image_fond_ecran.dart';

import '../../../domain/entities/adherents.dart';
import '../../common/widgets/appbar/custom_appbar.dart';
import '../interactor/adherents_interactor.dart';

class ListAdherentsView extends StatelessWidget {
  const ListAdherentsView({super.key, required this.interactor});

  final AdherentsInteractor interactor;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Iterable<Adherents>>(
      future: interactor.fetchAdherentsData(),
      builder: (context, snapshot) {
        if (snapshot.hasError ||
            snapshot.data == null ||
            snapshot.data!.isEmpty) {
          return Scaffold(
            body: Center(
              child: Text(
                snapshot.hasError
                    ? 'Erreur : ${snapshot.error}'
                    : 'Aucun adhérent trouvé.',
              ),
            ),
          );
        }

        final adherents = snapshot.data!;

        return Scaffold(
          appBar: CustomAppBar(title: ''),
          drawer:
              MediaQuery.sizeOf(context).width > 750 ? null : CustomDrawer(),
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
                      Adherents adherent = adherents.elementAt(index);

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
                                  color: theme.colorScheme.primary,
                                  width: 2.0,
                                ),
                              ),
                              child: ListTile(
                                title: Row(
                                  children: [
                                    Text(
                                      adherent.firstName,
                                      style: textStyleText(context),
                                    ),
                                    const SizedBox(
                                      width: 8.0,
                                    ), // Espace entre le prénom et le nom
                                    Text(
                                      adherent.lastName,
                                      style: textStyleText(context),
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                  adherent.email,
                                  style: textStyleText(context),
                                ),
                                onTap: () {
                                  String adherentsId = adherent.id;
                                  if (adherentsId.isNotEmpty) {
                                    context.goNamed(
                                      'adherents_detail',
                                      pathParameters: {'id': adherentsId},
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Adhérent introuvable'),
                                      ),
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
              ],
            ),
          ),
        );
      },
    );
  }
}
