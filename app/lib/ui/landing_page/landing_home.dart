import 'package:flutter/material.dart';
import 'package:judoseclin/core/utils/size_extensions.dart';
import 'package:judoseclin/theme.dart';

class LandingHome extends StatefulWidget {
  const LandingHome({super.key});

  @override
  State<LandingHome> createState() => _LandingHomeState();
}

class _LandingHomeState extends State<LandingHome> {
  late Image appbarImage;
  late Image logoImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    appbarImage = Image.asset("assets/images/bg-appbar-0.jpg");
    logoImage = Image.asset("assets/images/logo-fond-blanc.png");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(appbarImage.image, context);
    precacheImage(logoImage.image, context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      height: size.headerHeight(),
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: appbarImage.image,
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.1),
            child: SizedBox(
              width: size.height / 6.5,
              height: size.height / 6.5,
              child: logoImage,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.0),
            child: Text("JUDO CLUB SECLIN", style: titleStyleLarge(context)),
          ),
        ],
      ),
    );
  }
}
