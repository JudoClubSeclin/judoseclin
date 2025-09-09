import 'package:flutter/material.dart';

class WithImageOnly extends StatelessWidget {
  static Image? _appbarImage;

  static Future<void> precacheImages(BuildContext context) async {
    if (_appbarImage == null) {
      _appbarImage = Image.asset(
        "packages/landing_page/assets/images/bg-appbar-0.jpg",
      );
      await precacheImage(_appbarImage!.image, context);
    }
  }

  const WithImageOnly({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: _appbarImage?.image ?? const AssetImage(''),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
