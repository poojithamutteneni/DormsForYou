import 'package:authentication_repository/authentication_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(this._authenticationReposiory)
      : super(AuthenticationState.empty());

  final IAuthenticationReposiory _authenticationReposiory;

  void setUser(AuthUser user) {
    emit(state.copyWith(user: user));
  }

  Future<void> authenticate() async {
    emit(state.copyWith(isLoading: true));
    try {
      final AuthUser user = await _authenticationReposiory.authenticate();
      emit(state.copyWith(user: user, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future logout() async {
    emit(state.copyWith(isLoading: true));
    try {
      final AuthUser user = await _authenticationReposiory.logout();
      emit(state.copyWith(user: user, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
