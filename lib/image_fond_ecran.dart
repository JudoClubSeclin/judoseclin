import 'package:flutter/material.dart';
import 'package:judoseclin/size_extensions.dart';

class ImageFondEcran extends StatelessWidget {
  const ImageFondEcran({super.key});

  static const String imagePath = 'assets/images/bg-main-1.jpg';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      height: size.headerHeight(),
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageFondEcran.imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
