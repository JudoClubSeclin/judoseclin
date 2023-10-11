import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:judoseclin/ui/common/competition_info/model/competition.dart';

import '../../Cubit/inscription-competition_cubit.dart';

class CompetitionDetailsScreen extends StatelessWidget {
  final Competition competition;

  const CompetitionDetailsScreen({Key? key, required this.competition})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return BlocConsumer<InscriptionCompetitionCubit,
        InscriptionCompetitionState>(
      listener: (context, state) {
        if (state is InscriptionCompetitionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Inscription réussie!')),
          );
        } else if (state is InscriptionCompetitionFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erreur: ${state.errorMessage}')),
          );
        }
      },
      builder: (context, state) {
        Size size = MediaQuery.of(context).size;
        double titlefont = size.width / 22;
        double textfont = size.width / 30;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red[400],
            title: Text(' ${competition.title}'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
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
                  ' ${competition.date}',
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
                Text(
                  ' ${competition.poussin}',
                  style: TextStyle(fontSize: textfont),
                ),
                const SizedBox(
                  height: 22,
                ),
                Text(
                  ' ${competition.benjamin}',
                  style: TextStyle(fontSize: textfont),
                ),
                const SizedBox(
                  height: 22,
                ),
                Text(
                  ' ${competition.minime}',
                  style: TextStyle(fontSize: textfont),
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<InscriptionCompetitionCubit>()
                        .registerForCompetition(userId, competition.id);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red[400]),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: const BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  child: const SizedBox(
                    height: 50,
                    width: 160,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("JE M'INSCRIS"),
                      ],
                    ),
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
