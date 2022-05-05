import 'package:flutter/material.dart';
import 'dart:ui'as ui;

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
  ..shader = ui.Gradient.linear(
      const Offset(2, 1),
      Offset(size.width, size.height),
      <Color>[ Colors.blue.shade900,  Colors.blue.shade400],
      <double>[1.0, 1.0],
      TileMode.clamp)

      ..style = PaintingStyle.stroke
      ..strokeWidth = 25.770000457763672;

    Path path0 = Path();

    canvas.drawPath(path0, paint0);

    Paint paint1 = Paint()
    ..shader=ui.Gradient.linear(
        const Offset(2, 1),
        Offset(size.width, size.height),
        <Color>[Colors.blue.shade900,  Colors.blue.shade400],
        <double>[0.0, 1.0],
        TileMode.clamp)
      ..style =PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path1 = Path();
    path1.moveTo(0, size.height * 0.4767911);
    path1.quadraticBezierTo(size.width * 0.4214286, size.height * 0.5411201,
        size.width, size.height * 0.2800202);
    path1.quadraticBezierTo(size.width * 1.0085714, size.height * 0.3506559,
        size.width, size.height * 0.5348133);
    path1.quadraticBezierTo(size.width * 0.5614286, size.height * 0.4720610, 0,
        size.height * 0.7151867);
    path1.quadraticBezierTo(size.width * -0.0057143, size.height * 0.6473890, 0,
        size.height * 0.4767911);
    path1.close();

    canvas.drawPath(path1, paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
