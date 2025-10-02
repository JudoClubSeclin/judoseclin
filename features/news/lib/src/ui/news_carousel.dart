import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class NewsCarousel extends StatelessWidget {
  final List<String> infos = [
    "La rentrée sportive démarre le 2 septembre",
    "Tournoi régional prévu le 20 novembre",
    "Nouveau cours de Taïso tous les jeudis midi",
  ];

  NewsCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // prend toute la largeur
      height: 200,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "assets/images/img_carousel.png",
            package: "news",
          ),
          fit: BoxFit.cover, // l'image couvre tout le container
        ),
      ),
      child: Container(
        color: Colors.black.withOpacity(0.4), // filtre pour lisibilité
        child: CarouselSlider(
          options: CarouselOptions(
            height: 450,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            enlargeCenterPage: false,
            viewportFraction: 1.0, // texte fait toute la largeur
            scrollPhysics: const BouncingScrollPhysics(),
          ),
          items: infos.map((info) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  info,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(1, 1),
                        blurRadius: 4,
                        color: Colors.black45,
                      )
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
