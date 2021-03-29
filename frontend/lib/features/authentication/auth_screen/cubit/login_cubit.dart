import 'package:authentication_repository/authentication_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:dorms_for_you/di.dart';
import 'package:dorms_for_you/features/authentication/cubit/authentication_cubit.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationReposiory) : super(LoginState.init());
  final IAuthenticationReposiory _authenticationReposiory;

  void isSignUp() {
    emit(state.copyWith(isSignUp: true));
  }

  String checkConfirmPassword(String val) {
    if (state.password == val) {
      return "";
    } else {
      return "Passwords do not match";
    }
  }

  void emailChanged(String mail) {
    emit(state.copyWith(email: mail));
  }

  void passwordChanged(String mail) {
    emit(state.copyWith(password: mail));
  }

  void confirmPasswordChanged(String mail) {
    emit(state.copyWith(password: mail));
  }

  void resetResult() {
    emit(state.copyWith(error: "", result: LoginResult.Unknown));
  }

  Future signUp(String password, String email) async {
    emit(state.copyWith(isLoading: true));
    try {
      final AuthUser user =
          await _authenticationReposiory.signUp(email, password);
      getIt.get<AuthenticationCubit>().setUser(user);
      emit(state.copyWith(isLoading: false, result: LoginResult.Success));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, error: e.toString(), result: LoginResult.Failure));
    }
  }

  Future signIn(String username, String password) async {
    emit(state.copyWith(isLoading: true));
    try {
      final AuthUser user =
          await _authenticationReposiory.signIn(username, password);
      getIt.get<AuthenticationCubit>().setUser(user);

      emit(state.copyWith(isLoading: false, result: LoginResult.Success));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, error: e.toString(), result: LoginResult.Failure));
    }
  }
}
