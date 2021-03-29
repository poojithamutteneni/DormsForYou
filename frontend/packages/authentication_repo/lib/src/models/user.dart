import 'dart:convert';

///Authenticated User model, returned by auth
class AuthUser {
  final String name;
  final String email;

  final bool isAuthenticated;
  const AuthUser({
    required this.name,
    required this.email,
    required this.isAuthenticated,
  });

  factory AuthUser.empty() =>
      const AuthUser(name: "", email: "", isAuthenticated: false);

  AuthUser copyWith({
    String? name,
    String? email,
    bool? isAuthenticated,
  }) {
    return AuthUser(
      name: name ?? this.name,
      email: email ?? this.email,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'isAuthenticated': isAuthenticated,
    };
  }

  factory AuthUser.fromMap(Map<String, dynamic> map) {
    return AuthUser(
      name: map['name'],
      email: map['email'],
      isAuthenticated: map['isAuthenticated'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthUser.fromJson(String source) =>
      AuthUser.fromMap(json.decode(source));

  @override
  String toString() =>
      'AuthUser(name: $name, email: $email, isAuthenticated: $isAuthenticated)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthUser &&
        other.name == name &&
        other.email == email &&
        other.isAuthenticated == isAuthenticated;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode ^ isAuthenticated.hashCode;
}
