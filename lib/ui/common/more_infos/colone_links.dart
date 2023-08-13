import 'package:flutter/material.dart';

class FileListButtons extends StatelessWidget {
  const FileListButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      width: MediaQuery.of(context).size.width * 1 / 4.2,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'DOCUMENTS',
            style: TextStyle(
              fontFamily: 'Hiromisake',
              fontSize: 35,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: Colors.red, // Correction ici
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'LIVRET DE GRADES',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 17),
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.black)),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'LIVRET DE GRADE JU-JITSU',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 17),
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.black)),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'REGLEMENT INTERIEUR',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 17),
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.black)),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'TARIFS BABY JUDO',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 17),
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.black)),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'TARIFS JUDOKAS',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 17),
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.black)),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'TARFIE TASIO & SELF DEFENSE',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 17),
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.black)),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'TEXTE OFFICIEL 2023/2024',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 17),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
     


    );   
  }
}
