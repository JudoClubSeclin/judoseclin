import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:judoseclin/ui/common/competition_info/model/competition.dart';
import 'package:judoseclin/ui/common/widgets/appbar/custom_appbar.dart';
import 'package:judoseclin/ui/common/widgets/buttons/custom_buttom.dart';

import '../../../widgets/images/image_fond_ecran.dart';
import '../../Cubit/competition_cubit.dart';
import '../../Cubit/inscription-competition_cubit.dart';

class CompetitionDetailsScreen extends StatelessWidget {
  final String id;
  final Competition? competition;

  const CompetitionDetailsScreen(
      {Key? key, required this.competition, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final competitionId = (ModalRoute.of(context)!.settings.arguments
        as Map)['competitionId'] as String;
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return FutureBuilder<Competition?>(
        future:
            context.read<CompetitionCubit>().getCompetitionById(competitionId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (snapshot.data == null) {
            return const Center(child: Text('Compétition non trouvée'));
          }

          final competition = snapshot.data!;
          String formattedDate =
              DateFormat('dd/MM/yyyy').format(competition.date);

          return BlocConsumer<InscriptionCompetitionCubit,
              InscriptionCompetitionState>(
            listener: (context, state) {
              if (state is InscriptionCompetitionProgress) {
                debugPrint("Inscription in progress");
              } else if (state is InscriptionCompetitionSuccess) {
                debugPrint('inscription reussi');
              } else if (state is InscriptionCompetitionFailure) {
                debugPrint('echec de l\'incription');
              } else if (state is InscriptionCompetitionClosed) {
                debugPrint("Inscription is closed");
              } else {
                debugPrint("Unhandled state: $state");
              }
              context.go('/competitions');
            },
            builder: (context, state) {
              Size size = MediaQuery.of(context).size;
              double titlefont = size.width / 22;
              double textfont = size.width / 30;

              return Scaffold(
                appBar: CustomAppBar(
                  title: competition.title,
                ),
                body: Stack(children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(ImageFondEcran.imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          ' ${competition.subtitle}',
                          style: TextStyle(
                              fontSize: titlefont, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        Text(
                          formattedDate,
                          style: TextStyle(
                              fontSize: titlefont, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        Text(
                          ' ${competition.address}',
                          style: TextStyle(fontSize: textfont),
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        ...buildTextWidgets(competition, textfont),
                        const SizedBox(
                          height: 40,
                        ),
                        CustomButton(
                          label: 'JE M\'INSCRIS',
                          onPressed: () {
                            context
                                .read<InscriptionCompetitionCubit>()
                                .registerForCompetition(userId, competition.id);
                          },
                        )
                      ],
                    ),
                  ),
                ]),
              );
            },
          );
        });
  }

  List<Widget> buildTextWidgets(Competition competition, double textfont) {
    List<Widget> widgets = [];

    if (competition.poussin?.isNotEmpty == true) {
      widgets.add(
        Text(
          'Poussin: ${competition.poussin}',
          style: TextStyle(fontSize: textfont),
        ),
      );
      widgets.add(const SizedBox(height: 22));
    }

    if (competition.benjamin?.isNotEmpty == true) {
      widgets.add(
        Text(
          'Benjamin: ${competition.benjamin}',
          style: TextStyle(fontSize: textfont),
        ),
      );
      widgets.add(const SizedBox(height: 22));
    }

    if (competition.minime?.isNotEmpty == true) {
      widgets.add(
        Text(
          'Minime: ${competition.minime}',
          style: TextStyle(fontSize: textfont),
        ),
      );
      widgets.add(const SizedBox(height: 22));
    }

    return widgets;
  }
}
