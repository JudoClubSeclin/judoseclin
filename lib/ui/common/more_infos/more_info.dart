import 'package:flutter/material.dart';
import 'package:judoseclin/ui/common/more_infos/colone_links.dart';
import 'package:judoseclin/ui/common/more_infos/colonne_club.dart';
import 'package:judoseclin/ui/common/more_infos/colonne_cours.dart';

class MoreInfo extends StatelessWidget {
  const MoreInfo({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        width: size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg-main-0.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: 15,),
            FileListButtons(), ColonneClub(), ColonneCours()],
        ));
  }
}
