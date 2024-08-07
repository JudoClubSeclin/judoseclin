import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/widgets/appbar/custom_appbar.dart';
import '../bloc/account_bloc.dart';
import '../bloc/account_event.dart';
import '../bloc/account_state.dart';
import 'account_view.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    context.read<AccountBloc>().add(LoadUserInfo());

    return Scaffold(
      appBar: const CustomAppBar(title: ''),
      drawer: MediaQuery.of(context).size.width <= 750
          ? const CustomDrawer()
          : null,
      body: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is AccountLoaded) {
            return AccountView(userData: state.userData);
          } else {
            if (state is! AccountLoading) {
              context.read<AccountBloc>().add(LoadUserInfo());
            }
            return const Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
