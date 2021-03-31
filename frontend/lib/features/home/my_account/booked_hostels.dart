import 'dart:convert';

import 'package:database_provider/database_provider.dart';

class BookedHostels {
  final Hostel hostel;
  final String from;
  final String to;
  BookedHostels({
    required this.hostel,
    required this.from,
    required this.to,
  });
  BookedHostels copyWith({
    Hostel? hostel,
    String? from,
    String? to,
  }) {
    return BookedHostels(
      hostel: hostel ?? this.hostel,
      from: from ?? this.from,
      to: to ?? this.to,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'hostel': hostel.toMap(),
      'from': from,
      'to': to,
    };
  }

  factory BookedHostels.fromMap(Map<String, dynamic> map) {
    return BookedHostels(
      hostel: Hostel.fromMap(map['hostel']),
      from: map['from'],
      to: map['to'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BookedHostels.fromJson(String source) =>
      BookedHostels.fromMap(json.decode(source));

  @override
  String toString() => 'BookedHostels(hostel: $hostel, from: $from, to: $to)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BookedHostels &&
        other.hostel == hostel &&
        other.from == from &&
        other.to == to;
  }

  @override
  int get hashCode => hostel.hashCode ^ from.hashCode ^ to.hashCode;
}
