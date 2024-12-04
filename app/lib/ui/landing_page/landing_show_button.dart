import 'package:flutter/material.dart';
import 'package:judoseclin/size_extensions.dart';

class ShowButton extends StatelessWidget {
  final ScrollController scrollController;
  const ShowButton({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.only(
        top: size.headerHeight() - 25,
        left: size.width * .5 - 95,
      ),
      child: ElevatedButton(
        onPressed: () {
          scrollController.animateTo(size.height,
              duration: const Duration(seconds: 1), curve: Curves.easeOut);
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.red[400]),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: const BorderSide(color: Colors.red),
            ),
          ),
        ),
        child: SizedBox(
          height: 50,
          width: 160,
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
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
