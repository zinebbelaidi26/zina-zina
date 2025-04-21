import 'package:flutter/material.dart';
import 'dart:math';
import '../models/sign_hand.dart';

class SignHandWidget extends CustomPainter {
  final SignHand hand;
  final double progress;

  SignHandWidget({
    required this.hand,
    this.progress = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final handCenter = center + hand.position;
    
    // Save the canvas state
    canvas.save();
    
    // Translate to hand center and rotate
    canvas.translate(handCenter.dx, handCenter.dy);
    canvas.rotate(hand.rotation);
    
    // Draw palm
    final palmPaint = Paint()
      ..color = const Color(0xFFFFDBAC)  // Light skin tone color
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(Offset.zero, 15, palmPaint);
    
    // Draw fingers
    _drawFingers(canvas, hand);
    
    // Restore the canvas state
    canvas.restore();
  }

  void _drawFingers(Canvas canvas, SignHand hand) {
    final fingerPaint = Paint()
      ..color = const Color(0xFFFFDBAC)  // Light skin tone color
      ..style = PaintingStyle.fill;
    
    // Draw each finger
    for (int i = 0; i < 5; i++) {
      final baseAngle = -0.5 + (i * 0.25);
      final spread = i < 4 ? hand.fingerSpreads[i] : 0;
      final bend = hand.fingerBends[i];
      
      // Calculate finger position
      final angle = baseAngle + (spread * 0.3);
      final length = 20 * (1 - bend * 0.5);
      
      // Draw finger segments
      final start = Offset.zero;
      final end = Offset(
        length * cos(angle),
        length * sin(angle),
      );
      
      // Draw finger
      canvas.drawLine(start, end, fingerPaint);
      
      // Draw finger tip
      canvas.drawCircle(end, 3, fingerPaint);
    }
  }

  @override
  bool shouldRepaint(covariant SignHandWidget oldDelegate) {
    return oldDelegate.hand != hand || oldDelegate.progress != progress;
  }
}

class AnimatedSignHands extends StatefulWidget {
  final SignGesture gesture;
  final VoidCallback? onComplete;

  const AnimatedSignHands({
    super.key,
    required this.gesture,
    this.onComplete,
  });

  @override
  State<AnimatedSignHands> createState() => _AnimatedSignHandsState();
}

class _AnimatedSignHandsState extends State<AnimatedSignHands>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _currentPoseIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (widget.gesture.duration * 1000).round()),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (_currentPoseIndex < widget.gesture.rightHandPoses.length - 1) {
            _currentPoseIndex++;
            _controller.forward(from: 0);
          } else if (widget.onComplete != null) {
            widget.onComplete!();
          }
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = _animation.value;
    
    final rightHand = SignHand.lerp(
      widget.gesture.rightHandPoses[_currentPoseIndex],
      _currentPoseIndex < widget.gesture.rightHandPoses.length - 1
          ? widget.gesture.rightHandPoses[_currentPoseIndex + 1]
          : widget.gesture.rightHandPoses[_currentPoseIndex],
      progress,
    );
    
    final leftHand = SignHand.lerp(
      widget.gesture.leftHandPoses[_currentPoseIndex],
      _currentPoseIndex < widget.gesture.leftHandPoses.length - 1
          ? widget.gesture.leftHandPoses[_currentPoseIndex + 1]
          : widget.gesture.leftHandPoses[_currentPoseIndex],
      progress,
    );

    return Stack(
      children: [
        // Right hand
        Positioned(
          right: 0,
          child: CustomPaint(
            size: const Size(100, 100),
            painter: SignHandWidget(hand: rightHand),
          ),
        ),
        // Left hand
        Positioned(
          left: 0,
          child: CustomPaint(
            size: const Size(100, 100),
            painter: SignHandWidget(hand: leftHand),
          ),
        ),
      ],
    );
  }
} 