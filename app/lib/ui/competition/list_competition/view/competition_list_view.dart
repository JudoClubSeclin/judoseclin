import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:judoseclin/theme.dart';
import 'package:judoseclin/ui/common/widgets/appbar/custom_appbar.dart';
import 'package:judoseclin/ui/common/widgets/images/image_fond_ecran.dart';
import 'package:judoseclin/ui/common/widgets/Custom_card/custom_card.dart';
import '../../../../core/utils/competition_provider.dart';
import '../../../account/adherents_session.dart'; // Pour récupérer les inscriptions

class CompetitionsListView extends StatelessWidget {
  final adherentId = GetIt.I<AdherentSession>().getAdherent();

   CompetitionsListView({super.key});

  @override
  Widget build(BuildContext context) {
    // Future pour les inscriptions de l'utilisateur (vide si non connecté)
    final userInscriptionsFuture = FirebaseAuth.instance.currentUser != null
        ? CompetitionRegistrationProvider().getUserInscriptionsForAdherent(adherentId!)
        : Future.value(<String>[]);

    return FutureBuilder<List<String>>(
      future: userInscriptionsFuture,
      builder: (context, inscriptionsSnapshot) {
        final userInscriptions = inscriptionsSnapshot.data ?? [];

        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('competition').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Erreur : ${snapshot.error}'));
            }

            final competitions = snapshot.data?.docs ?? [];

            if (competitions.isEmpty) {
              return Scaffold(
                appBar: CustomAppBar(title: ''),
                body: const Center(child: Text('Aucune compétition trouvée.')),
              );
            }

            return Scaffold(
              appBar: CustomAppBar(title: ''),
              body: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImageFondEcran.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ListView.builder(
                  itemCount: competitions.length,
                  itemBuilder: (context, index) {
                    final competition = competitions[index];

                    // Vérifie si l'utilisateur est inscrit (si connecté)
                    final isUserInscribed = userInscriptions.contains(competition.id);

                    // Gestion de la date
                    dynamic dateField = competition['date'];
                    DateTime date;
                    if (dateField is Timestamp) {
                      date = dateField.toDate();
                    } else if (dateField is String) {
                      date = DateTime.parse(dateField);
                    } else {
                      date = DateTime.now();
                    }
                    final formattedDate = DateFormat('dd/MM/yyyy').format(date);

                    // Sous-titre de la carte
                    final subTitle = isUserInscribed
                        ? '$formattedDate - Je suis inscrit à cette compétition'
                        : formattedDate;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.7,
                          child: CustomCard(
                            title: competition['title'] as String? ?? 'Compétition',
                            subTitle: subTitle,
                            onTap: () {
                              context.go('/competition/${competition.id}', extra: competition.id);
                            },
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
      },
    );
  }
}
