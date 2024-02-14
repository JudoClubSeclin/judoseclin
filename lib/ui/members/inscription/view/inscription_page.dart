import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../interactor/users_interactor.dart';
import '../bloc/inscription_bloc.dart';
import 'inscription_view.dart';

class InscriptionPage extends StatelessWidget {
  final UsersInteractor usersInteractor;
  const InscriptionPage({super.key, required this.usersInteractor});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InscriptionBloc(
        usersInteractor,
        userId: '',
      ),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: InscriptionView(),
        ),
      ),
    );
  }
}
