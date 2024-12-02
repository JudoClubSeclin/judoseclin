import 'package:flutter/material.dart';

import '../../../theme.dart';
import '../../common/widgets/images/image_fond_ecran.dart';

class AccountView extends StatelessWidget {
  final Map<String, dynamic> userData;

  const AccountView({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageFondEcran.imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Text(
              "Bienvenue sur votre espace",
              style: titleStyleMedium(context),
              textAlign: TextAlign.center,
            ),
            ListTile(
              title: const Text('Email: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(userData['email'] ?? 'Not available'),
            ),
            ListTile(
              title: const Text('Nom: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(userData['firstName'] ?? 'Not available'),
            ),
            ListTile(
              title: const Text('Prénom: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(userData['lastName'] ?? 'Not available'),
            ),
          ],
        ),
      ),
    );
  }
}
