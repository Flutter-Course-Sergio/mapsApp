import 'package:flutter/material.dart';

import '../models/models.dart';

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
