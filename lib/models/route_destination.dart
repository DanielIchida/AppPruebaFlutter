
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class RouteDestination {

  late LatLng destination;
  late LatLng end;
  late List<LatLng> points;

  RouteDestination({
    required this.destination,
    required this.end,
    required this.points
  });

}