import 'package:flutter/material.dart';
import 'package:judoseclin/size_extensions.dart';
import 'package:judoseclin/ui/common/competition_info/competition_info.dart';
import 'package:judoseclin/ui/common/more_infos/colone_links.dart';
import 'package:judoseclin/ui/common/more_infos/colonne_page.dart';
import 'package:judoseclin/ui/common/more_infos/orientation_stack.dart';


class MoreInfo extends StatelessWidget {
  const MoreInfo({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
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
        children: const [
            CompetitionInfo(),
        ],
      ),
    );
  }
}