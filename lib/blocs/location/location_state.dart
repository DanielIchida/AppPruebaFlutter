part of 'location_bloc.dart';

class LocationState extends Equatable {

  final LatLng? lastKnownLocation;
  final double velocity;

  const LocationState({
    this.lastKnownLocation,
    this.velocity = 0.0
  });

  LocationState copyWith({
    LatLng? lastKnownLocation,
    double? velocity
  }) => LocationState(
    lastKnownLocation: lastKnownLocation ?? this.lastKnownLocation,
    velocity: velocity ?? this.velocity
  );

  
  @override
  List<Object?> get props => [lastKnownLocation,velocity];
}
