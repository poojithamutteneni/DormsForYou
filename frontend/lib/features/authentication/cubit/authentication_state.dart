part of 'authentication_cubit.dart';

class AuthenticationState extends Equatable {
  final bool isLoading;
  final AuthUser user;
  final String error;

  const AuthenticationState({
    required this.isLoading,
    required this.user,
    required this.error,
  });

  factory AuthenticationState.empty() =>
      AuthenticationState(isLoading: false, user: AuthUser.empty(), error: "");

  @override
  List<Object> get props => [isLoading, user, error];

  AuthenticationState copyWith({
    bool? isLoading,
    AuthUser? user,
    String? error,
  }) {
    return AuthenticationState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }
}
