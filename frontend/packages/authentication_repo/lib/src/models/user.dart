import 'dart:convert';

///Authenticated User model, returned by auth
class AuthUser {
  final String name;
  final String email;
  final int id;
  final bool isAuthenticated;

  const AuthUser({
    required this.name,
    required this.email,
    required this.id,
    required this.isAuthenticated,
  });

  factory AuthUser.empty() =>
      const AuthUser(name: "", id: 0, email: "", isAuthenticated: false);

  AuthUser copyWith({
    String? name,
    String? email,
    int? id,
    bool? isAuthenticated,
  }) {
    return AuthUser(
      name: name ?? this.name,
      email: email ?? this.email,
      id: id ?? this.id,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'id': id,
      'isAuthenticated': isAuthenticated,
    };
  }

  factory AuthUser.fromMap(Map<String, dynamic> map) {
    return AuthUser(
      name: map['full_name'],
      email: map['email'],
      id: map['id'],
      isAuthenticated: map['isAuthenticated'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthUser.fromJson(String source) =>
      AuthUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AuthUser(name: $name, email: $email, id: $id, isAuthenticated: $isAuthenticated)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthUser &&
        other.name == name &&
        other.email == email &&
        other.id == id &&
        other.isAuthenticated == isAuthenticated;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        id.hashCode ^
        isAuthenticated.hashCode;
  }
}
