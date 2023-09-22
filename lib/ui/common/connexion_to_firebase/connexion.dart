import 'package:flutter/material.dart';
import 'package:judoseclin/size_extensions.dart';
import 'package:judoseclin/ui/common/connexion_to_firebase/login.dart';
import 'package:judoseclin/ui/common/more_infos/orientation_stack.dart';

class Connexion extends StatelessWidget {
  const Connexion({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    SizeOrientation orientation = size.orientation();
    return SingleChildScrollView(
      child: SizedBox(
        width: size.width,
        child: OrientedStack(
          orientation: orientation,
          children: const [Login()],
        ),
      ),
    );
  }
}
