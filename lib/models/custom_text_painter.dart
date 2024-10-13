import 'package:flutter/material.dart';

class CustomTextPainter {
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextDirection direction;
  final TextAlign align;
  final double minWidth;
  final double maxWidth;
  final String text;

  CustomTextPainter(
      {required this.color,
      required this.fontSize,
      required this.fontWeight,
      required this.direction,
      required this.align,
      required this.minWidth,
      required this.maxWidth,
      required this.text});
}
