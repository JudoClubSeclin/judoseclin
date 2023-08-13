import 'package:flutter/material.dart';

class ColonneCours extends StatelessWidget {
  const ColonneCours({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      width:MediaQuery.of(context).size.width * 1/2.7,
     
     
     decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(8)),
       color: Colors.white,
     ),
     child: const Center(
      child: Text('LES COURS',
      style: TextStyle(
        fontFamily: 'Hiromisake',
        fontSize: 35,
        fontWeight: FontWeight.w500
      ),
      ),
        
      
     ),
     
     

    );
  }
}
