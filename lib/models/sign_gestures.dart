import 'dart:math' as math;
import 'package:flutter/material.dart';

class SignGesture {
  final List<HandPosition> rightHandPositions;
  final List<HandPosition> leftHandPositions;
  final double duration;

  SignGesture({
    required this.rightHandPositions,
    required this.leftHandPositions,
    this.duration = 1.5,
  });
}

class HandPosition {
  final Offset position;
  final double rotation;
  final List<double> fingerBends;
  final List<double> fingerSpreads;

  HandPosition({
    required this.position,
    required this.rotation,
    required this.fingerBends,
    required this.fingerSpreads,
  });
}

class SignLanguageGestures {
  static final Map<String, SignGesture> alphabet = {
    'a': SignGesture(
      rightHandPositions: [
        HandPosition(
          position: Offset(20, 0),
          rotation: 0,
          fingerBends: [1, 1, 1, 1, 0], // Fist with thumb up
          fingerSpreads: [0, 0, 0, 0],
        ),
      ],
      leftHandPositions: [
        HandPosition(
          position: Offset(-60, 0),
          rotation: 0,
          fingerBends: [0, 0, 0, 0, 0],
          fingerSpreads: [0, 0, 0, 0],
        ),
      ],
    ),
    'b': SignGesture(
      rightHandPositions: [
        HandPosition(
          position: Offset(20, 0),
          rotation: 0,
          fingerBends: [0, 0, 0, 0, 1], // All fingers straight, thumb bent
          fingerSpreads: [0, 0, 0, 0],
        ),
      ],
      leftHandPositions: [
        HandPosition(
          position: Offset(-60, 0),
          rotation: 0,
          fingerBends: [0, 0, 0, 0, 0],
          fingerSpreads: [0, 0, 0, 0],
        ),
      ],
    ),
    'hello': SignGesture(
      rightHandPositions: [
        HandPosition(
          position: Offset(20, -30),
          rotation: -math.pi / 6,
          fingerBends: [0, 0, 0, 0, 0],
          fingerSpreads: [0.3, 0.3, 0.3, 0.3],
        ),
        HandPosition(
          position: Offset(40, -20),
          rotation: 0,
          fingerBends: [0, 0, 0, 0, 0],
          fingerSpreads: [0.3, 0.3, 0.3, 0.3],
        ),
        HandPosition(
          position: Offset(60, -30),
          rotation: math.pi / 6,
          fingerBends: [0, 0, 0, 0, 0],
          fingerSpreads: [0.3, 0.3, 0.3, 0.3],
        ),
      ],
      leftHandPositions: [
        HandPosition(
          position: Offset(-60, 0),
          rotation: 0,
          fingerBends: [0, 0, 0, 0, 0],
          fingerSpreads: [0, 0, 0, 0],
        ),
      ],
    ),
    'thank you': SignGesture(
      rightHandPositions: [
        HandPosition(
          position: Offset(0, -20),
          rotation: 0,
          fingerBends: [0, 0, 0, 0, 0], // Flat hand
          fingerSpreads: [0, 0, 0, 0],
        ),
        HandPosition(
          position: Offset(0, -40),
          rotation: -math.pi / 4,
          fingerBends: [0, 0, 0, 0, 0],
          fingerSpreads: [0, 0, 0, 0],
        ),
      ],
      leftHandPositions: [
        HandPosition(
          position: Offset(-60, 0),
          rotation: 0,
          fingerBends: [0, 0, 0, 0, 0],
          fingerSpreads: [0, 0, 0, 0],
        ),
      ],
    ),
    'please': SignGesture(
      rightHandPositions: [
        HandPosition(
          position: Offset(20, -20),
          rotation: 0,
          fingerBends: [0, 0, 0, 0, 0], // Flat hand
          fingerSpreads: [0, 0, 0, 0],
        ),
        HandPosition(
          position: Offset(20, -20),
          rotation: math.pi / 2,
          fingerBends: [0, 0, 0, 0, 0],
          fingerSpreads: [0, 0, 0, 0],
        ),
      ],
      leftHandPositions: [
        HandPosition(
          position: Offset(-20, -20),
          rotation: 0,
          fingerBends: [0, 0, 0, 0, 0],
          fingerSpreads: [0, 0, 0, 0],
        ),
      ],
    ),
    'yes': SignGesture(
      rightHandPositions: [
        HandPosition(
          position: Offset(0, -30),
          rotation: 0,
          fingerBends: [1, 1, 1, 1, 1], // Fist
          fingerSpreads: [0, 0, 0, 0],
        ),
        HandPosition(
          position: Offset(0, 0),
          rotation: 0,
          fingerBends: [1, 1, 1, 1, 1],
          fingerSpreads: [0, 0, 0, 0],
        ),
      ],
      leftHandPositions: [
        HandPosition(
          position: Offset(-60, 0),
          rotation: 0,
          fingerBends: [0, 0, 0, 0, 0],
          fingerSpreads: [0, 0, 0, 0],
        ),
      ],
    ),
    'no': SignGesture(
      rightHandPositions: [
        HandPosition(
          position: Offset(20, -20),
          rotation: 0,
          fingerBends: [0, 1, 1, 1, 0], // Index and thumb extended
          fingerSpreads: [0.5, 0, 0, 0],
        ),
        HandPosition(
          position: Offset(-20, -20),
          rotation: 0,
          fingerBends: [0, 1, 1, 1, 0],
          fingerSpreads: [0.5, 0, 0, 0],
        ),
      ],
      leftHandPositions: [
        HandPosition(
          position: Offset(-60, 0),
          rotation: 0,
          fingerBends: [0, 0, 0, 0, 0],
          fingerSpreads: [0, 0, 0, 0],
        ),
      ],
    ),
    'good': SignGesture(
      rightHandPositions: [
        HandPosition(
          position: Offset(0, -30),
          rotation: 0,
          fingerBends: [0, 0, 0, 0, 0], // Flat hand
          fingerSpreads: [0, 0, 0, 0],
        ),
        HandPosition(
          position: Offset(0, -10),
          rotation: 0,
          fingerBends: [0, 0, 0, 0, 0],
          fingerSpreads: [0, 0, 0, 0],
        ),
      ],
      leftHandPositions: [
        HandPosition(
          position: Offset(-60, 0),
          rotation: 0,
          fingerBends: [0, 0, 0, 0, 0],
          fingerSpreads: [0, 0, 0, 0],
        ),
      ],
    ),
    'bad': SignGesture(
      rightHandPositions: [
        HandPosition(
          position: Offset(0, -30),
          rotation: math.pi,
          fingerBends: [0, 0, 0, 0, 0], // Flat hand pointing down
          fingerSpreads: [0, 0, 0, 0],
        ),
        HandPosition(
          position: Offset(0, -10),
          rotation: math.pi,
          fingerBends: [0, 0, 0, 0, 0],
          fingerSpreads: [0, 0, 0, 0],
        ),
      ],
      leftHandPositions: [
        HandPosition(
          position: Offset(-60, 0),
          rotation: 0,
          fingerBends: [0, 0, 0, 0, 0],
          fingerSpreads: [0, 0, 0, 0],
        ),
      ],
    ),
    'name': SignGesture(
      rightHandPositions: [
        HandPosition(
          position: Offset(20, -20),
          rotation: -math.pi / 4,
          fingerBends: [0, 1, 1, 1, 0], // Index and thumb extended
          fingerSpreads: [0.5, 0, 0, 0],
        ),
        HandPosition(
          position: Offset(-20, -20),
          rotation: -math.pi / 4,
          fingerBends: [0, 1, 1, 1, 0],
          fingerSpreads: [0.5, 0, 0, 0],
        ),
      ],
      leftHandPositions: [
        HandPosition(
          position: Offset(-60, 0),
          rotation: 0,
          fingerBends: [0, 0, 0, 0, 0],
          fingerSpreads: [0, 0, 0, 0],
        ),
      ],
    ),
    'help': SignGesture(
      rightHandPositions: [
        HandPosition(
          position: Offset(20, -20),
          rotation: 0,
          fingerBends: [0, 0, 0, 0, 0], // Flat hand
          fingerSpreads: [0, 0, 0, 0],
        ),
      ],
      leftHandPositions: [
        HandPosition(
          position: Offset(-20, -20),
          rotation: 0,
          fingerBends: [1, 1, 1, 1, 1], // Fist
          fingerSpreads: [0, 0, 0, 0],
        ),
        HandPosition(
          position: Offset(-20, 0),
          rotation: 0,
          fingerBends: [1, 1, 1, 1, 1],
          fingerSpreads: [0, 0, 0, 0],
        ),
      ],
    ),
  };

