import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Import pour kDebugMode
import 'package:projet_signe/screens/animation.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

void main() => runApp(const NewRecordingApp());

class NewRecordingApp extends StatelessWidget {
  const NewRecordingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const NewRecordingScreen(),
    );
  }
}

class NewRecordingScreen extends StatefulWidget {
  const NewRecordingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NewRecordingScreenState createState() => _NewRecordingScreenState();
}

class _NewRecordingScreenState extends State<NewRecordingScreen> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _recognizedText = '';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _initializeSpeech();
  }

  void _initializeSpeech() async {
    try {
      bool available = await _speech.initialize(
        onStatus: (status) {
          if (kDebugMode) {
            print('Speech status: $status');
          }
          if (status == 'notListening' && _isListening) {
            setState(() => _isListening = false);
          }
        },
        onError: (error) {
          if (kDebugMode) {
            print('Speech error: $error');
          }
          setState(() {
            _isListening = false;
            _recognizedText = 'Error: $error';
          });
        },
      );
      
      if (!available) {
        if (kDebugMode) {
          print('Speech recognition not available');
        }
        setState(() {
          _recognizedText = 'Speech recognition not available on this device';
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing speech: $e');
      }
      setState(() {
        _recognizedText = 'Error initializing speech recognition';
      });
    }
  }

  void _listen() async {
    try {
      if (!_isListening) {
        bool available = await _speech.initialize();
        if (available) {
          setState(() => _isListening = true);
          _speech.listen(
            onResult: (result) {
              setState(() {
                _recognizedText = result.recognizedWords;
              });
            },
            listenFor: const Duration(seconds: 30),
            pauseFor: const Duration(seconds: 3),
            partialResults: true,
            localeId: 'en-US',
            cancelOnError: true,
            listenMode: stt.ListenMode.confirmation,
          );
        } else {
          setState(() {
            _recognizedText = 'Speech recognition not available';
          });
        }
      } else {
        setState(() => _isListening = false);
        _speech.stop();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error during speech recognition: $e');
      }
      setState(() {
        _isListening = false;
        _recognizedText = 'Error during speech recognition';
      });
    }
  }

  void _resetText() {
    setState(() {
      _recognizedText = '';
      if (_isListening) {
        _isListening = false;
        _speech.stop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        //leading: const BackButton(color: Colors.black),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {}, // <- Le bouton ne fait rien
        ),
        title: const Text(
          'New Recording',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Text container
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Text:',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _recognizedText.isEmpty
                        ? "this interface converts spoken word\ninto written text"
                        : _recognizedText,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Wave visualization
                  CustomPaint(
                    size: const Size(double.infinity, 50),
                    painter: WavePainter(isActive: _isListening),
                  ),
                  const SizedBox(height: 20),
                  // Microphone button with circle controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Emoji button
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.emoji_emotions_outlined,
                            color: Colors.blue,
                            size: 20,
                          ),
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 24),
                      // Main microphone button
                      GestureDetector(
                        onTap: _listen,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withAlpha(
                                  (0.3 * 255).toInt(),
                                ), // Updated
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            _isListening ? Icons.mic_off : Icons.mic,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      // Cancel button
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Colors.red,
                            size: 20,
                          ),
                          padding: EdgeInsets.zero,
                          onPressed: _resetText,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Start/Stop Recording text
                  Text(
                    _isListening ? 'Stop Recording' : 'Start Recording',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Translate button
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    if (_recognizedText.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  MainScreen(translatedText: _recognizedText),
                        ),
                      );
                    }

                    // Ajouter logique de traduction ici
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: Text(
                        'Translate',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom painter for the wave visualization
class WavePainter extends CustomPainter {
  final bool isActive;

  WavePainter({this.isActive = false});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color =
              isActive
                  ? Colors.black
                  : Colors.black.withAlpha((0.3 * 255).toInt()) // Updated
          ..style = PaintingStyle.stroke
          ..strokeWidth = isActive ? 2.5 : 1.5;

    final path = Path();
    final width = size.width;
    final height = size.height;

    path.moveTo(0, height * 0.5);

    // Créer un motif d'onde plus dynamique quand actif
    for (double i = 0; i < width; i += 10) {
      final factor = isActive ? (i % 30) / 15 : (i % 20) / 20;
      final amplitude =
          isActive
              ? (i > width * 0.3 && i < width * 0.7 ? 20.0 : 8.0)
              : (i > width * 0.3 && i < width * 0.7 ? 12.0 : 4.0);

      final y =
          height * 0.5 +
          amplitude * ((factor > 1.0 ? 2.0 - factor : factor) * 2 - 1);
      path.lineTo(i, y);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant WavePainter oldDelegate) =>
      oldDelegate.isActive != isActive;
}
