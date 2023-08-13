import 'package:flutter/material.dart';

class ColonneClub extends StatelessWidget {
  const ColonneClub({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      width: MediaQuery.of(context).size.width * 1 / 2.7,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.white,
      ),
      child:
          const Column(mainAxisAlignment: MainAxisAlignment.start,
           children: [
        Text(
          'LE CLUB',
          style: TextStyle(
              fontFamily: 'Hiromisake',
              fontSize: 35,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: EdgeInsets.all(9.0),
          child: Text(
              "Le judo club de seclin ,qui à vue le jour en 1973, il faisait partie de l'USS 'union sportive seclinoise créer par le Docteur PRAST.Cette union regroupé plusieurs diciplines. Aujourd'hui cette association n'existe plus et chaque diciplines et devenue une association sportive (club). lejudo clubde seclin est affilié a la Fédération Française d judo(FFJDA). Nous pratiquons le Judo, Ju-jitsu, Taïso et le self-défense au dojo seclinois au font du parc des époux Rosenberg rue Marx Dormoy 5113 Seclin  "),
        ),
      ]),
    );
  }
}
