import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../add_competition_bloc.dart';
import '../add_competition_state.dart';
import 'form_widget.dart';

class AddCompetitionView extends StatelessWidget {
  const AddCompetitionView({
    super.key,
    required publishDate,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCompetitionBloc, AddCompetitionState>(
      builder: (context, state) {
        if (state is AddCompetitionSignUpLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AddCompetitionSignUpErrorState) {
          return Text(state.error);
        } else if (state is AddCompetitionSignUpSuccessState) {
          return FormWidget(
            context,
            addCompetitionId: state.addCompetitionId,
          );
        } else {
          return FormWidget(
            context,
            addCompetitionId: '',
          );
        }
      },
    );
  }
}
