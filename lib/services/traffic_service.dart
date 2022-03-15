import 'package:appprueba/config/config_app.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:appprueba/models/models.dart';

import 'package:appprueba/services/services.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';


class TrafficService {

  final Dio _dioTraffic;

  final String _baseTrafficUrl = ConfigApp.URL_API_MAPBOOX;

  TrafficService()
    : _dioTraffic = Dio()..interceptors.add( TrafficInterceptor() );


  Future<TrafficResponse> getCoorsStartToEnd( LatLng start, LatLng end ) async {

    final coorsString = '${ start.longitude },${ start.latitude };${ end.longitude },${ end.latitude }';
    final url = '$_baseTrafficUrl/driving/$coorsString';

    final resp = await _dioTraffic.get(url);

    final data = TrafficResponse.fromMap(resp.data);
    
    return data;

  }

  Future<RouteDestination> servicesRoute(LatLng myLocation) async{

    RouteDestination routeDestination = RouteDestination(
        destination:  myLocation,
        end:  LatLng(4.672655, -74.054071), points: []);

    final services = await getCoorsStartToEnd(
        routeDestination.destination,
        routeDestination.end
    );

    final geometry = services.routes[0].geometry;
    final points = decodePolyline( geometry, accuracyExponent: 6 );
    final latLngList = points.map( ( coor ) => LatLng(coor[0].toDouble(), coor[1].toDouble()) ).toList();
    routeDestination.points = latLngList;

    return routeDestination;
  }


}