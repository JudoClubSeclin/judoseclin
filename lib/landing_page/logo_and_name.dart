import 'package:flutter/material.dart';
import 'package:judoseclin/size_extensions.dart';

class LogoAndName extends StatelessWidget {
  const LogoAndName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double? titleFont = size.width / 10;
    return Container(
      height: size.headerHeight(),
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg-appbar.jpeg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * .02),
            child: SizedBox(
              width: size.max() / 9,
              height: size.max() / 9,
              child: Image.asset("assets/images/logo-fond-blanc.png"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.height * .02),
            child: Text(
              "Judo Club Seclin",
              style: TextStyle(
                fontFamily: 'Hiromisake',
                fontSize: titleFont,
                color: Colors.black,
                shadows: const [
                  Shadow(
                      offset: Offset(1.0, 1.0),
                      blurRadius: 3.0,
                      color: Colors.white)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
