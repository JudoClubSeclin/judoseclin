import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:judoseclin/more_info.dart';
import 'package:judoseclin/ui/common/connexion_to_firebase/connexion_button.dart';
import 'package:judoseclin/ui/common/landing_page/landing_home.dart';
import 'package:judoseclin/ui/common/landing_page/landing_news.dart';
import 'package:judoseclin/ui/common/landing_page/show_button.dart';

class Landing extends StatelessWidget {
  Future<void> simulateImageLoading() async {
    // Simulate image loading process
    await Future.delayed(const Duration(seconds: 1));
  }

  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController();
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: FutureBuilder(
          future: simulateImageLoading(),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: size.height / 4,
                color: Colors.white, // Background color
                child: Center(
                  child: SpinKitFadingCircle(
                    size: 50,
                    itemBuilder: (BuildContext context, int index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          color: index.isEven ? Colors.red : Colors.black,
                        ),
                      );
                    },
                  ),
                ),
              );
            } else {
              return Stack(
                children: [
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      LandingHome(),
                      LandingNews(),
                      MoreInfo(),
                    ],
                  ),
                  const Positioned(
                    top: 40.0, // Ajustez la position verticale
                    right: 10.0, // Ajustez la position horizontale
                    child: ConnexionButton(),
                  ),
                  ShowButton(scrollController: controller),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
