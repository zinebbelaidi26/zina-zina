// ignore_for_file: file_names

import 'package:flutter/material.dart';

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..style = PaintingStyle.fill;
    Path wavePath = Path();
    paint.color = const Color(0xFF1649F1);
    wavePath.moveTo(0, size.height * 0.2);
    wavePath.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.05,
      size.width,
      size.height * 0.2,
    );
    wavePath.lineTo(size.width, 0);
    wavePath.lineTo(0, 0);
    wavePath.close();
    canvas.drawPath(wavePath, paint);

    Path yellowWavePath = Path();
    paint.color = const Color(0xFFEBF855);
    yellowWavePath.moveTo(0, size.height * 0.23);
    yellowWavePath.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.08,
      size.width,
      size.height * 0.23,
    );
    yellowWavePath.lineTo(size.width, size.height * 0.2);
    yellowWavePath.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.07,
      0,
      size.height * 0.2,
    );
    yellowWavePath.close();
    canvas.drawPath(yellowWavePath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