  // Numbers 0-9
  static final Map<String, SignGesture> numbers = {
    '0': SignGesture(
      rightHandPositions: [
        HandPosition(
          position: Offset(20, -20),
          rotation: 0,
          fingerBends: [0.5, 0.5, 0.5, 0.5, 0.5], // O shape
          fingerSpreads: [0.2, 0.2, 0.2, 0.2],
        ),
      ],
      leftHandPositions: [
        HandPosition(
          position: Offset(-60, 0),
          rotation: 0,
          fingerBends: [0, 0, 0, 0, 0],
          fingerSpreads: [0, 0, 0, 0],
        ),
      ],
    ),
    '1': SignGesture(
      rightHandPositions: [
        HandPosition(
          position: Offset(20, -20),
          rotation: 0,
          fingerBends: [1, 0, 1, 1, 1], // Index finger
          fingerSpreads: [0, 0, 0, 0],
        ),
      ],
      leftHandPositions: [
        HandPosition(
          position: Offset(-60, 0),
          rotation: 0,
          fingerBends: [0, 0, 0, 0, 0],
          fingerSpreads: [0, 0, 0, 0],
        ),
      ],
    ),
    '2': SignGesture(
      rightHandPositions: [
        HandPosition(
          position: Offset(20, -20),
          rotation: 0,
          fingerBends: [1, 0, 0, 1, 1], // V shape
          fingerSpreads: [0, 0.5, 0, 0],
        ),
      ],
      leftHandPositions: [
        HandPosition(
          position: Offset(-60, 0),
          rotation: 0,
          fingerBends: [0, 0, 0, 0, 0],
          fingerSpreads: [0, 0, 0, 0],
        ),
      ],
    ),
    '3': SignGesture(
      rightHandPositions: [
        HandPosition(
          position: Offset(20, -20),
          rotation: 0,
          fingerBends: [1, 0, 0, 0, 1], // Three fingers
          fingerSpreads: [0, 0.3, 0.3, 0],
        ),
      ],
      leftHandPositions: [
        HandPosition(
          position: Offset(-60, 0),
          rotation: 0,
          fingerBends: [0, 0, 0, 0, 0],
          fingerSpreads: [0, 0, 0, 0],
        ),
      ],
    ),
    '4': SignGesture(
      rightHandPositions: [
        HandPosition(
          position: Offset(20, -20),
          rotation: 0,
          fingerBends: [1, 0, 0, 0, 0], // Four fingers
          fingerSpreads: [0, 0.2, 0.2, 0.2],
        ),
      ],
      leftHandPositions: [
        HandPosition(
          position: Offset(-60, 0),
          rotation: 0,
          fingerBends: [0, 0, 0, 0, 0],
          fingerSpreads: [0, 0, 0, 0],
        ),
      ],
    ),
    '5': SignGesture(
      rightHandPositions: [
        HandPosition(
          position: Offset(20, -20),
          rotation: 0,
          fingerBends: [0, 0, 0, 0, 0], // Open hand
          fingerSpreads: [0.2, 0.2, 0.2, 0.2],
        ),
      ],
      leftHandPositions: [
        HandPosition(
          position: Offset(-60, 0),
          rotation: 0,
          fingerBends: [0, 0, 0, 0, 0],
          fingerSpreads: [0, 0, 0, 0],
        ),
      ],
    ),
  };

  static SignGesture getGestureForWord(String word) {
    word = word.toLowerCase();
    
    // Check if it's a number
    if (numbers.containsKey(word)) {
      return numbers[word]!;
    }

    // Check if it's a known word
    if (alphabet.containsKey(word)) {
      return alphabet[word]!;
    }

    // Default gesture if word is not found
    return SignGesture(
      rightHandPositions: [
        HandPosition(
          position: Offset(20, -20),
          rotation: 0,
          fingerBends: [0, 0, 0, 0, 0],
          fingerSpreads: [0, 0, 0, 0],
        ),
      ],
      leftHandPositions: [
        HandPosition(
          position: Offset(-60, 0),
          rotation: 0,
          fingerBends: [0, 0, 0, 0, 0],
          fingerSpreads: [0, 0, 0, 0],
        ),
      ],
      duration: 1.0,
    );
  }
} 