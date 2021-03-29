import 'dart:convert';

class Hostel {
  final String name;
  final String adminName;
  final String address;
  final String contact;
  final int collegeID;
  final String roomUrls;
  final String description;
  final int roomPrice;
  final int roomMateCount;
  final int availableRoomCount;

  Hostel({
    required this.name,
    required this.adminName,
    required this.address,
    required this.contact,
    required this.collegeID,
    required this.roomUrls,
    required this.description,
    required this.roomPrice,
    required this.roomMateCount,
    required this.availableRoomCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'adminName': adminName,
      'address': address,
      'contact': contact,
      'collegeID': collegeID,
      'roomUrls': roomUrls,
      'description': description,
      'roomPrice': roomPrice,
      'roomMateCount': roomMateCount,
      'availableRoomCount': availableRoomCount,
    };
  }

  factory Hostel.fromMap(Map<String, dynamic> map) {
    return Hostel(
      name: map['name'],
      adminName: map['adminName'],
      address: map['address'],
      contact: map['contact'],
      collegeID: map['collegeID'],
      roomUrls: map['roomUrls'],
      description: map['description'],
      roomPrice: map['roomPrice'],
      roomMateCount: map['roomMateCount'],
      availableRoomCount: map['availableRoomCount'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Hostel.fromJson(String source) => Hostel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Hostel(name: $name, adminName: $adminName, address: $address, contact: $contact, collegeID: $collegeID, roomUrls: $roomUrls, description: $description, roomPrice: $roomPrice, roomMateCount: $roomMateCount, availableRoomCount: $availableRoomCount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Hostel &&
        other.name == name &&
        other.adminName == adminName &&
        other.address == address &&
        other.contact == contact &&
        other.collegeID == collegeID &&
        other.roomUrls == roomUrls &&
        other.description == description &&
        other.roomPrice == roomPrice &&
        other.roomMateCount == roomMateCount &&
        other.availableRoomCount == availableRoomCount;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        adminName.hashCode ^
        address.hashCode ^
        contact.hashCode ^
        collegeID.hashCode ^
        roomUrls.hashCode ^
        description.hashCode ^
        roomPrice.hashCode ^
        roomMateCount.hashCode ^
        availableRoomCount.hashCode;
  }
}
