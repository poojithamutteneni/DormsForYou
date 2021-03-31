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
    emit(state.copyWith(isSignUp: !state.isSignUp));
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

  Future sign() async {
    emit(state.copyWith(isLoading: true));
    try {
      AuthUser? user;
      if (state.isSignUp) {
        if (state.password == state.cpassword) {
          user = await _authenticationReposiory.signUp(
              state.email, state.password);
        } else {
          emit(state.copyWith(showErrors: true));
        }
      } else {
        user =
            await _authenticationReposiory.signIn(state.email, state.password);
      }
      getIt.get<AuthenticationCubit>().setUser(user ?? AuthUser.empty());
      emit(state.copyWith(
          isLoading: false, result: LoginResult.Success, showErrors: true));
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
