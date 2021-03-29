import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/user.dart';

abstract class IAuthenticationReposiory {
  Future<AuthUser> signUp(String email, String password);
  Future<AuthUser> signIn(String email, String password);
  Future<AuthUser> logout();
}

class AuthFailed implements Exception {
  final String msg;
  AuthFailed({
    required this.msg,
  });
}

class AuthenticationRepository implements IAuthenticationReposiory {
  static const String url = "something.com";
  @override
  Future<AuthUser> logout() async {
    http.Response res = await http.get(Uri.parse("$url"));
    if (res.statusCode == 200) {
      print(res.body);
      return AuthUser.empty();
    } else {
      throw AuthFailed(msg: "Failed to get colleges from server!");
    }
  }

  @override
  Future<AuthUser> signIn(String username, String password) async {
    http.Response res = await http.post(Uri.parse("$url"),
        headers: <String, String>{'username': username, 'password': password});
    if (res.statusCode == 200) {
      print(res.body);
      return AuthUser.fromJson(json.decode(res.body));
    } else {
      throw AuthFailed(msg: "Failed to get colleges from server!");
    }
  }

  @override
  Future<AuthUser> signUp(String email, String password) async {
    http.Response res = await http.post(Uri.parse("$url"),
        headers: <String, String>{'password': password, "email": email});
    if (res.statusCode == 200) {
      print(res.body);
      return AuthUser.fromJson(json.decode(res.body));
    } else {
      throw AuthFailed(msg: "Failed to get colleges from server!");
    }
  }
}
