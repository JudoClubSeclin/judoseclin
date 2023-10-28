import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:judoseclin/ui/common/competition_info/model/competition.dart';

import '../../../widgets/appbar/custom_appbar.dart';
import '../../../widgets/images/image_fond_ecran.dart';
import '../../Cubit/competition_cubit.dart';
import '../../Cubit/inscription-competition_cubit.dart';

class CompetitionsListScreen extends StatefulWidget {
  const CompetitionsListScreen({super.key});

  @override
  _CompetitionsListScreenState createState() => _CompetitionsListScreenState();
}

class _CompetitionsListScreenState extends State<CompetitionsListScreen> {
  List<String> userInscriptions = [];
  String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
  @override
  void initState() {
    super.initState();
    context.read<CompetitionCubit>().getCompetitions();
    _loadUserInscriptions();
  }

  _loadUserInscriptions() async {
    List<String> inscriptions = await context
        .read<InscriptionCompetitionCubit>()
        .getInscriptionsForUser(userId);
    setState(() {
      userInscriptions = inscriptions;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<CompetitionCubit>().getCompetitions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: '',
          actions: [
            GestureDetector(
              onTap: () {
                GoRouter.of(context).go('/competitions');
              },
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
            child: BlocBuilder<CompetitionCubit, List<Competition>>(
                builder: (context, competitions) {
              if (competitions.isEmpty) {
                return Container(
                  width: 70,
                  height: 70,
                  child: const CircularProgressIndicator(),
                );
              }

              return ListView.builder(
                itemCount: competitions.length,
                itemBuilder: (context, index) {
                  final competition = competitions[index];
                  bool isUserInscribed =
                      userInscriptions.contains(competition.id);

                  String formattedDate =
                      DateFormat('dd/MM/yyyy').format(competition.date);
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Align(
                      alignment: Alignment.center, // Pour centrer le contenu
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Card(
                          color: Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side:
                                BorderSide(color: Colors.red[400]!, width: 2.0),
                          ),
                          child: ListTile(
                            title: Wrap(
                              children: [
                                Text(
                                  competition.title,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  formattedDate,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
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
                                ),
                              ],
                            ),
                            onTap: () {
                              String competitionId = competition.id.toString();
                              context.go('/competitions/$competitionId');
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            })));
  }
}
