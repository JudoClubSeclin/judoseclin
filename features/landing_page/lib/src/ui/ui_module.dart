import 'package:flutter/material.dart';
import 'package:news/news.dart';


class WithImageOnly extends StatelessWidget {
  static Image? _appbarImage;

  static Future<void> precacheImages(BuildContext context) async {
    if (_appbarImage == null) {
      _appbarImage = Image.asset(
        "packages/landing_page/assets/images/bg-appbar-1.png",
      );
      await precacheImage(_appbarImage!.image, context);
    }
  }

  const WithImageOnly({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              height: 600,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: _appbarImage?.image ??
                      const AssetImage(
                        "assets/images/bg-appbar-1.png",
                        package: "landing_page",
                      ),
                  fit: BoxFit.cover,
                ),
              ),
            ),



            // Carousel de la feature news
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: NewsCarousel(),
            ),

          ],
        ),
      ),
    );
  }
}
