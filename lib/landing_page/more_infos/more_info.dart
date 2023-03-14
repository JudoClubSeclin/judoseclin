import 'package:flutter/material.dart';
import 'package:judoseclin/landing_page/more_infos/colonne_links.dart';
import './oriented_stack.dart';
import './colonne_page.dart';
import 'package:judoseclin/size_extensions.dart';

class MoreInfo extends StatelessWidget {
  const MoreInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SizeOrientation orientation = size.orientation();
    return Container(
      width: size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg-main-0.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: OrientedStack(
        orientation: orientation,
        children: [
          ColonneLinks(fraction: .2, size: size),
          ColonnePage(docUrl: "assets/markdown/le-club.md", fraction: .4, size: size),
          ColonnePage(docUrl: "assets/markdown/les-cours.md", fraction: .4, size: size),

        ],
      ),
    );
  }
}

