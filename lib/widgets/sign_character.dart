import 'package:flutter/material.dart';
import '../models/sign_animation.dart';

class AnimatedSignCharacter extends StatefulWidget {
  final SignAnimation animation;
  final VoidCallback? onComplete;

  const AnimatedSignCharacter({
    super.key,
    required this.animation,
    this.onComplete,
  });

  @override
  State<AnimatedSignCharacter> createState() => _AnimatedSignCharacterState();
}

class _AnimatedSignCharacterState extends State<AnimatedSignCharacter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _currentPoseIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (widget.animation.duration * 1000).round()),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (_currentPoseIndex < widget.animation.poses.length - 1) {
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
    final currentPose = widget.animation.poses[_currentPoseIndex];
    final nextPose = _currentPoseIndex < widget.animation.poses.length - 1
        ? widget.animation.poses[_currentPoseIndex + 1]
        : currentPose;

    final progress = _animation.value;

    final interpolatedPose = SignPose(
      rightHandPosition: Offset.lerp(
        currentPose.rightHandPosition,
        nextPose.rightHandPosition,
        progress,
      )!,
      leftHandPosition: Offset.lerp(
        currentPose.leftHandPosition,
        nextPose.leftHandPosition,
        progress,
      )!,
      rightHandRotation: currentPose.rightHandRotation +
          (nextPose.rightHandRotation - currentPose.rightHandRotation) * progress,
      leftHandRotation: currentPose.leftHandRotation +
          (nextPose.leftHandRotation - currentPose.leftHandRotation) * progress,
      expression: currentPose.expression,
    );

    return CustomPaint(
      size: const Size(200, 200),
      painter: SignCharacter(
        pose: interpolatedPose,
        progress: progress,
      ),
    );
  }
} 