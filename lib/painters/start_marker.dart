import 'package:flutter/material.dart';

import '../models/models.dart';

class StartMarkerPainter extends CustomPainter {
  final int minutes;
  final String destination;

  StartMarkerPainter({required this.minutes, required this.destination});

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
        text: '$minutes'));

    final minWordPainter = createTextPainter(CustomTextPainter(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w300,
        direction: TextDirection.ltr,
        align: TextAlign.center,
        minWidth: 70,
        maxWidth: 70,
        text: 'Min'));

    final locationPainter = createTextPainter(CustomTextPainter(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w300,
        direction: TextDirection.ltr,
        align: TextAlign.left,
        minWidth: size.width - 135,
        maxWidth: size.width - 135,
        text: destination));

    minutesPainter.paint(canvas, const Offset(40, 35));
    minWordPainter.paint(canvas, const Offset(40, 68));

    final double offsetY = (destination.length > 20) ? 35 : 48;

    locationPainter.paint(canvas, Offset(120, offsetY));
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
      maxLines: 2,
      ellipsis: '...',
      text: textSpan,
      textAlign: customTextPainter.align,
      textDirection: customTextPainter.direction,
    )..layout(
        minWidth: customTextPainter.minWidth,
        maxWidth: customTextPainter.maxWidth);
  }
}
