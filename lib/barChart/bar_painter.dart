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


    RRect baseRRect = RRect.fromRectAndRadius(Rect.fromLTRB(0, 0, size.width, size.height), Radius.circular(size.width / 2));
    RRect progressRRect = RRect.fromRectAndRadius(Rect.fromLTRB(0, size.height, size.width, size.height - (size.height * progressValue)), Radius.circular(size.height / 2));
    canvas.drawRRect(baseRRect, basePaint);
    if (progressValue > 0) {
      canvas.drawRRect(progressRRect, progressPaint);
    }

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
