import 'package:flutter/material.dart';
import 'package:judoseclin/ui/common/landing_page/landing_home.dart';
import 'package:judoseclin/ui/common/landing_page/landing_massage.dart';
import 'package:judoseclin/ui/common/landing_page/show_button.dart';

import 'theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Judo Club Seclinois',
      theme: theme,
      home:  Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  LandingHome(),
                  LandingMessage(),
                ],
              ),
            Positioned(
               left: MediaQuery.of(context).size.width * 1/2 - 80,
              top: MediaQuery.of(context).size.height * 2 / 3 -25, // Deux tiers de la hauteur de l'écran
            
                child: const  ShowButton(),
              ),
            
            ],
          ),
        ),
      ),
    );
  }
}
