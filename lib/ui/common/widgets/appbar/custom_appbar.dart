import 'package:flutter/material.dart';

import '../../../../main.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final VoidCallback? onNavigate; // Ajoutez cette ligne

  const CustomAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.onNavigate, // Ajoutez cette ligne
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.red[400],
      title: Text(title),
      actions: <Widget>[
        if (actions != null)
          ...actions!.map((action) => Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: action,
              )),
        if (onNavigate != null) // Ajoutez cette condition
          IconButton(
            icon: const Icon(Icons.new_releases),
            onPressed: onNavigate,
          ),
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            auth.signOut().then((_) {
              debugPrint('Déconnexion réussie');
            }).catchError((error) {
              debugPrint('Erreur lors de la déconnexion: $error');
            });
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
