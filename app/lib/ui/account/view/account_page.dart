import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:judoseclin/theme.dart';

import '../account_bloc.dart';
import '../account_event.dart';
import '../account_state.dart';
import 'account_view.dart';

class AccountPage extends StatelessWidget {
  final String? adherentId;

  const AccountPage({Key? key, this.adherentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AccountBloc>().add(LoadUserInfo(adherentId: adherentId));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: theme.colorScheme.onPrimary),
            onPressed: () => GoRouter.of(context).go('/'),
          ),
        ],
      ),
      body: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is AccountLoaded) {
            return AccountView(userData: state.userData);
          } else {
            if (state is! AccountLoading) {
              context.read<AccountBloc>().add(LoadUserInfo(adherentId: adherentId));
            }
            return const Center(
              child: SizedBox(width: 50, height: 50, child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
