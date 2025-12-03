import 'package:flutter/material.dart';

class QrCodePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final painter = Paint()..color = Colors.red;

    canvas.drawRect(
      Rect.fromCenter(center: Offset(0, 0), width: 40, height: 40),

      painter,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
