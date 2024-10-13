import 'package:flutter/material.dart';

import '../models/models.dart';

class StartMarkerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final blackPaint = Paint()..color = Colors.black;
    final whitePaint = Paint()..color = Colors.white;

    const double circleBlackRadius = 20;
    const double circleWhiteRadius = 7;

    // Black Circle
    canvas.drawCircle(
        Offset(circleBlackRadius, size.height - circleBlackRadius),
        circleBlackRadius,
        blackPaint);

    // White Circle
    canvas.drawCircle(
        Offset(circleBlackRadius, size.height - circleBlackRadius),
        circleWhiteRadius,
        whitePaint);

    // White Box
    final path = Path();
    path.moveTo(40, 20);
    path.lineTo(size.width - 10, 20);
    path.lineTo(size.width - 10, 100);
    path.lineTo(40, 100);
    canvas.drawShadow(path, Colors.black, 10, false);
    canvas.drawPath(path, whitePaint);

    // Black Box
    const blackBox = Rect.fromLTWH(40, 20, 70, 80);
    canvas.drawRect(blackBox, blackPaint);

    // Trip Duration
    final minutesPainter = createTextPainter(CustomTextPainter(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.w400,
        direction: TextDirection.ltr,
        align: TextAlign.center,
        minWidth: 70,
        maxWidth: 70,
        text: '55'));

        final minWordPainter = createTextPainter(CustomTextPainter(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w300,
        direction: TextDirection.ltr,
        align: TextAlign.center,
        minWidth: 70,
        maxWidth: 70,
        text: 'Min'));

    minutesPainter.paint(canvas, const Offset(40, 35));
    minWordPainter.paint(canvas, const Offset(40, 68));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;

  TextPainter createTextPainter(CustomTextPainter customTextPainter) {
    final textSpan = TextSpan(
        style: TextStyle(
          color: customTextPainter.color,
          fontSize: customTextPainter.fontSize,
          fontWeight: customTextPainter.fontWeight,
        ),
        text: customTextPainter.text);

    return TextPainter(
      text: textSpan,
      textAlign: customTextPainter.align,
      textDirection: customTextPainter.direction,
    )..layout(
        minWidth: customTextPainter.minWidth,
        maxWidth: customTextPainter.maxWidth);
  }
}
