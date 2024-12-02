import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/function_admin.dart';
import '../../../../main.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final VoidCallback? onNavigate;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.onNavigate,
  });

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  Widget? getLeading(BuildContext context) {
    if (MediaQuery.sizeOf(context).width > 750) {
      return context.canPop()
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => context.pop(),
            )
          : null;
    } else {
      return IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.red[400],
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      leading: getLeading(context),
      actions: <Widget>[
        if (actions != null)
          ...actions!.map((action) => Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: action,
              )),
        if (onNavigate != null)
          IconButton(
            icon: const Icon(
              Icons.new_releases,
              color: Colors.white,
            ),
            onPressed: onNavigate!,
          ),
        GestureDetector(
          onTap: () {
            GoRouter.of(context).go('/competitions');
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Text(
                'Compétition',
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
          ),
        ),
        FutureBuilder<bool>(
          future: hasAccess(),
          builder: (context, snapshot) {
            final bool hasAccess = snapshot.data != false &&
                MediaQuery.sizeOf(context).width > 750;
            debugPrint('hasAccess: $hasAccess');
            if (hasAccess) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).go('/admin/list/adherents');
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Center(
                        child: Text(
                          'Liste des adhérents',
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).go('/admin/add/adherents');
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Center(
                        child: Text(
                          'Ajouter un adhérent',
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).go('/admin/add/competition');
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Center(
                        child: Text(
                          'Ajouter une compétition',
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        ),
                      ),
                    ),
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
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.red[400],
      elevation: 0,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
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
          ListTile(
            title: const Text('Compétitions'),
            onTap: () {
              GoRouter.of(context).go('/competitions');
              Navigator.pop(context);
            },
          ),
          FutureBuilder<bool>(
            future: hasAccess(),
            builder: (context, snapshot) {
              final bool hasAccess = snapshot.data ?? false;
              debugPrint('hasAccess: $hasAccess');
              if (hasAccess) {
                return Column(
                  children: [
                    ListTile(
                      title: const Text('Liste adhérents'),
                      onTap: () {
                        GoRouter.of(context).go('/admin/list/adherents');
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text('Ajouter un adhérent'),
                      onTap: () {
                        GoRouter.of(context).go('/admin/add/adherents');
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text('Ajouter une compétition'),
                      onTap: () {
                        GoRouter.of(context).go('/admin/add/competition');
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
