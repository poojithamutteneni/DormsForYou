part of 'login_cubit.dart';

enum LoginResult { Success, Failure, Unknown }

class LoginState extends Equatable {
  final bool showErrors;
  final String email;
  final String password;
  final bool isLoading;
  final String cpassword;
  final String error;
  final bool isSignUp;
  final LoginResult result;
  const LoginState({
    required this.showErrors,
    required this.email,
    required this.password,
    required this.isLoading,
    required this.cpassword,
    required this.error,
    required this.isSignUp,
    required this.result,
  });

  factory LoginState.init() => const LoginState(
      showErrors: false,
      email: "",
      isSignUp: false,
      error: "",
      result: LoginResult.Unknown,
      password: "",
      isLoading: false,
      cpassword: "");

  @override
  List<Object> get props =>
      [showErrors, isSignUp, result, cpassword, email, password, isLoading];

  LoginState copyWith({
    bool? showErrors,
    String? email,
    String? password,
    bool? isLoading,
    String? cpassword,
    String? error,
    bool? isSignUp,
    LoginResult? result,
  }) {
    return LoginState(
      showErrors: showErrors ?? this.showErrors,
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      cpassword: cpassword ?? this.cpassword,
      error: error ?? this.error,
      isSignUp: isSignUp ?? this.isSignUp,
      result: result ?? this.result,
    );
  }
}
