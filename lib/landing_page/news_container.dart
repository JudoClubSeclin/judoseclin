import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:judoseclin/size_extensions.dart';

class NewsContainer extends HookWidget {
  const NewsContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counter = useState(0);

    counter.value = 9;
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
