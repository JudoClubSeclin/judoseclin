import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:judoseclin/ui/common/competition_info/model/competition.dart';

import '../../Cubit/competition_cubit.dart';
import 'competition_details_screen.dart';

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
        title: const Text('Competitions List'),
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
              return Card(
                child: ListTile(
                  title: Text(competition.title),
                  subtitle: Text(competition.date),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CompetitionDetailsScreen(competition: competition),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
