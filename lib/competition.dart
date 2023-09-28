import 'package:flutter/material.dart';
import 'package:judoseclin/size_extensions.dart';
import 'package:judoseclin/ui/common/competition_info/view/screen/competitions_list_screen.dart';
import 'package:judoseclin/ui/common/more_infos/orientation_stack.dart';

class Competition extends StatelessWidget {
  const Competition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    SizeOrientation orientation = size.orientation();
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: OrientedStack(orientation: orientation, children: [
          Expanded(
            child: CompetitionsListScreen(),
          ),
        ]),
      ),
    );
  }
}
