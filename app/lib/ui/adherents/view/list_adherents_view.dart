import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:judoseclin/theme.dart';
import 'package:judoseclin/ui/common/widgets/images/image_fond_ecran.dart';

import '../../../domain/entities/adherents.dart';
import '../../common/widgets/Custom_card/custom_card.dart';
import '../../common/widgets/appbar/custom_appbar.dart';
import '../adherents_interactor.dart';

class ListAdherentsView extends StatelessWidget {
  final AdherentsInteractor interactor;
  const ListAdherentsView({super.key, required this.interactor});

  @override
  Widget build(BuildContext context) {
    debugPrint('>>> ListAdherentsView build() appelé');
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
          drawer: MediaQuery.sizeOf(context).width > 750 ? null : CustomDrawer(),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageFondEcran.imagePath),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Liste des adherents',
                    style: titleStyleMedium(context),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    '${adherents.length} adhérent${adherents.length > 1 ? 's' : ''}',
                    style: textStyleText(context).copyWith(fontSize: 16),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: adherents.length,
                    itemBuilder: (context, index) {
                      final adherent = adherents.elementAt(index);

                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: CustomCard(
                              title: '${adherent.firstName} ${adherent.lastName}',
                              subTitle: adherent.email,
                              onTap: () {
                                final adherentId = adherent.id;
                                if (adherentId.isNotEmpty) {
                                  context.goNamed(
                                    'adherents_detail',
                                    pathParameters: {'id': adherentId},
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
