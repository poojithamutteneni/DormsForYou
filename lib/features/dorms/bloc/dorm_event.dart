part of 'dorm_bloc.dart';

abstract class DormEvent {
  const DormEvent();
}

class GetHostelsNearBy implements DormEvent {
  const GetHostelsNearBy();
}

class OpenMaps implements DormEvent {
  const OpenMaps(this.lat, this.lon);
  final String lat, lon;
}

class ResetErrors implements DormEvent {}

class GetHostelsByCID implements DormEvent {
  final int id;

  GetHostelsByCID(this.id);
}

class GetHostelsByName implements DormEvent {
  final String name;

  GetHostelsByName(this.name);
}

class GetCollgesByName implements DormEvent {
  final String name;

  GetCollgesByName(this.name);
}
