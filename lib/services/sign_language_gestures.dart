import 'package:flutter/material.dart';
import '../models/sign_hand.dart';

class SignLanguageGestures {
  static final SignLanguageGestures _instance = SignLanguageGestures._internal();
  factory SignLanguageGestures() => _instance;
  SignLanguageGestures._internal();

  final Map<String, SignGesture> _gestures = {
    'hello': SignGesture(
      word: 'hello',
      rightHandPoses: [
        SignHand(
          position: const Offset(0, -20),
          rotation: 0,
          fingerBends: [0, 0, 0, 0, 0], // All fingers straight
          fingerSpreads: [0, 0, 0, 0], // No spread
          handShape: 'open',
        ),
        SignHand(
          position: const Offset(20, -20),
          rotation: 0.2,
          fingerBends: [0, 0, 0, 0, 0],
          fingerSpreads: [0, 0, 0, 0],
          handShape: 'open',
        ),
      ],
      leftHandPoses: [
        SignHand(
          position: const Offset(0, -20),
          rotation: 0,
          fingerBends: [0, 0, 0, 0, 0],
          fingerSpreads: [0, 0, 0, 0],
          handShape: 'open',
        ),
        SignHand(
          position: const Offset(-20, -20),
          rotation: -0.2,
          fingerBends: [0, 0, 0, 0, 0],
          fingerSpreads: [0, 0, 0, 0],
          handShape: 'open',
        ),
      ],
    ),
    'thank you': SignGesture(
      word: 'thank you',
      rightHandPoses: [
        SignHand(
          position: const Offset(0, -30),
          rotation: 0,
          fingerBends: [0, 0, 0, 0, 0],
          fingerSpreads: [0, 0, 0, 0],
          handShape: 'open',
        ),
        SignHand(
          position: const Offset(0, -10),
          rotation: 0.5,
          fingerBends: [0, 0, 0, 0, 0],
          fingerSpreads: [0, 0, 0, 0],
          handShape: 'open',
        ),
      ],
      leftHandPoses: [
        SignHand(
          position: const Offset(0, -30),
          rotation: 0,
          fingerBends: [0, 0, 0, 0, 0],
          fingerSpreads: [0, 0, 0, 0],
          handShape: 'open',
        ),
        SignHand(
          position: const Offset(0, -10),
          rotation: -0.5,
          fingerBends: [0, 0, 0, 0, 0],
          fingerSpreads: [0, 0, 0, 0],
          handShape: 'open',
        ),
      ],
    ),
  };

  List<SignGesture> getGesturesForText(String text) {
    final words = text.toLowerCase().split(' ');
    final gestures = <SignGesture>[];

    for (final word in words) {
      if (_gestures.containsKey(word)) {
        gestures.add(_gestures[word]!);
      } else {
        // For unknown words, create a simple gesture
        gestures.add(
          SignGesture(
            word: word,
            rightHandPoses: [
              SignHand(
                position: const Offset(0, -20),
                rotation: 0,
                fingerBends: [0, 0, 0, 0, 0],
                fingerSpreads: [0, 0, 0, 0],
                handShape: 'open',
              ),
            ],
            leftHandPoses: [
              SignHand(
                position: const Offset(0, -20),
                rotation: 0,
                fingerBends: [0, 0, 0, 0, 0],
                fingerSpreads: [0, 0, 0, 0],
                handShape: 'open',
              ),
            ],
          ),
        );
      }
    }

    return gestures;
  }
} 