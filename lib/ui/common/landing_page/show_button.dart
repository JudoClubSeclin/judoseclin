import 'package:flutter/material.dart';

class ShowButton extends StatelessWidget {
 
  const ShowButton({ Key? key, }) : super(key: key);
   
  @override
  Widget build(BuildContext context) {
    return 
    ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
            const Text("EN SAVOIR PLUS..."),
          ],
        ),
      ),
    );
  }
}
