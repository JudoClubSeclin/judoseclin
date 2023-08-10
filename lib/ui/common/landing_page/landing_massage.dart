import 'package:flutter/material.dart';

class LandingMessage extends StatelessWidget {
  const LandingMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 1/3,
      width: MediaQuery.of(context).size.width * 1.0,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "assets/images/bg-news-0.jpg",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
       children: [
        Container(padding: const EdgeInsets.all(15)),
        const Text(
          'Inscription 2023',
          style: TextStyle(
              fontSize: 20,
              fontFamily: 'Hiromisake',
              fontWeight: FontWeight.w500,
              color: Colors.white),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: const Text(
            'Les inscription pour la saison 2023/2024 serron ouverte au public le jour ou on en auras envis PROUUUTTTTTT',
            style: TextStyle(
                fontFamily: 'Hiromisake',
                fontSize: 17,
                color: Colors.white,
                fontWeight: FontWeight.w100),
          ),
        ),
      ]),
    );
  }
}
