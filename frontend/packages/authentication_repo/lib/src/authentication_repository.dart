import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'models/user.dart';

abstract class IAuthenticationReposiory {
  Future<AuthUser> signUp(
      String email, String password, String name, String dob);
  Future<AuthUser> signIn(String email, String password);
  Future<AuthUser> logout();
  Future<AuthUser> authenticate();
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
    storage.delete(key: "jwt");
    return AuthUser.empty();
  }

  @override
  Future<AuthUser> signIn(String email, String password) async {
    http.Response res = await http.post(Uri.parse("$url/login"),
        headers: <String, String>{'email': email, 'password': password});
    print("signin");
    if (res.statusCode == 200) {
      print(res.body);
      final l = json.decode(res.body);
      print(l['userdetails']);
      storage.write(key: "email", value: email);
      storage.write(key: "name", value: l['userdetails']['full_name']);
      storage.write(key: "id", value: l['userdetails']["userid"]);

      storage.write(key: key, value: l["token"]);
      return AuthUser.fromMap(l['userdetails']);
    } else {
      throw AuthFailed(msg: "Failed to get colleges from server!");
    }
  }

  @override
  Future<AuthUser> signUp(
      String email, String password, String name, String dob) async {
    print("objectw");
    http.Response res = await http.post(Uri.parse("$url/signup"),
        headers: <String, String>{
          'password': password,
          "email": email,
          "full_name": name,
          "dob": dob
        });
    print(res);
    if (res.statusCode == 200) {
      print(res.body);
      final l = json.decode(res.body);
      storage.write(key: "email", value: email);
      storage.write(key: "name", value: name);
      //storage.write(key: "id", value: l['userdetails']["userid"]);
      storage.write(key: key, value: l["token"]);
      return AuthUser.fromMap(l['userdetails']);
    } else {
      throw AuthFailed(msg: "Failed to get colleges from server!");
    }
  }

  @override
  Future<AuthUser> authenticate() async {
    String value = await storage.read(key: key) ?? "";

    http.Response res = await http.post(Uri.parse("$url/authenticate"),
        headers: {"authorization": "bearer " + value});

    if (res.statusCode == 200) {
      String? mail = await storage.read(key: "email");
      String? name = await storage.read(key: "name");
      return AuthUser(
          email: mail ?? "", isAuthenticated: true, name: name ?? "");
    }
    return AuthUser.empty();
  }
}
