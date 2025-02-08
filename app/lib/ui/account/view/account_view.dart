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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Bonjour',style: titleStyleMedium(context),),
                const SizedBox(width: 15,),
                Text(userData['lastName'] ?? 'Not available',style: titleStyleMedium(context),),
              ],
            ),


            ListTile(
              title:  Text('Email: ',
                  style: textStyleText(context)),
              subtitle: Text(userData['email'] ?? 'Not available',style: textStyleText(context)),
            ),
            ListTile(
              title:  Text('Nom: ',
                  style: textStyleText(context)),
              subtitle: Text(userData['firstName'] ?? 'Not available',style: textStyleText(context)),
            ),
            ListTile(
              title:  Text('Prénom: ',
                  style: textStyleText(context)),
              subtitle: Text(userData['lastName'] ?? 'Not available',style: textStyleText(context)),
            ),
          ],
        ),
      ),
    );
  }
}
