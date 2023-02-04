import 'package:flutter/material.dart';
import 'package:judoseclin/components/oriented_sized_box.dart';
import 'package:judoseclin/components/oriented_stack.dart';
import 'package:judoseclin/landing_page/colonne_page.dart';
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
          image: AssetImage("assets/images/bg-main.jpeg"),
          fit: BoxFit.cover,
        ),
      ),
      child: OrientedStack(
        orientation: orientation,
        children: [
          OrientedSizedBox(
            size: size,
            fraction: .2,
            child: const Card(child: Text("1")),
          ),
          ColonnePage(docUrl: "assets/markdown/le-club.md", fraction: .4, size: size),
          ColonnePage(docUrl: "assets/markdown/les-cours.md", fraction: .4, size: size),
        ],
      ),
    );
  }
}

