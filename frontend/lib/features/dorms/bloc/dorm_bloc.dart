import 'dart:async';

import 'package:bloc/bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:database_provider/database_provider.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

part 'dorm_event.dart';
part 'dorm_state.dart';

class DormBloc extends Bloc<DormEvent, DormState> {
  DormBloc(this._provider) : super(DormState.empty());
  final IDatabaseProvider _provider;
  @override
  Stream<DormState> mapEventToState(
    DormEvent event,
  ) async* {
    if (event is GetCollgesByName) {
      yield state.copyWith(isLoading: true);
      try {
        List<College> colleges = await _provider.getCollegesByName(event.name);
        yield state.copyWith(isLoading: false, colleges: colleges);
      } catch (e) {
        yield state.copyWith(isLoading: false, error: e.toString());
      }
    } else if (event is GetHostelsByCID) {
      yield state.copyWith(isLoading: true);
      try {
        List<Hostel> colleges = await _provider.getHostelsByCID(event.id);
        yield state.copyWith(isLoading: false, hostels: colleges);
      } catch (e) {
        yield state.copyWith(isLoading: false, error: e.toString());
      }
    } else if (event is GetHostelsByName) {
      yield state.copyWith(isLoading: true);
      try {
        List<Hostel> colleges = await _provider.getHostelByName(event.name);
        yield state.copyWith(isLoading: false, hostels: colleges);
      } catch (e) {
        yield state.copyWith(isLoading: false, error: e.toString());
      }
    } else if (event is GetHostelsNearBy) {
      yield state.copyWith(isLoading: true);
      try {
        LocationPermission permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception("Location permission denied");
        }
        final Position curPos = await Geolocator.getCurrentPosition();
        List<Hostel> hostels = await _provider.getCurrentNearbyHostels(
            curPos.latitude, curPos.longitude);

        yield state.copyWith(isLoading: false, nearbyHostels: hostels);
      } catch (e) {
        yield state.copyWith(isLoading: false, error: e.toString());
      }
    } else if (event is ResetErrors) {
      yield state.copyWith(error: "");
    } else if (event is OpenMaps) {
      print("object");
      final url =
          'https://www.google.com/maps/search/?api=1&query=${event.lat},${event.lon}';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        print("1");
        yield state.copyWith(error: "Can not launch the maps");
      }
    }
  }
}
