import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/widgets/appbar/custom_appbar.dart';
import '../account_bloc.dart';
import '../account_event.dart';
import '../account_state.dart';
import 'account_view.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AccountBloc>().add(LoadUserInfo());

    return Scaffold(
      appBar: CustomAppBar(title: ''),
      drawer: MediaQuery.of(context).size.width <= 750 ? CustomDrawer() : null,
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
