import 'package:flutter/material.dart';

class LandingHome extends StatelessWidget {
  const LandingHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg-appbar-0.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.5,
          child: FractionallySizedBox(
            alignment: Alignment.center,
            widthFactor: 1.0, // Set widthFactor to 1.0 to use the full width of the parent container
            heightFactor: 1.0, // Set heightFactor to 1.0 to use the full height of the parent container
            child: Stack(
              alignment: Alignment.center,
              children: [
                Transform.translate(
                  offset:const  Offset(0, 0), // Adjust the X and Y values for horizontal and vertical translation
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001) // Add a small value for the depth (Z-axis translation)
                      ..rotateY(0.0),
                    // Add Y-axis rotation for a 3D-like effect
                    child: Image.asset(
                      "assets/images/logo-fond-blanc.png",
                      height: 150, // Adjust the size of the image as needed
                      width: 150,
                    ),
                  ),
                ),
                 const SizedBox(height: 25,),
               const Positioned(
                  bottom: 16,
                  child: Text(
                    "Judo Club Seclin",
                    style: TextStyle(
                      fontSize: 80,
                      fontFamily: 'Hiromisake',
                      color: Colors.black,
                     shadows:  [
                      Shadow(
                         offset: Offset(1.0, 1.0),
                     blurRadius: 3.0,
                     color: Colors.white
                      )
                    
                     ]
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
