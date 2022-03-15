

import 'package:flutter/material.dart';

class EndMarkerPainter extends CustomPainter {


  EndMarkerPainter();

  
  @override
  void paint(Canvas canvas, Size size) {
    
    final redPaint = Paint()
                        ..color = Colors.red;
    
    final whitePaint = Paint()
                        ..color = Colors.white;

    const double circleBlackRadius = 20;
    const double circleWhiteRadius = 7;

    // Circulo Negro
    canvas.drawCircle(
      Offset( size.width * 0.5 , size.height - circleBlackRadius ) , 
      circleBlackRadius, redPaint);

    // Circulo Blanco
    canvas.drawCircle(
      Offset( size.width * 0.5, size.height - circleBlackRadius ) , 
      circleWhiteRadius, 
      whitePaint );

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;

}