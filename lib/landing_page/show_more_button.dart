import 'package:flutter/material.dart';
import 'package:judoseclin/size_extensions.dart';

class ShowMoreButton extends StatelessWidget {
  final ScrollController scrollController;

  const ShowMoreButton({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
        top: size.headerHeight() - 25,
        left: size.width * .6 - 25,
      ),
      child: ElevatedButton(
        onPressed: () {
          scrollController.animateTo(
            size.height,
            duration: const Duration(seconds: 1),
            curve: Curves.easeOut,
          );
        },
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: const BorderSide(color: Colors.red)))),
        child: SizedBox(
          width: 150,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/images/arrow_down.png",
                height: 25,
                width: 25,
              ),
              const Text(
                "EN SAVOIR PLUS...",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
