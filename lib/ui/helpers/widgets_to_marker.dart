import 'dart:ui' as ui;
import 'dart:ui';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:appprueba/ui/markers/markers.dart';

Future<BitmapDescriptor> getStartCustomMarker() async {
  final recoder = ui.PictureRecorder();
  final canvas = ui.Canvas( recoder );
  const size = ui.Size(350, 150);

  final startMarker = StartMarkerPainter();
  startMarker.paint(canvas, size);

  final picture = recoder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData( format: ui.ImageByteFormat.png );

  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());

}

Future<BitmapDescriptor> getEndCustomMarker() async {
  final recoder = ui.PictureRecorder();
  final canvas = ui.Canvas( recoder );
  const size = ui.Size(350, 150);

  final startMarker = EndMarkerPainter();
  startMarker.paint(canvas, size);

  final picture = recoder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData( format: ui.ImageByteFormat.png );

  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());

}

Future<BitmapDescriptor> getRouteCustomMarker() async {
  final recoder = ui.PictureRecorder();
  final canvas = ui.Canvas( recoder );
  const size = ui.Size(250, 100);

  final routeMarker = RouteMarkerPainter();
  routeMarker.paint(canvas, size);

  final picture = recoder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData( format: ui.ImageByteFormat.png );

  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
}

Marker drawMarker(LatLng position,BitmapDescriptor bitmapDescriptor,String id){
    return Marker(
      anchor: const Offset(0.1, 1),
      markerId: MarkerId(id),
      position: position,
      icon: bitmapDescriptor,
    );
}

