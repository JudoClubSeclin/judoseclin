import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../theme/theme.dart';
import '../../widgets/appbar/custom_appbar.dart';
import '../../widgets/images/image_fond_ecran.dart';
import '../bloc/account_bloc.dart';
import '../bloc/account_event.dart';
import '../bloc/account_state.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AccountBloc>().add(LoadUserInfo());
    return Scaffold(
      appBar: CustomAppBar(
        title: '',
        actions: [
          GestureDetector(
            onTap: () {
              GoRouter.of(context).go('/competitions');
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                  child:
                      Text('Compétitions', style: TextStyle(fontSize: 16.0))),
            ),
          ),
        ],
      ),
      body: BlocConsumer<AccountBloc, AccountState>(
        listener: (context, state) {
          if (state is AccountError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is AccountLoading) {
            return const Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is AccountLoaded) {
            final userData = state.userData;
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
                    Text(
                      "Bienvenue sur votre espace",
                      style: titleStyleMedium(context),
                      textAlign: TextAlign.center,
                    ),
                    ListTile(
                      title: const Text('Email',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(userData['email'] ?? 'Not available'),
                    ),
                    ListTile(
                      title: const Text('Nom',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(userData['nom'] ?? 'Not available'),
                    ),
                    ListTile(
                      title: const Text('Prénom',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(userData['prenom'] ?? 'Not available'),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('Une erreur est survenue.'));
          }
        },
      ),
    );
  }
}