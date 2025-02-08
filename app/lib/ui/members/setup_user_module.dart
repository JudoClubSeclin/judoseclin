
import 'package:judoseclin/ui/members/login/user_bloc.dart';
import 'package:judoseclin/ui/members/reset_password/reset_password_bloc.dart';

import '../../core/di/injection.dart';


void setupUserModule() {
getIt.registerFactory(() => UserBloc(getIt()));
getIt.registerFactory(() => ResetPasswordBloc(getIt()));
}

