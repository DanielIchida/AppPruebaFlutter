import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:appprueba/blocs/blocs.dart';

class MapView extends StatelessWidget {

  final LatLng initialLocation;
  final Set<Polyline> polylines;
  final Set<Marker> markers;

  const MapView({ 
    Key? key, 
    required this.initialLocation,
    required this.polylines,
    required this.markers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final mapBloc = BlocProvider.of<MapBloc>(context);

    final CameraPosition initialCameraPosition = CameraPosition(
        target: initialLocation,
        zoom: 19
    );


    return GoogleMap(
            initialCameraPosition: initialCameraPosition,
            compassEnabled: false,
            myLocationEnabled: false,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            markers: markers,
            polylines: polylines,
            onMapCreated: ( controller ) => mapBloc.add( OnMapInitialzedEvent(controller) )
        );
  }
}