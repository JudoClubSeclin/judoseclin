import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:judoseclin/ui/common/landing_page_account/landing_account.dart';

class AccountPage extends StatelessWidget {
  Future<void> simulateImageLoading() async {
    // Simulate image loading process
    await Future.delayed(const Duration(seconds: 1));
  }

  const AccountPage({super.key});

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
              return const Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      LandingAccount(),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
