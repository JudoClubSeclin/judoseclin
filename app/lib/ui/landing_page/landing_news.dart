import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:judoseclin/core/utils/size_extensions.dart';
import 'package:judoseclin/ui/landing_page/markdowned_news_list.dart';

import '../../domain/entities/news.dart';

class LandingNews extends HookWidget {
  const LandingNews({super.key});

  @override
  Widget build(BuildContext context) {
    final mesNews = useState<List<News>>([]);

    useEffect(() {
      var db = FirebaseFirestore.instance;
      db
          .collection("news")
          .orderBy("date_publication", descending: true)
          .limit(3)
          .get()
          .then((event) {
            mesNews.value =
                event.docs.map((e) => News.fromFirestore(e)).toList();
          });

      return () {
        // Clean up any resources or subscriptions here, if needed.
      };
    }, const []);

    Size size = MediaQuery.of(context).size;

    return ValueListenableBuilder<List<News>>(
      valueListenable: mesNews,
      builder: (context, newsList, child) {
        return Container(
          width: size.width,
          height: size.newsHeight(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg-news-0.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: CarouselSlider(
            options: CarouselOptions(
              height: size.newsHeight(),
              aspectRatio: size.width / size.newsHeight(),
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 15),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              viewportFraction: 1,
            ),
            items: newsList.toMarkdown(),
          ),
        );
      },
    );
  }
}
