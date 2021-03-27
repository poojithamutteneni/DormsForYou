part of 'dorm_bloc.dart';

abstract class DormEvent {
  const DormEvent();
}

class GetHostelsNearBy implements DormEvent {}

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
