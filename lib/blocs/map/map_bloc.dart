import 'dart:async';

import 'package:appprueba/services/services.dart';
import 'package:appprueba/ui/markers/markers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:appprueba/blocs/blocs.dart';
import 'package:appprueba/ui/helpers/helpers.dart';
import 'package:appprueba/models/models.dart';
import 'package:uuid/uuid.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {

  BuildContext context;
  LocationBloc? locationBloc;
  GoogleMapController? _mapController;
  Map<String, Marker>? currentMarkers;

  StreamSubscription<LocationState>? locationStateSubscription;

  MapBloc({
    required this.context
  }) : super( const MapState() ) {

    locationBloc = BlocProvider.of<LocationBloc>(this.context);
    
    on<OnMapInitialzedEvent>( _onInitMap );
    on<DisplayPolylinesEvent>((event, emit) => emit( state.copyWith( polylines: event.polylines) ));
    on<DisplayMarkersEvents>((event, emit) => emit( state.copyWith(markers: event.markers) ));
    on<OnUpdateLocationEvent>(_updateCurrentLocation);

    currentMarkers = Map<String, Marker>.from( state.markers );

    locationStateSubscription = locationBloc!.stream.listen(( locationState ) {
      if( locationState.lastKnownLocation == null ) return;
        print("Current Location ${locationState.lastKnownLocation}");
        moveCamera( locationState.lastKnownLocation!);
        add(OnUpdateLocationEvent(locationState.lastKnownLocation!));

    });

  }

  void _onInitMap( OnMapInitialzedEvent event, Emitter<MapState> emit ) async{
    _mapController = event.controller;
    emit( state.copyWith( isMapInitialized: true ) );
    var infoRouter = await TrafficService().servicesRoute(locationBloc!.state.lastKnownLocation!);
    _drawMarketsInit(infoRouter);
    _drawRoutePolyline(infoRouter);
  }

  void _updateCurrentLocation(OnUpdateLocationEvent event,Emitter<MapState> emit) async{
       await addMarkersPositions(event.currentLocation,currentMarkers!);
       await updateMarkerMyPosition(event.currentLocation,currentMarkers!);
       add(DisplayMarkersEvents(currentMarkers!));
       emit(state.copyWith(markers: state.markers));
       printMap();
  }

  void printMap(){
      state.markers.forEach((key, value) {
           print("$key -> ${value.position.latitude},${value.position.longitude}");
      });
  }

  Future addMarkersPositions(LatLng newLocation,Map<String, Marker> listMarkers) async {
      var id = Uuid().v4();
      final myMarkerRouter = drawMarker(newLocation,await getRouteCustomMarker(),'route-$id');
      listMarkers['route-$id'] = myMarkerRouter;
  }

  Future updateMarkerMyPosition(LatLng newLocation,Map<String, Marker> listMarkers) async{
     final startMarker = drawMarker(newLocation,await getStartCustomMarker(),"start");
     listMarkers['start'] = startMarker;
  }


  Future _drawRoutePolyline(RouteDestination routeDestination) async {
    final myRoute = drawPolylineMap(
        routeDestination.points,
        'route',
        Colors.teal,
        2
    );
    final curretPolylines = Map<String, Polyline>.from( state.polylines );
    curretPolylines['route'] = myRoute;
    add( DisplayPolylinesEvent(curretPolylines));
  }

  Future _drawMarketsInit(RouteDestination routeDestination) async {
    final startMarker = drawMarker(routeDestination.destination,await getStartCustomMarker(),"start");
    final endMarker = drawMarker(routeDestination.end,await getEndCustomMarker(),"end");
    currentMarkers!['start'] = startMarker;
    currentMarkers!['end'] = endMarker;
    add(DisplayMarkersEvents(currentMarkers!));
  }

  void moveCamera(LatLng? newLocation){
    final cameraUpdate = CameraUpdate.newLatLng(newLocation!);
    _mapController?.animateCamera(cameraUpdate);
  }

  @override
  Future<void> close() {
    locationStateSubscription?.cancel();
    return super.close();
  }
}
