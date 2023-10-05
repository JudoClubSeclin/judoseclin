import 'package:flutter/material.dart';
import 'package:judoseclin/ui/common/competition_info/model/competition.dart';

class CompetitionDetailsScreen extends StatelessWidget {
  final Competition competition;

  const CompetitionDetailsScreen({super.key, required this.competition});

  @override
  Widget build(BuildContext context) {
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
              style:
                  TextStyle(fontSize: titlefont, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 22,
            ),
            Text(
              ' ${competition.date}',
              style:
                  TextStyle(fontSize: titlefont, fontWeight: FontWeight.w400),
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
              onPressed: () {},
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
  }
}
