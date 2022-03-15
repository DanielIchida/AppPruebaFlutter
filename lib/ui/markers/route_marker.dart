import 'package:flutter/material.dart';

class RouteMarkerPainter extends CustomPainter {


  RouteMarkerPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final bluePaint = Paint()
      ..color = Colors.blueAccent;

    const double circleBlueRadius = 10;

    canvas.drawCircle(
        Offset(size.width * 0.5, size.height - circleBlueRadius),
        circleBlueRadius, bluePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;
}
