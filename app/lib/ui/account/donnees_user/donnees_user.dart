import 'package:flutter/material.dart';

import '../../../theme.dart';

class DonneesUser extends StatelessWidget {
  final Map<String, dynamic> userData;
  const DonneesUser({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return
      SizedBox(
        height: size.height * 0.5,
     child: ListView(children: [

      ListTile(
        title: Text('Email: ', style: textStyleText(context)),
        subtitle: Text(userData['email'] ?? 'Not available',
            style: textStyleText(context)),
      ),
      ListTile(
        title: Text('Nom: ', style: textStyleText(context)),
        subtitle: Text(userData['firstName'] ?? 'Not available',
            style: textStyleText(context)),
      ),
      ListTile(
        title: Text('Prénom: ', style: textStyleText(context)),
        subtitle: Text(userData['lastName'] ?? 'Not available',
            style: textStyleText(context)),
      ),
    ]
      )
    );
  }
}
