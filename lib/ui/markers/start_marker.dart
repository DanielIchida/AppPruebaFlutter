

import 'package:flutter/material.dart';

class StartMarkerPainter extends CustomPainter {

  StartMarkerPainter();

  
  @override
  void paint(Canvas canvas, Size size) {
    
    final blackPaint = Paint()
                        ..color = Colors.black;
    
    final whitePaint = Paint()
                        ..color = Colors.white;

    const double circleBlackRadius = 20;
    const double circleWhiteRadius = 7;

    // Circulo Negro
    canvas.drawCircle(
      Offset( circleBlackRadius, size.height - circleBlackRadius ) , 
      circleBlackRadius, 
      blackPaint);

    // Circulo Blanco
    canvas.drawCircle(
      Offset( circleBlackRadius, size.height - circleBlackRadius ) , 
      circleWhiteRadius, 
      whitePaint );


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;

}