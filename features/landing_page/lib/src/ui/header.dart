import 'package:flutter/material.dart';
import 'package:judoseclin/core/utils/size_extensions.dart';
import 'package:judoseclin/theme.dart';



class Header extends StatelessWidget {
  static Image? _appbarImage;
  static Image? _logo;

  /// Méthode unique pour précacher toutes les images
  static Future<void> precacheAll(BuildContext context) async {
    if (_appbarImage == null) {
      _appbarImage = Image.asset(
        "packages/landing_page/assets/images/bg-appbar-1.png",
      );
      await precacheImage(_appbarImage!.image, context);
    }

    if (_logo == null) {
      _logo = Image.asset(
        "packages/landing_page/assets/images/logo-fond-blanc.png",
      );
      await precacheImage(_logo!.image, context);
    }
  }

  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      height: size.headerHeight(),
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: _appbarImage?.image ??
              const AssetImage("packages/landing_page/assets/images/bg-appbar-1.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: size.height *0.1),
            child: SizedBox(
              width: size.height /6.5,
              height: size.height / 6.5,
              child:
                Image(image: _logo?.image ??
                const AssetImage("packages/landing_page/assets/images/logo-fond-blanc.png")),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.height *0.0),
            child: Text("JUDO CLUB SECLIN", style: titleStyleLarge(context),),
          ),
        ],
      ),
    );
  }
}
