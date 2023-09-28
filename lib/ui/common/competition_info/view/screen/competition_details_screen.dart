import 'package:flutter/material.dart';
import 'package:judoseclin/ui/common/competition_info/model/competition.dart';

class CompetitionDetailsScreen extends StatelessWidget {
  final Competition competition;

  const CompetitionDetailsScreen({super.key, required this.competition});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Subtitle: ${competition.subtitle}'),
            Text('Address: ${competition.address}'),
            Text('Poussin: ${competition.poussin}'),
            Text('Benjamin: ${competition.benjamin}'),
            Text('Minime: ${competition.minime}'),
          ],
        ),
      ),
    );
  }
}
