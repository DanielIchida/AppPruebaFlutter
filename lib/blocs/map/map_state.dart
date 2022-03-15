part of 'map_bloc.dart';

class MapState extends Equatable {

  final bool isMapInitialized;
  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers;

  const MapState({
    this.isMapInitialized = false,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
  })
  : markers = markers ?? const {},
     polylines = polylines ?? const{};


  MapState copyWith({
    bool? isMapInitialized,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers
  })
  => MapState(
    isMapInitialized: isMapInitialized ?? this.isMapInitialized,
    polylines: polylines ?? this.polylines,
    markers: markers ?? this.markers
  );

  @override
  List<Object> get props => [ isMapInitialized,polylines,markers];
  
}


