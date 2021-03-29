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
}

class DatabaseProvider implements IDatabaseProvider {
  static const String url = "example.com";
  @override
  Future<List<College>> getCollegesByName(String name) async {
    final u = Uri.parse('$url');
    http.Response res =
        await http.get(u, headers: <String, String>{'name': name});
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
      double latitude, double longitude) async {
    final u = Uri.parse('$url');
    http.Response res = await http.get(u,
        headers: {'lon': longitude.toString(), "lat": latitude.toString()});
    if (res.statusCode == 200) {
      print(res.body);
      final Iterable l = json.decode(res.body);
      return List.from(l.map((e) => Hostel.fromJson(e)));
    } else {
      throw Exception("Failed to get colleges from server!");
    }
  }

  @override
  Future<List<Hostel>> getHostelByName(String name) async {
    final u = Uri.parse('$url');
    http.Response res =
        await http.get(u, headers: <String, String>{'name': name});
    if (res.statusCode == 200) {
      print(res.body);
      final Iterable l = json.decode(res.body);
      return List.from(l.map((e) => Hostel.fromJson(e)));
    } else {
      throw Exception("Failed to get colleges from server!");
    }
  }

  @override
  Future<List<Hostel>> getHostelsByCID(int id) async {
    final u = Uri.parse('$url');
    http.Response res =
        await http.get(u, headers: <String, String>{'name': id.toString()});
    if (res.statusCode == 200) {
      print(res.body);
      final Iterable l = json.decode(res.body);
      return List.from(l.map((e) => Hostel.fromJson(e)));
    } else {
      throw Exception("Failed to get colleges from server!");
    }
  }
}
