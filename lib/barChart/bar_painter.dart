import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BarPainter extends CustomPainter {
  double progressValue;
  Color progressColor;

  BarPainter(this.progressValue, this.progressColor);

  @override
  void paint(Canvas canvas, Size size) {
    Paint basePaint = Paint();
    basePaint.color = Colors.grey;
    basePaint.strokeWidth = 6;
    basePaint.style = PaintingStyle.stroke;
    basePaint.strokeCap = StrokeCap.round;

    Paint progressPaint = Paint();
    progressPaint.color = progressColor;
    progressPaint.strokeWidth = 6;
    progressPaint.style = PaintingStyle.stroke;
    progressPaint.strokeCap = StrokeCap.round;

    canvas.drawRect(Rect.fromLTRB(0, 0, size.width, size.height), basePaint);
    if(progressValue > 0) {
      canvas.drawRect(
          Rect.fromLTRB(
              0, size.height, size.width, size.height - (size.height * progressValue)),
          progressPaint);
    }

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
