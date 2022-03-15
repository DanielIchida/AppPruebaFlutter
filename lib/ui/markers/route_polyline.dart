

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Polyline drawPolylineMap(List<LatLng> points,String id,Color colorLine,int width){
      return Polyline(
        polylineId: PolylineId(id),
        color: colorLine,
        width: width,
        points: points,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
      );
}