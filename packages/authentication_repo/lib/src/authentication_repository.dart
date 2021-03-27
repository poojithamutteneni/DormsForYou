import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/user.dart';

abstract class IAuthenticationReposiory {
  Future<AuthUser> signUp(
      String username, String password, String phoneNumber, String email);
  Future<AuthUser> signIn(String username, String password);
  Future<void> logout();
}

class AuthFailed implements Exception {
  final String msg;
  AuthFailed({
    this.msg,
  });
}

class AuthenticationRepository implements IAuthenticationReposiory {
  static const String url = "something.com";
  @override
  Future<void> logout() async {
    http.Response res = await http.get(Uri.parse("$url"));
    if (res.statusCode == 200) {
      print(res.body);
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
  Future<AuthUser> signUp(String username, String password, String phoneNumber,
      String email) async {
    http.Response res =
        await http.post(Uri.parse("$url"), headers: <String, String>{
      'username': username,
      'password': password,
      "number": phoneNumber,
      "email": email
    });
    if (res.statusCode == 200) {
      print(res.body);
      return AuthUser.fromJson(json.decode(res.body));
    } else {
      throw AuthFailed(msg: "Failed to get colleges from server!");
    }
  }
}
