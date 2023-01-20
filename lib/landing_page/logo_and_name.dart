import 'package:flutter/material.dart';

class LogoAndName extends StatelessWidget {
  const LogoAndName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double? titleFont = size.width / 10;
    return Container(
      height: size.height * .7,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg-appbar.jpeg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .02),
            child: SizedBox(
              width: size.width / 9,
              height: size.width / 9,
              child: Image.asset("assets/images/logo.png"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: size.width * .02),
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
