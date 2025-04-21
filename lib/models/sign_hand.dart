import 'package:flutter/material.dart';

class SignHand {
  final Offset position;
  final double rotation;
  final List<double> fingerBends; // 0-1 values for each finger's bend
  final List<double> fingerSpreads; // 0-1 values for finger spread
  final String handShape; // e.g., 'open', 'fist', 'point', etc.

  SignHand({
    required this.position,
    this.rotation = 0,
    required this.fingerBends,
    required this.fingerSpreads,
    required this.handShape,
  });

  static SignHand lerp(SignHand a, SignHand b, double t) {
    return SignHand(
      position: Offset.lerp(a.position, b.position, t)!,
      rotation: a.rotation + (b.rotation - a.rotation) * t,
      fingerBends: List.generate(
        a.fingerBends.length,
        (i) => a.fingerBends[i] + (b.fingerBends[i] - a.fingerBends[i]) * t,
      ),
      fingerSpreads: List.generate(
        a.fingerSpreads.length,
        (i) => a.fingerSpreads[i] + (b.fingerSpreads[i] - a.fingerSpreads[i]) * t,
      ),
      handShape: t < 0.5 ? a.handShape : b.handShape,
    );
  }
}

class SignGesture {
  final String word;
  final List<SignHand> rightHandPoses;
  final List<SignHand> leftHandPoses;
  final double duration;

  SignGesture({
    required this.word,
    required this.rightHandPoses,
    required this.leftHandPoses,
    this.duration = 1.0,
  });
} 