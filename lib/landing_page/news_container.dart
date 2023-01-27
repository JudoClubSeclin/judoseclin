import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:judoseclin/size_extensions.dart';

class NewsContainer extends HookWidget {
  const NewsContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var db = FirebaseFirestore.instance;
    final mesNews = useState<List<News>>([]);

    db
        .collection("news")
        .orderBy("date_publication", descending: true)
        .limit(3)
        .get()
        .then((event) {
      mesNews.value = event.docs.map((e) => News.fromFirestore(e)).toList();
    });

    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.newsHeight(),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg-news.jpg"),
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
        ),
        items: mesNews.value.toMarkdown(),
      ),
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
      data: text,
      styleSheet: MarkdownStyleSheet(
        p: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
        h1: Theme.of(context).textTheme.displayLarge?.copyWith(
              color: Colors.white,
              fontFamily: "Hiromisake",
            ),
        h2: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: Colors.white,
              fontFamily: "Hiromisake",
            ),
        h3: Theme.of(context)
            .textTheme
            .displaySmall
            ?.copyWith(color: Colors.white),
      ),
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
    md += "## $titre\n\n";
    md += "_${publication.toString()}_\n\n";
    md += contenu;
    return md;
  }
}

extension MarkdownNewsList on List<News> {
  List<Widget> toMarkdown() =>
      map((e) => MarkdownedNews(text: e.toMarkdownText())).toList();
}
