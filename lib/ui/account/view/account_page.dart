import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/widgets/appbar/custom_appbar.dart';
import '../bloc/account_bloc.dart';
import '../bloc/account_state.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).size.width > 750
          ? const CustomAppBar(title: '')
          : AppBar(title: const Text('')), // Use a placeholder title
      drawer: MediaQuery.of(context).size.width <= 750 ? const CustomDrawer() : null,
      body: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is AccountLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AccountLoaded) {
            return Column(
              children: [
                Text(state.userData['nom']),
                Text(state.userData['prenom']),
                Text(state.userData['email']),
                // ... autres données utilisateur
              ],
            );
          } else {
            return const Center(
                child: Text("Erreur lors du chargement des données"));
          }
        },
      ),
    );
  }
}
