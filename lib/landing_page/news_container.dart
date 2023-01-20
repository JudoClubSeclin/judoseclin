import 'package:flutter/material.dart';
import 'package:judoseclin/size_extensions.dart';

class NewsContainer extends StatelessWidget {
  const NewsContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
