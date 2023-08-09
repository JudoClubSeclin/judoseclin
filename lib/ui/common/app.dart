import 'package:flutter/material.dart';
import 'package:judoseclin/ui/common/landing_page/landing_home.dart';
import 'package:judoseclin/ui/common/landing_page/landing_massage.dart';


import 'theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Judo Club Seclinois',
      theme: theme,
      home: const Scaffold(
        body: SingleChildScrollView(
          
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                 LandingHome(),  
                 LandingMessage(),
                ],
              ),  
            ],
          ),
        ),
      ),
    );
  }
}
