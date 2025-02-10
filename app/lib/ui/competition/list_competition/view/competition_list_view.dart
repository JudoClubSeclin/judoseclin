import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:judoseclin/theme.dart';
import 'package:judoseclin/ui/common/widgets/images/image_fond_ecran.dart';
import 'package:judoseclin/ui/common/widgets/appbar/custom_appbar.dart';

import '../../../../core/utils/competition-provider.dart'; // Import de la classe

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
          stream: FirebaseFirestore.instance.collection('competition').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Text('Erreur : ${snapshot.error}');
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Text('Aucune compétition trouvée.');
            }

            final competitions = snapshot.data!.docs;

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
                    bool isUserInscribed = userInscriptions.contains(competition.id);

                    dynamic dateField = competition['date'];
                    DateTime date;

                    if (dateField is Timestamp) {
                      date = dateField.toDate();
                    } else if (dateField is String) {
                      date = DateTime.parse(dateField);
                    } else {
                      throw Exception('Type de date inattendu : ${dateField.runtimeType}');
                    }

                    String formattedDate = DateFormat('dd/MM/yyyy').format(date);

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
                                  Text(
                                    competition['title'] as String,
                                    style: textStyleText(context),
                                  ),
                                  const SizedBox(width: 15),
                                  Text(
                                      formattedDate,
                                      style: textStyleText(context)
                                  ),
                                  const SizedBox(width: 50),
                                  Text(
                                    isUserInscribed
                                        ? 'Je suis inscrit à cette compétition'
                                        : 'Je ne suis pas inscrit à cette compétition',
                                    style: TextStyle(
                                      color: isUserInscribed ? Colors.green : Colors.redAccent,
                                    ),
                                  )
                                ],
                              ),
                              onTap: () {
                                String competitionId = competition.id;
                                if (competitionId.isNotEmpty) {
                                  context.go('/competition/$competitionId');
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Compétition introuvable')),
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
      },
    );
  }
}
