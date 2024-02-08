import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../main.dart';
import '../../functions/function_admin.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final VoidCallback? onNavigate; // Ajoutez cette ligne

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.onNavigate, // Ajoutez cette ligne
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.red[400],
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      leading: context.canPop()
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => context.pop())
          : null,
      actions: <Widget>[
        if (actions != null)
          ...actions!.map((action) => Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: action,
              )),
        if (onNavigate != null) // Ajoutez cette condition
          IconButton(
            icon: const Icon(
              Icons.new_releases,
              color: Colors.white,
            ),
            onPressed: onNavigate,
          ),
        IconButton(
          icon: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
          onPressed: () {
            auth.signOut().then((_) {
              debugPrint('Déconnexion réussie');
              context.go('/');
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

class CustomDrawer extends StatelessWidget implements PreferredSizeWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
      ),
      drawer: Drawer(
        backgroundColor: Colors.red[400],
        child: ListView(
          children: [
            GestureDetector(
              onTap: () {
                GoRouter.of(context).go('/competitions');
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: Text(
                    'Compétitions',
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                ),
              ),
            ),
            FutureBuilder<bool>(
              future: hasAccess(),
              builder: (context, snapshot) {
                final bool hasAccess = snapshot.data ?? false;
                debugPrint(
                    'hasAccess: $hasAccess'); // Ajoutez cette ligne pour le débogage
                if (hasAccess) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => context.go('/admin/list/adherents'),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Center(
                            child: Text(
                              'Liste adhérents',
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          debugPrint('Navigating to /admin/add/adherents');
                          context.go('/admin/add/adherents');
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Center(
                            child: Text(
                              'ajouter un adhérent',
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.go('/admin/add/competition'),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Center(
                            child: Text(
                              'ajouter une compétition',
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
