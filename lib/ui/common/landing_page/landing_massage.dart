import 'package:flutter/material.dart';

class LandingMessage extends StatelessWidget {
  const LandingMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg-news-0.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: const Text('Inscription',
      style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Hiromisake',
                      color: Colors.white,
      ),
      ),
    ) ;
  }
}