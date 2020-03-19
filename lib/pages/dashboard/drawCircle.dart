import 'package:flutter/material.dart';

class DrawCircle extends CustomPainter {
  Colors color;
  Paint _paint;

  DrawCircle(color) {
    _paint = Paint()
      ..color = color
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(-120.0, 20.0), 20.0, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
