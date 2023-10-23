import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:judoseclin/ui/common/competition_info/model/competition.dart';

import '../../Cubit/competition_cubit.dart';

class CompetitionsListScreen extends StatefulWidget {
  const CompetitionsListScreen({super.key});

  @override
  _CompetitionsListScreenState createState() => _CompetitionsListScreenState();
}

class _CompetitionsListScreenState extends State<CompetitionsListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CompetitionCubit>().getCompetitions();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<CompetitionCubit>().getCompetitions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[400],
          title: const Text('Liste des competitions'),
        ),
        body: BlocBuilder<CompetitionCubit, List<Competition>>(
            builder: (context, competitions) {
          if (competitions.isEmpty) {
            return const CircularProgressIndicator();
          }

          return ListView.builder(
            itemCount: competitions.length,
            itemBuilder: (context, index) {
              final competition = competitions[index];
              String formattedDate =
                  DateFormat('dd/MM/yyyy').format(competition.date);
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.center, // Pour centrer le contenu
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    // Ici, j'ai pris 70% de la largeur de l'écran
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(color: Colors.red[400]!, width: 2.0),
                      ),
                      child: ListTile(
                        title: Text(competition.title),
                        subtitle: Text(formattedDate),
                        onTap: () {
                          String competitionId = competition.id.toString();
                          context.go('/details/$competitionId');
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }));
  }
}
