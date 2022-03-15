part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class OnMapInitialzedEvent extends MapEvent {
  final GoogleMapController controller;
  const OnMapInitialzedEvent(this.controller);
}

class DisplayPolylinesEvent extends MapEvent {
  final Map<String,Polyline> polylines;
  const DisplayPolylinesEvent(this.polylines);
}

class DisplayMarkersEvents extends MapEvent {
  final Map<String, Marker> markers;
  const DisplayMarkersEvents(this.markers);
}

class OnUpdateLocationEvent extends MapEvent {
   final LatLng currentLocation;
   const OnUpdateLocationEvent(this.currentLocation);
}
