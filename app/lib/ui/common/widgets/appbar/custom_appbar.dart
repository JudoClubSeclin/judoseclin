import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:judoseclin/core/utils/function_admin.dart';
import 'package:provider/provider.dart';
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
            icon: Icon(Icons.menu, color: theme.colorScheme.onPrimary),
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
      Consumer<FunctionAdminService>(
        builder: (context, authService, child) {
          final bool hasAccess =
              authService.isAdmin && MediaQuery.sizeOf(context).width > 749;

          debugPrint('hasAccess: $hasAccess');

          if (hasAccess) {
            return Row(
              children: [
                GestureDetector(
                  onTap: () => GoRouter.of(context).go('/admin/add/adherents'),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'ajout-Adhérents',
                      style: textStyleTextAppBar(context),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => GoRouter.of(context).go('/admin/list/adherents'),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Liste-Adhérents',
                      style: textStyleTextAppBar(context),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap:
                      () => GoRouter.of(context).go('/admin/add/competition'),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Ajout-compétition',
                      style: textStyleTextAppBar(context),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => GoRouter.of(context).go('/admin/add/news'),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Ajout-news',
                      style: textStyleTextAppBar(context),
                    ),
                  ),
                )
              ],
            );
          }

          return const SizedBox.shrink(); // Retourne un widget vide si pas d'accès
        },
      ),
      ...navItems.map((item) {
        return GestureDetector(
          onTap: () => GoRouter.of(context).go(item['route']!),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Text(item['label']!, style: textStyleTextAppBar(context)),
            ),
          ),
        );
      })
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 749;

    return AppBar(
      backgroundColor: theme.colorScheme.primary,
      title: Text(title, textAlign: TextAlign.center),
      leading: getLeading(context),
      actions: [
        if (actions != null)
          ...actions!.map(
                (action) => Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: action,
            ),
          ),
        if (onNavigate != null)
          IconButton(
            icon: Icon(Icons.new_releases, color: theme.colorScheme.surface),
            onPressed: onNavigate!,
          ),
        if (isWideScreen) ...generateNavActions(context),
        IconButton(
          icon: Icon(Icons.logout, color: theme.colorScheme.onPrimary),
            onPressed: () async {
              final router = GoRouter.of(context); // capture avant await
              try {
                await FirebaseAuth.instance.signOut();
                router.go('/');
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Erreur lors de la déconnexion')),
                );
              }
            }


        )

      ],
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  List<Widget> generateDrawerItems(BuildContext context) {
    final List<Map<String, String>> drawerItems = [
      {'label': 'mon compte', 'route': '/account'},
      {'label': 'Compétitions', 'route': '/competition'},
    ];

    return [
      Consumer<FunctionAdminService>(
        builder: (context, authService, child) {
          final bool hasAccess =
              authService.isAdmin; // pas besoin de tester la largeur ici

          debugPrint('hasAccess: $hasAccess');

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (hasAccess) ...[
                GestureDetector(
                  onTap: () => GoRouter.of(context).go('/admin/add/adherents'),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Ajout-Adhérents',
                      style: textStyleText(context),
                    ),
                  ),
                ),
                const SizedBox(height: 15,),
                GestureDetector(
                  onTap: () => GoRouter.of(context).go('/admin/list/adherents'),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Liste-Adhérents',
                      style: textStyleText(context),
                    ),
                  ),
                ),
                const SizedBox(height: 15,),
                GestureDetector(
                  onTap: () => GoRouter.of(context).go('/admin/add/competition'),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Ajout-compétition',
                      style: textStyleText(context),
                    ),
                  ),
                ),
                const SizedBox(height: 15,),
                GestureDetector(
                  onTap: () => GoRouter.of(context).go('/admin/add/news'),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Ajout-news',
                      style: textStyleText(context),
                    ),
                  ),
                ),
                const Divider(),
              ],
              ...drawerItems.map((item) {
                return ListTile(
                  title: Text(item['label']!, style: textStyleText(context)),
                  onTap: () {
                    GoRouter.of(context).go(item['route']!);
                    Navigator.pop(context);
                  },
                );
              })
            ],
          );
        },
      ),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: theme.colorScheme.primary,
      elevation: 0,
      child:Align(
        alignment: Alignment.topCenter,
      child:ListView(
        padding: const EdgeInsets.fromLTRB(10, 25, 0, 0),
        children: generateDrawerItems(context),
      ),
      ),
    );
  }
}