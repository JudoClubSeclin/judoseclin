import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/account_bloc.dart';
import '../bloc/account_event.dart';
import '../bloc/account_state.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountBloc, AccountState>(
      listener: (context, state) {
        if (state is AccountError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is AccountInitial) {
          // Dispatch an event to load the user info when the view is built
          context.read<AccountBloc>().add(LoadUserInfo());
          return const CircularProgressIndicator();
        } else if (state is AccountLoading) {
          return const CircularProgressIndicator();
        } else if (state is AccountLoaded) {
          return ListView(
            children: [
              ListTile(
                title: const Text('Email',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(state.userData['email'] ?? 'Not available'),
              ),
              ListTile(
                title: const Text('Nom',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(state.userData['nom'] ?? 'Not available'),
              ),
              // ... Add other fields as necessary
            ],
          );
        } else {
          return const Center(child: Text('Une erreur est survenue.'));
        }
      },
    );
  }
}
