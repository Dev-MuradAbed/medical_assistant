import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomTimerPainter extends CustomPainter {
  CustomTimerPainter({
    required this.total,
    required this.current,
    required this.backgroundColor,
    required this.color,
  });

  final double total;
  final int current;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress =
        (current == total ? 1 : (total - current) / total) * 2 * math.pi;
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = math.min(size.width / 2, size.height / 2);
    canvas.drawArc(
      new Rect.fromCircle(center: center, radius: radius),
      math.pi * 1.5,
      progress,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomTimerPainter old) {
    return (total != old.total ||
        current != old.current ||
        color != old.color ||
        backgroundColor != old.backgroundColor);
  }
}

class CountDownTimer extends StatelessWidget {
  final double? total;
  final int? current, bpm;
  final double fontSize;
  final double width, height;
  final Color? bgColor, color, textColor;
  final int? sp, dp;

  CountDownTimer({
    this.total,
    this.current,
    this.width = 200,
    this.height = 200,
    this.fontSize = 32.0,
    this.bgColor,
    this.color,
    this.textColor,
    this.bpm,
    this.sp,
    this.dp,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            SizedBox(
              width: width - 10.0,
              height: height - 10.0,
              child: CustomPaint(
                painter: CustomTimerPainter(
                  total: total??60,
                  current: current??0,
                  backgroundColor: bgColor??Colors.grey,
                  color: color!,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "$current",
                  style: TextStyle(
                    fontSize: fontSize,
                    color: textColor,
                  ),
                ),
                const Divider(),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  if (bpm! > 30 && bpm! < 150)
                    const Text(
                      "BPM ",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  Text(
                    (bpm! >30 && bpm! < 150 ? bpm.toString() : "--"),
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
