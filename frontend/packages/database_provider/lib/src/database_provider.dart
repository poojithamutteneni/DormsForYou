import 'dart:convert';

import 'models/college.dart';
import 'models/hostel.dart';
import 'package:http/http.dart' as http;

abstract class IDatabaseProvider {
  Future<List<Hostel>> getCurrentNearbyHostels(
      double latitude, double longitude);
  Future<List<College>> getCollegesByName(String name);
  Future<List<Hostel>> getHostelByName(String name);
  Future<List<Hostel>> getHostelsByCID(int id);
  Future<void> bookHostel(String uid, String to, String from, String hid);
}

class DatabaseProvider implements IDatabaseProvider {
  static const String url = "http://192.168.1.106:6000";
  @override
  Future<List<College>> getCollegesByName(String name) async {
    final u = Uri.parse('$url/request/getcollegesbyname');
    print("object");
    http.Response res =
        await http.post(u, headers: <String, String>{'name': name});
    print(res.body);
    if (res.statusCode == 200) {
      final Iterable l = json.decode(res.body);
      return List.from(l.map((e) => College.fromMap(e)));
    } else {
      throw Exception("Failed to get colleges from server!");
    }
  }

  @override
  Future<List<Hostel>> getCurrentNearbyHostels(
      double latitude, double longitude) async {
    print(url);
    final u = Uri.parse('$url/request/getHostelsNearbyCurrentLocation');
    http.Response res = await http.post(u, headers: <String, String>{
      'longitude': longitude.toString(),
      "latitude": latitude.toString()
    });
    if (res.statusCode == 200) {
      print(res.body);
      final Iterable l = json.decode(res.body);
      return List.from(l.map((e) => Hostel.fromMap(e)));
    } else {
      throw Exception("Failed to get hostels from server!");
    }
  }

  @override
  Future<List<Hostel>> getHostelByName(String name) async {
    final u = Uri.parse('$url/request/gethostelsbyname');
    http.Response res =
        await http.post(u, headers: <String, String>{'name': name});
    if (res.statusCode == 200) {
      print(res.body);
      final Iterable l = json.decode(res.body);
      return List.from(l.map((e) => Hostel.fromMap(e)));
    } else {
      throw Exception("Failed to get colleges from server!");
    }
  }

  @override
  Future<List<Hostel>> getHostelsByCID(int id) async {
    final u = Uri.parse('$url/request/gethostelsbycid');
    http.Response res =
        await http.post(u, headers: <String, String>{'cid': id.toString()});
    if (res.statusCode == 200) {
      print(res.body);
      final Iterable l = json.decode(res.body);
      return List.from(l.map((e) => Hostel.fromMap(e)));
    } else {
      throw Exception("Failed to get colleges from server!");
    }
  }

  @override
  Future<void> bookHostel(
      String uid, String to, String from, String hid) async {
    final u = Uri.parse('$url/book');

    await http.post(u, headers: <String, String>{
      'cid': uid,
      "to": to,
      "from": from,
      "hid": hid
    });
  }
}
