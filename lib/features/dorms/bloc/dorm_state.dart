part of 'dorm_bloc.dart';

class DormState extends Equatable {
  final List<College> colleges;
  final List<Hostel> nearbyHostels;
  final List<Hostel> hostels;
  final String error;

  factory DormState.empty() => DormState([], [], [], "");

  DormState(this.colleges, this.nearbyHostels, this.hostels, this.error);
  @override
  List<Object> get props => [colleges, nearbyHostels, hostels, error];
}
