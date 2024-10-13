import 'package:flutter/material.dart';

import '../helpers/helpers.dart';
import '../models/models.dart';

class EndMarkerPainter extends CustomPainter {
  final int kilometers;
  final String destination;

  EndMarkerPainter({required this.kilometers, required this.destination});

  @override
  void paint(Canvas canvas, Size size) {
    final blackPaint = Paint()..color = Colors.black;
    final whitePaint = Paint()..color = Colors.white;

    const double circleBlackRadius = 20;
    const double circleWhiteRadius = 7;

    // Black Circle
    canvas.drawCircle(Offset(size.width * 0.5, size.height - circleBlackRadius),
        circleBlackRadius, blackPaint);

    // White Circle
    canvas.drawCircle(Offset(size.width * 0.5, size.height - circleBlackRadius),
        circleWhiteRadius, whitePaint);

    // White Box
    final path = Path();
    path.moveTo(10, 20);
    path.lineTo(size.width - 10, 20);
    path.lineTo(size.width - 10, 100);
    path.lineTo(10, 100);
    canvas.drawShadow(path, Colors.black, 10, false);
    canvas.drawPath(path, whitePaint);

    // Black Box
    const blackBox = Rect.fromLTWH(10, 20, 70, 80);
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
        text: '$kilometers'));

    final minWordPainter = createTextPainter(CustomTextPainter(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w300,
        direction: TextDirection.ltr,
        align: TextAlign.center,
        minWidth: 70,
        maxWidth: 70,
        text: 'Kms'));

    final locationPainter = createTextPainter(CustomTextPainter(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w300,
        direction: TextDirection.ltr,
        align: TextAlign.left,
        minWidth: size.width - 95,
        maxWidth: size.width - 95,
        text: destination));

    minutesPainter.paint(canvas, const Offset(10, 35));
    minWordPainter.paint(canvas, const Offset(10, 68));

    final double offsetY = (destination.length > 25) ? 35 : 48;

    locationPainter.paint(canvas, Offset(90, offsetY));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;
}
