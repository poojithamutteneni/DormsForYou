part of 'dorm_bloc.dart';

class DormState extends Equatable {
  final List<College> colleges;
  final List<Hostel> nearbyHostels;
  final List<Hostel> hostels;
  final String error;
  final bool isSearchHostels;
  final bool isLoading;
  factory DormState.empty() => DormState([], [], [], "", true, false);

  DormState(this.colleges, this.nearbyHostels, this.hostels, this.error,
      this.isSearchHostels, this.isLoading);
  @override
  List<Object> get props =>
      [colleges, nearbyHostels, hostels, error, isSearchHostels, isLoading];

  DormState copyWith({
    List<College>? colleges,
    List<Hostel>? nearbyHostels,
    List<Hostel>? hostels,
    String? error,
    bool? isSearchHostels,
    bool? isLoading,
  }) {
    return DormState(
      colleges ?? this.colleges,
      nearbyHostels ?? this.nearbyHostels,
      hostels ?? this.hostels,
      error ?? this.error,
      isSearchHostels ?? this.isSearchHostels,
      isLoading ?? this.isLoading,
    );
  }
}
