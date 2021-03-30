import 'dart:convert';

class Hostel {
  final String name;
  final String adminName;
  final String address;
  final String contact;
  final String roomUrls;
  final String description;
  final int roomPrice;
  final double latitude;
  final double longitude;
  final int roomMateCount;
  final int availableRoomCount;

  Hostel({
    required this.name,
    required this.adminName,
    required this.address,
    required this.contact,
    required this.roomUrls,
    required this.description,
    required this.roomPrice,
    required this.latitude,
    required this.longitude,
    required this.roomMateCount,
    required this.availableRoomCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'adminName': adminName,
      'address': address,
      'contact': contact,
      'roomUrls': roomUrls,
      'description': description,
      'roomPrice': roomPrice,
      'latitude': latitude,
      'longitude': longitude,
      'roomMateCount': roomMateCount,
      'availableRoomCount': availableRoomCount,
    };
  }

  factory Hostel.fromMap(Map<String, dynamic> map) {
    return Hostel(
      name: map['name'],
      adminName: map['adminname'],
      address: map['caddress'],
      contact: map['contact'],
      roomUrls: map['roomurls'],
      description: map['description'],
      roomPrice: map['roomprice'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      roomMateCount: map['roommatecount'],
      availableRoomCount: map['availableroomcount'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Hostel.fromJson(String source) => Hostel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Hostel(name: $name, adminName: $adminName, address: $address, contact: $contact, roomUrls: $roomUrls, description: $description, roomPrice: $roomPrice, latitude: $latitude, longitude: $longitude, roomMateCount: $roomMateCount, availableRoomCount: $availableRoomCount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Hostel &&
        other.name == name &&
        other.adminName == adminName &&
        other.address == address &&
        other.contact == contact &&
        other.roomUrls == roomUrls &&
        other.description == description &&
        other.roomPrice == roomPrice &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.roomMateCount == roomMateCount &&
        other.availableRoomCount == availableRoomCount;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        adminName.hashCode ^
        address.hashCode ^
        contact.hashCode ^
        roomUrls.hashCode ^
        description.hashCode ^
        roomPrice.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        roomMateCount.hashCode ^
        availableRoomCount.hashCode;
  }

  Hostel copyWith({
    String? name,
    String? adminName,
    String? address,
    String? contact,
    String? roomUrls,
    String? description,
    int? roomPrice,
    double? latitude,
    double? longitude,
    int? roomMateCount,
    int? availableRoomCount,
  }) {
    return Hostel(
      name: name ?? this.name,
      adminName: adminName ?? this.adminName,
      address: address ?? this.address,
      contact: contact ?? this.contact,
      roomUrls: roomUrls ?? this.roomUrls,
      description: description ?? this.description,
      roomPrice: roomPrice ?? this.roomPrice,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      roomMateCount: roomMateCount ?? this.roomMateCount,
      availableRoomCount: availableRoomCount ?? this.availableRoomCount,
    );
  }
}
