import 'package:authentication_repository/authentication_repo.dart';
import 'package:database_provider/database_provider.dart';
import 'package:dorms_for_you/features/authentication/auth_screen/cubit/login_cubit.dart';
import 'package:dorms_for_you/features/authentication/cubit/authentication_cubit.dart';
import 'package:dorms_for_you/features/dorms/bloc/dorm_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<IAuthenticationReposiory>(AuthenticationRepository());
  getIt.registerSingleton<AuthenticationCubit>(AuthenticationCubit(getIt()));
  getIt.registerSingleton<DormBloc>(DormBloc(DatabaseProvider()));

  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));
}
