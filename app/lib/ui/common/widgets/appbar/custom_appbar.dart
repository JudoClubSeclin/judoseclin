import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../theme.dart';

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

  Widget getLeading(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 749;

    if (!isWideScreen) {
      return Builder(
        builder: (BuildContext context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(
              Icons.menu,
              color: theme.colorScheme.onPrimary,
            ),
          );
        },
      );
    } else {
      return context.canPop()
          ? IconButton(
        icon:  Icon(Icons.arrow_back, color:theme.colorScheme.secondary),
        onPressed: () => context.pop(),
      )
          : Container(); // Retourne un widget vide si on ne peut pas revenir en arrière
    }
  }

  List<Widget> generateNavActions(BuildContext context) {
    final List<Map<String, String>> navItems = [
      {'label': 'Accueil', 'route': '/'},

    ];

    return navItems.map((item) {
      return GestureDetector(
        onTap: () => GoRouter.of(context).go(item['route']!),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: Text(
              item['label']!,
              style: textStyleTextAppBar(context),
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 749;

    return AppBar(
      backgroundColor: theme.colorScheme.primary,
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      leading: getLeading(context),
      actions: [
        if (actions != null)
          ...actions!.map((action) => Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: action,
          )),
        if (onNavigate != null)
          IconButton(
            icon:  Icon(Icons.new_releases, color: theme.colorScheme.surface),
            onPressed: onNavigate!,
          ),
        if (isWideScreen) ...generateNavActions(context),
      ],
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  // Méthode pour générer les éléments du drawer
  List<Widget> generateDrawerItems(BuildContext context) {
    final List<Map<String, String>> drawerItems = [
      {'label': 'Accueil', 'route': '/'},


    ];

    return drawerItems.map((item) {
      return ListTile(
        title: Text(item['label']!, style: textStyleTextAppBar(context),),
        onTap: () {
          GoRouter.of(context).go(item['route']!);
          Navigator.pop(context); // Fermer le drawer après la navigation
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: theme.colorScheme.onSurface,
      elevation: 0,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(10, 25, 0, 0),
        children: generateDrawerItems(context),
      ),
    );
  }
}