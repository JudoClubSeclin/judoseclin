import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../main.dart';
import '../../functions/function_admin.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
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
  CustomAppBarState createState() => CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}

class CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 750) {
          return AppBar(
            backgroundColor: Colors.red[400],
            title: Text(
              widget.title,
              textAlign: TextAlign.center,
            ),
            leading: context.canPop()
                ? IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () => context.pop(),
                  )
                : null,
            actions: <Widget>[
              if (widget.actions != null)
                ...widget.actions!.map((action) => Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: action,
                    )),
              if (widget.onNavigate != null)
                IconButton(
                  icon: const Icon(
                    Icons.new_releases,
                    color: Colors.white,
                  ),
                  onPressed: widget.onNavigate!,
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
                  final bool hasAccess = snapshot.data ?? false;
                  debugPrint(
                      'hasAccess: $hasAccess'); // Ajoutez cette ligne pour le débogage
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
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.white),
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
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.white),
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
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.white),
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
                              debugPrint(
                                  'Erreur lors de la déconnexion: $error');
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
        } else {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.red[400],
              title: Text(
                widget.title,
                textAlign: TextAlign.center,
              ),
            ),
            drawer: Drawer(
              backgroundColor: Colors.red[400],
              elevation: 20.0,
              child: ListView(
                padding: EdgeInsets.zero,
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
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () => GoRouter.of(context)
                                  .go('/admin/list/adherents'),
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
                                debugPrint(
                                    'Navigating to /admin/add/adherents');
                                GoRouter.of(context).go('/admin/add/adherents');
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
      },
    );
  }
}
