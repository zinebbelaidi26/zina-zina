import 'package:flutter/material.dart';
import '../models/sign_animation.dart';

class SignLanguageService {
  static final SignLanguageService _instance = SignLanguageService._internal();
  factory SignLanguageService() => _instance;
  SignLanguageService._internal();

  final Map<String, SignAnimation> _animations = {
    'hello': SignAnimation(
      word: 'hello',
      poses: [
        SignPose(
          rightHandPosition: const Offset(0, -20),
          leftHandPosition: const Offset(0, -20),
          rightHandRotation: 0,
          leftHandRotation: 0,
        ),
        SignPose(
          rightHandPosition: const Offset(20, -20),
          leftHandPosition: const Offset(-20, -20),
          rightHandRotation: 0.2,
          leftHandRotation: -0.2,
        ),
      ],
    ),
    'thank you': SignAnimation(
      word: 'thank you',
      poses: [
        SignPose(
          rightHandPosition: const Offset(0, -30),
          leftHandPosition: const Offset(0, -30),
          rightHandRotation: 0,
          leftHandRotation: 0,
        ),
        SignPose(
          rightHandPosition: const Offset(0, -10),
          leftHandPosition: const Offset(0, -10),
          rightHandRotation: 0.5,
          leftHandRotation: -0.5,
        ),
      ],
    ),
    // Add more signs here
  };

  List<SignAnimation> getAnimationsForText(String text) {
    final words = text.toLowerCase().split(' ');
    final animations = <SignAnimation>[];

    for (final word in words) {
      if (_animations.containsKey(word)) {
        animations.add(_animations[word]!);
      } else {
        // For unknown words, create a simple animation
        animations.add(
          SignAnimation(
            word: word,
            poses: [
              SignPose(
                rightHandPosition: const Offset(0, -20),
                leftHandPosition: const Offset(0, -20),
              ),
            ],
          ),
        );
      }
    }

    return animations;
  }
} 