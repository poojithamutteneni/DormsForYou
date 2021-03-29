import 'dart:convert';

class College {
  final String name;
  final String address;
  final int id;

  College({
    required this.name,
    required this.address,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'id': id,
    };
  }

  factory College.fromMap(Map<String, dynamic> map) {
    return College(
      name: map['name'],
      address: map['address'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory College.fromJson(String source) =>
      College.fromMap(json.decode(source));

  @override
  String toString() => 'College(name: $name, address: $address, id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is College &&
        other.name == name &&
        other.address == address &&
        other.id == id;
  }

  @override
  int get hashCode => name.hashCode ^ address.hashCode ^ id.hashCode;
}
