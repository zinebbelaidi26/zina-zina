import 'package:flutter/material.dart';

class SignAnimation {
  final String word;
  final List<SignPose> poses;
  final double duration;

  SignAnimation({
    required this.word,
    required this.poses,
    this.duration = 1.0,
  });
}

class SignPose {
  final Offset rightHandPosition;
  final Offset leftHandPosition;
  final double rightHandRotation;
  final double leftHandRotation;
  final String expression;

  SignPose({
    required this.rightHandPosition,
    required this.leftHandPosition,
    this.rightHandRotation = 0,
    this.leftHandRotation = 0,
    this.expression = 'neutral',
  });
}

class SignCharacter extends CustomPainter {
  final SignPose pose;
  final double progress;

  SignCharacter({
    required this.pose,
    this.progress = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    
    // Draw body
    final bodyPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Draw head
    canvas.drawCircle(center, 20, bodyPaint);

    // Draw body line
    canvas.drawLine(
      center,
      Offset(center.dx, center.dy + 40),
      bodyPaint,
    );

    // Draw arms
    _drawArm(
      canvas,
      center,
      pose.rightHandPosition,
      pose.rightHandRotation,
      bodyPaint,
    );
    _drawArm(
      canvas,
      center,
      pose.leftHandPosition,
      pose.leftHandRotation,
      bodyPaint,
    );
  }

  void _drawArm(
    Canvas canvas,
    Offset center,
    Offset handPosition,
    double rotation,
    Paint paint,
  ) {
    final shoulder = Offset(center.dx, center.dy + 20);
    final elbow = Offset(
      shoulder.dx + (handPosition.dx - shoulder.dx) * 0.5,
      shoulder.dy + (handPosition.dy - shoulder.dy) * 0.5,
    );

    canvas.drawLine(shoulder, elbow, paint);
    canvas.drawLine(elbow, handPosition, paint);
  }

  @override
  bool shouldRepaint(covariant SignCharacter oldDelegate) {
    return oldDelegate.pose != pose || oldDelegate.progress != progress;
  }
} 