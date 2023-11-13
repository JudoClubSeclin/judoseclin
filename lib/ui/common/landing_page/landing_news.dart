import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:judoseclin/size_extensions.dart';

import '../theme/theme.dart';

class LandingNews extends HookWidget {
  const LandingNews({Key? key}) : super(key: key);

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
        mesNews.value = event.docs.map((e) => News.fromFirestore(e)).toList();
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

class MarkdownedNews extends StatelessWidget {
  final String text;

  const MarkdownedNews({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Markdown(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      data: text,
      styleSheet: getMDTheme(context, Colors.white),
    );
  }
}

class News {
  final String titre;
  final String contenu;
  final DateTime publication;

  const News(
      {required this.titre, required this.contenu, required this.publication});

  factory News.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();

    return News(
        titre: data?['titre'],
        contenu: data?['contenu'],
        publication: data?['date_publication'].toDate());
  }

  String toMarkdownText() {
    String md = "";
    md += "# $titre\n\n";
    md += "_${publication.toString()}_\n\n";
    md += contenu;
    return md;
  }
}

extension MarkdownNewsList on List<News> {
  List<Widget> toMarkdown() =>
      map((e) => MarkdownedNews(text: e.toMarkdownText())).toList();
}
