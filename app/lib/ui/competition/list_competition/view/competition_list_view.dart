import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:judoseclin/theme.dart';
import 'package:judoseclin/ui/common/widgets/appbar/custom_appbar.dart';
import 'package:judoseclin/ui/common/widgets/images/image_fond_ecran.dart';

import '../../../../core/utils/competition_provider.dart'; // Import de la classe
import 'package:judoseclin/ui/common/widgets/Custom_card/custom_card.dart';


class CompetitionsListView extends StatefulWidget {
  const CompetitionsListView({super.key});

  @override
  CompetitionsListViewState createState() => CompetitionsListViewState();
}

class CompetitionsListViewState extends State<CompetitionsListView> {
  late Future<List<String>> _userInscriptionsFuture;

  @override
  void initState() {
    super.initState();
    _userInscriptionsFuture = UserCompetitionsProvider().getUserInscriptions();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: _userInscriptionsFuture,
      builder: (context, inscriptionsSnapshot) {
        if (inscriptionsSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final userInscriptions = inscriptionsSnapshot.data ?? [];

        return StreamBuilder<QuerySnapshot>(
          stream:
          FirebaseFirestore.instance.collection('competition').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Text('Erreur : ${snapshot.error}');
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Scaffold(
                appBar: CustomAppBar(title: '',),
                drawer: MediaQuery.sizeOf(context).width > 750 ? null : CustomDrawer(),
                body:
                Center(
                child: Text(
                  'Aucune compétition trouvée.',
                  style: titleStyleSmall(context).copyWith(
                    decoration: TextDecoration.none,
                  ),
                ),
                )
              );
            }

            final competitions = snapshot.data!.docs;

            return Scaffold(
              appBar: CustomAppBar(title: '',),
              drawer: MediaQuery.sizeOf(context).width > 750 ? null : CustomDrawer(),
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
                    bool isUserInscribed = userInscriptions.contains(
                      competition.id,
                    );

                    dynamic dateField = competition['date'];
                    DateTime date;

                    if (dateField is Timestamp) {
                      date = dateField.toDate();
                    } else if (dateField is String) {
                      date = DateTime.parse(dateField);
                    } else {
                      throw Exception(
                        'Type de date inattendu : ${dateField.runtimeType}',
                      );
                    }

                    String formattedDate = DateFormat(
                      'dd/MM/yyyy',
                    ).format(date);

                    // Construire le sous-titre en 3 morceaux pour CustomCard
                    final subTitle = '$formattedDate - ${isUserInscribed
                            ? 'Je suis inscrit à cette compétition'
                            : 'Je ne suis pas inscrit à cette compétition'}';

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: CustomCard(
                            title: competition['title'] as String,
                            subTitle: subTitle,
                            onTap: () {
                              String competitionId = competition.id;
                              if (competitionId.isNotEmpty) {
                                context.go('/competition/$competitionId',
                                extra: competitionId);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Compétition introuvable'),
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
            );
          },
        );
      },
    );
  }
}
