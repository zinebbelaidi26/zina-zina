import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../models/sign_gestures.dart';

class AnimatedSignCharacter extends StatefulWidget {
  final String word;
  final VoidCallback? onComplete;

  const AnimatedSignCharacter({
    super.key,
    required this.word,
    this.onComplete,
  });

  @override
  State<AnimatedSignCharacter> createState() => _AnimatedSignCharacterState();
}

class _AnimatedSignCharacterState extends State<AnimatedSignCharacter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late SignGesture _currentGesture;
  int _currentPositionIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentGesture = SignLanguageGestures.getGestureForWord(widget.word);
    _controller = AnimationController(
      duration: Duration(milliseconds: (_currentGesture.duration * 1000).round()),
      vsync: this,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (_currentPositionIndex < _currentGesture.rightHandPositions.length - 1) {
          setState(() {
            _currentPositionIndex++;
            _controller.reset();
            _controller.forward();
          });
        } else if (widget.onComplete != null) {
          widget.onComplete!();
        }
      }
    });

    _controller.forward();
  }

  @override
  void didUpdateWidget(AnimatedSignCharacter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.word != widget.word) {
      _currentGesture = SignLanguageGestures.getGestureForWord(widget.word);
      _currentPositionIndex = 0;
      _controller.duration = Duration(milliseconds: (_currentGesture.duration * 1000).round());
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final currentPosition = _currentGesture.rightHandPositions[_currentPositionIndex];
        final currentLeftPosition = _currentGesture.leftHandPositions[0]; // Usually static

        return CustomPaint(
          size: const Size(300, 400),
          painter: CharacterPainter(
            rightHandPosition: currentPosition,
            leftHandPosition: currentLeftPosition,
            word: widget.word,
            progress: _controller.value,
          ),
        );
      },
    );
  }
}

class CharacterPainter extends CustomPainter {
  final HandPosition rightHandPosition;
  final HandPosition leftHandPosition;
  final String word;
  final double progress;

  CharacterPainter({
    required this.rightHandPosition,
    required this.leftHandPosition,
    required this.word,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 3);
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    // Draw head
    canvas.drawCircle(center, 40, paint);

    // Draw face
    _drawFace(canvas, center);

    // Draw body
    canvas.drawLine(
      center.translate(0, 40),
      center.translate(0, 120),
      paint,
    );

    // Draw arms and hands
    _drawArm(canvas, center.translate(0, 60), rightHandPosition, true);
    _drawArm(canvas, center.translate(0, 60), leftHandPosition, false);
  }

  void _drawFace(Canvas canvas, Offset center) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Eyes
    canvas.drawCircle(center.translate(-15, -10), 5, paint);
    canvas.drawCircle(center.translate(15, -10), 5, paint);

    // Smile
    final smilePath = Path()
      ..moveTo(center.dx - 20, center.dy + 10)
      ..quadraticBezierTo(
        center.dx,
        center.dy + 25,
        center.dx + 20,
        center.dy + 10,
      );
    canvas.drawPath(smilePath, paint);
  }

  void _drawArm(Canvas canvas, Offset shoulder, HandPosition handPosition, bool isRight) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final direction = isRight ? 1.0 : -1.0;
    final baseOffset = shoulder.translate(30.0 * direction, 0.0);
    
    // Draw upper arm
    final elbow = baseOffset.translate(
      handPosition.position.dx * direction,
      handPosition.position.dy,
    );
    canvas.drawLine(shoulder, elbow, paint);

    // Draw hand
    final handCenter = elbow.translate(20.0 * direction, 0.0);
    canvas.save();
    canvas.translate(handCenter.dx, handCenter.dy);
    canvas.rotate(handPosition.rotation * direction);

    // Draw palm
    canvas.drawCircle(Offset.zero, 10.0, paint);

    // Draw fingers
    for (int i = 0; i < 5; i++) {
      final angle = (i - 2) * 0.2;
      final bend = handPosition.fingerBends[i];
      final spread = i < 4 ? handPosition.fingerSpreads[i] : 0.0;
      
      final fingerStart = Offset(0.0, -10.0);
      final fingerMid = Offset(spread * 8.0, -20.0 + (bend * 10.0));
      final fingerEnd = Offset(spread * 12.0, -30.0 + (bend * 20.0));
      
      final fingerPath = Path()
        ..moveTo(fingerStart.dx, fingerStart.dy)
        ..quadraticBezierTo(
          fingerMid.dx,
          fingerMid.dy,
          fingerEnd.dx,
          fingerEnd.dy,
        );
      
      canvas.save();
      canvas.rotate(angle);
      canvas.drawPath(fingerPath, paint);
      canvas.restore();
    }
    
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CharacterPainter oldDelegate) {
    return oldDelegate.rightHandPosition != rightHandPosition ||
        oldDelegate.leftHandPosition != leftHandPosition ||
        oldDelegate.progress != progress;
  }
} 