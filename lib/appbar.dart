import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const CustomAppBar({Key? key, required this.title, this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.red[400],
      title: Text(title),
      actions: <Widget>[
        if (actions != null)
          ...actions!.map((action) => Padding(
                padding: const EdgeInsets.only(
                    right: 8.0), // Ici, on ajoute une marge à droite
                child: action,
              )),
        IconButton(
          icon: const Icon(Icons.logout), // Icône de déconnexion
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            // Vous pouvez aussi naviguer vers la page de connexion après la déconnexion
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
