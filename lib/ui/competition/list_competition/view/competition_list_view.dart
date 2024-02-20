import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:judoseclin/ui/common/widgets/images/image_fond_ecran.dart';

import '../../../common/widgets/appbar/custom_appbar.dart';
import '../../inscription_competition/bloc/inscription_competition_bloc.dart';

class CompetitionsListView extends StatelessWidget {
  const CompetitionsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    List<String> userInscriptions = [];

    loadUserInscriptions() async {
      List<String> inscriptions = await context
          .read<InscriptionCompetitionBloc>()
          .getInscriptionForUser(userId);
      userInscriptions = inscriptions;
    }

    loadUserInscriptions();

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('competition').snapshots(),
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
          return const Text('Aucune compétition trouvée.');
        }

        final competitions = snapshot.data!.docs;

        return Scaffold(
          appBar: const CustomAppBar(
            title: '',
          ),
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
                bool isUserInscribed =
                    userInscriptions.contains(competition.id);

                dynamic dateField = competition['date'];
                DateTime date;

                if (dateField is Timestamp) {
                  // Si c'est un Timestamp, convertissez-le en DateTime
                  date = dateField.toDate();
                } else if (dateField is String) {
                  // Si c'est une String, vous devrez peut-être la convertir en DateTime selon le format
                  // Assurez-vous que le format est correct avant de faire la conversion.
                  date = DateTime.parse(dateField);
                } else {
                  // Gérez d'autres types si nécessaire
                  throw Exception(
                      'Type de date inattendu : ${dateField.runtimeType}');
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
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                formattedDate,
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              Text(
                                isUserInscribed
                                    ? 'je suis inscrit à cette compétition'
                                    : 'je ne suis pas inscrit à cette compétition',
                                style: TextStyle(
                                  color: isUserInscribed
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              )
                            ],
                          ),
                          onTap: () {
                            String competitionId = competition.id.toString();
                            if (competitionId.isNotEmpty) {
                              context.go('/competitions/$competitionId');
                            } else {
                              // L'ID est vide, donc vous pouvez afficher un message d'erreur ou effectuer une autre action si nécessaire.
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Compétition introuvable')),
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
