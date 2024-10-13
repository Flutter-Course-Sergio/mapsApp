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

    const double circleBlackRadius = 10;
    const double circleWhiteRadius = 3.5;

    // Black Circle
    canvas.drawCircle(Offset(size.width * 0.5, size.height - circleBlackRadius),
        circleBlackRadius, blackPaint);

    // White Circle
    canvas.drawCircle(Offset(size.width * 0.5, size.height - circleBlackRadius),
        circleWhiteRadius, whitePaint);

    // White Box
    final path = Path();
    path.moveTo(20, 10);
    path.lineTo(size.width - 10, 10);
    path.lineTo(size.width - 10, 50);
    path.lineTo(20, 50);
    canvas.drawShadow(path, Colors.black, 10, false);
    canvas.drawPath(path, whitePaint);

    // Black Box
    const blackBox = Rect.fromLTWH(20, 10, 35, 40);
    canvas.drawRect(blackBox, blackPaint);

    // Trip Duration
    final minutesPainter = createTextPainter(CustomTextPainter(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        direction: TextDirection.ltr,
        align: TextAlign.center,
        minWidth: 35,
        maxWidth: 35,
        text: '$kilometers'));

    final minWordPainter = createTextPainter(CustomTextPainter(
        color: Colors.white,
        fontSize: 10,
        fontWeight: FontWeight.w300,
        direction: TextDirection.ltr,
        align: TextAlign.center,
        minWidth: 35,
        maxWidth: 35,
        text: 'Kms'));

    final locationPainter = createTextPainter(CustomTextPainter(
        color: Colors.black,
        fontSize: 10,
        fontWeight: FontWeight.w300,
        direction: TextDirection.ltr,
        align: TextAlign.left,
        minWidth: size.width - 95,
        maxWidth: size.width - 95,
        text: destination));

    minutesPainter.paint(canvas, const Offset(20, 15));
    minWordPainter.paint(canvas, const Offset(20, 33));

    final double offsetY = (destination.length > 25) ? 17 : 25;

    locationPainter.paint(canvas, Offset(60, offsetY));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;
}
