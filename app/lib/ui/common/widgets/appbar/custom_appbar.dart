import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:judoseclin/core/utils/function_admin.dart';

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
              icon: Icon(Icons.arrow_back, color: theme.colorScheme.onPrimary),
              onPressed: () => context.pop(),
            )
          : Container();
    }
  }

  List<Widget> generateNavActions(BuildContext context) {
    final List<Map<String, String>> navItems = [
      {'label': 'mon compte', 'route': '/account'},
      {'label': 'Compétitions', 'route': '/competition'},
    ];
    return [
      FutureBuilder<bool>(
        future: hasAccess(),
        builder: (context, snapshot) {
          final bool hasAccess =
              snapshot.data == true && MediaQuery.sizeOf(context).width > 749;

          debugPrint('hasAccess: $hasAccess');

          if (hasAccess) {
            return Row(
              children: [
                GestureDetector(
                  onTap: () => GoRouter.of(context).go('/admin/add/adherents'),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Add Adhérents',
                      style: textStyleTextAppBar(context),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => GoRouter.of(context).go('/admin/list/adherents'),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Liste Adhérents',
                      style: textStyleTextAppBar(context),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => GoRouter.of(context).go('/admin/add/competition'),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Ajouté une compétition',
                      style: textStyleTextAppBar(context),
                    ),
                  ),
                ),
              ],
            );
          }

          return const SizedBox
              .shrink(); // Retourne un widget vide si pas d'accès
        },
      ),
      ...navItems.map((item) {
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
      }).toList(),
    ];
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
            icon: Icon(Icons.new_releases, color: theme.colorScheme.surface),
            onPressed: onNavigate!,
          ),
        if (isWideScreen) ...generateNavActions(context),
        IconButton(
          icon: Icon(Icons.logout, color: theme.colorScheme.onPrimary),
          onPressed: () {
            GoRouter.of(context).go('/'); // Redirection après déconnexion
          },
        ),
      ],
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  List<Widget> generateDrawerItems(BuildContext context) {
    final List<Map<String, String>> drawerItems = [
      {'label': 'mon compte', 'route': '/account'},
      {'label': 'Compétitions', 'route': '/competition'}
    ];

    return drawerItems.map((item) {
      return ListTile(
        title: Text(
          item['label']!,
          style: textStyleTextAppBar(context),
        ),
        onTap: () {
          GoRouter.of(context).go(item['route']!);
          Navigator.pop(context);
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
