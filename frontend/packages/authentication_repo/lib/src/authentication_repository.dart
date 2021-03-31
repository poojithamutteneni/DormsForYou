import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  static const String url = "http://192.168.1.106:6000/auth";
  static const storage = FlutterSecureStorage();
  static const String key = "jwt";
  @override
  Future<AuthUser> logout() async {
    http.Response res = await http.get(Uri.parse("$url/logout"));
    if (res.statusCode == 200) {
      storage.delete(key: "jwt");
      return AuthUser.empty();
    } else {
      throw AuthFailed(msg: "Failed to get response from server!");
    }
  }

  @override
  Future<AuthUser> signIn(String email, String password) async {
    http.Response res = await http.post(Uri.parse("$url/login"),
        headers: <String, String>{'email': email, 'password': password});
    if (res.statusCode == 200) {
      print(res.body);
      final l = json.decode(res.body);
      storage.write(key: key, value: l["token"]);
      return AuthUser.fromMap(l['user']);
    } else {
      throw AuthFailed(msg: "Failed to get colleges from server!");
    }
  }

  @override
  Future<AuthUser> signUp(String email, String password) async {
    http.Response res = await http.post(Uri.parse("$url/auth/signup"),
        headers: <String, String>{'password': password, "email": email});
    if (res.statusCode == 200) {
      print(res.body);
      final l = json.decode(res.body);
      storage.write(key: key, value: l["token"]);
      return AuthUser.fromMap(l['user']);
    } else {
      throw AuthFailed(msg: "Failed to get colleges from server!");
    }
  }
}
