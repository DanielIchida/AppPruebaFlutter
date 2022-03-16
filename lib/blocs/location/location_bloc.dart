import 'dart:async';

import 'package:appprueba/config/config_app.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  
  StreamSubscription<Position>? positionStream;

  LocationBloc() : super( const LocationState() ) {

    on<OnNewUserLocationEvent>((event, emit) {
      emit( 
        state.copyWith(
          lastKnownLocation: event.newLocation,
          velocity: event.velocity
        ) 
      );
    });

  }

  Future<void> startFollowingUser() async {
    final LocationSettings settings = AndroidSettings(
       accuracy: ConfigApp.ACCURACY_GPS,
       intervalDuration: const Duration(seconds: ConfigApp.TIME_LIMIT_SECOND_GPS),
       forceLocationManager: true,
       foregroundNotificationConfig: const ForegroundNotificationConfig(
           notificationTitle: "Run Gps", notificationText: "Running...",enableWakeLock: true)
    );
    positionStream = Geolocator.getPositionStream(locationSettings: settings).listen((event) {
      final position = event;
      var velocity = position == null ? 0.0 : calcularVelocity(position.speed);
      add( OnNewUserLocationEvent( LatLng( position.latitude, position.longitude),velocity));
    });
  }

  double calcularVelocity(double speed){
     return (speed * ConfigApp.CONST_VELOCITY);
  }

  void stopFollowingUser() {
    positionStream?.cancel();
    print('stopFollowingUser');
  }


  @override
  Future<void> close() {
    stopFollowingUser();
    return super.close();
  }

}
