import 'package:flutter/material.dart';
import 'header.dart';
import 'package:news/news.dart';

class LandingPage extends StatelessWidget{
  const LandingPage({ super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController();
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                 Header(),
                NewsCarousel()
              ],
            )
          ],
        ),

      ),
    );
  }
}