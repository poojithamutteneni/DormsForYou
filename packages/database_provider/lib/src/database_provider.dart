import 'dart:convert';

import 'models/college.dart';
import 'models/hostel.dart';
import 'package:http/http.dart' as http;

abstract class IDatabaseProvider {
  Future<List<Hostel>> getCurrentNearbyHostels(
      double latitude, double longitude);
  Future<List<College>> getCollegesByName(String name);
  Future<List<Hostel>> getHostelByName(String name);
  Future<List<Hostel>> getHostelsNearbyCollege(int id);
}

class DatabaseProvider implements IDatabaseProvider {
  static const String url = "example.com";
  @override
  Future<List<College>> getCollegesByName(String name) async {
    final u = Uri.parse('$url');
    http.Response res = await http.get(u);
    if (res.statusCode == 200) {
      print(res.body);
      final Iterable l = json.decode(res.body);
      return List.from(l.map((e) => College.fromJson(e)));
    } else {
      throw Exception("Failed to get colleges from server!");
    }
  }

  @override
  Future<List<Hostel>> getCurrentNearbyHostels(
      double latitude, double longitude) {
    // TODO: implement getCurrentNearbyHostels
    throw UnimplementedError();
  }

  @override
  Future<List<Hostel>> getHostelByName(String name) async {
    final u = Uri.parse('$url');
    http.Response res = await http.get(u);
    if (res.statusCode == 200) {
      print(res.body);
      final Iterable l = json.decode(res.body);
      return List.from(l.map((e) => Hostel.fromJson(e)));
    } else {
      throw Exception("Failed to get colleges from server!");
    }
  }

  @override
  Future<List<Hostel>> getHostelsNearbyCollege(int id) async {
    final u = Uri.parse('$url');
    http.Response res = await http.get(u);
    if (res.statusCode == 200) {
      print(res.body);
      final Iterable l = json.decode(res.body);
      return List.from(l.map((e) => Hostel.fromJson(e)));
    } else {
      throw Exception("Failed to get colleges from server!");
    }
  }
}
