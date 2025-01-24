import 'package:flutter/material.dart';
import 'package:judoseclin/core/utils/size_extensions.dart';
import 'package:judoseclin/theme.dart';

class LandingHome extends StatelessWidget {
  const LandingHome({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double? titlefont = size.width / 10;
    return Container(
      height: size.headerHeight(),
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg-appbar-0.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: size.height * 0.1,
            ),
            child: SizedBox(
              width: size.height / 6,
              height: size.height / 6,
              child: Image.asset("assets/images/logo-fond-blanc.png"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.0,
            ),
            child: Text(
              "JUDO CLUB SECLIN",
              style: titleStyleLarge(context)
            ),
          )
        ],
      ),
    );
  }
}
