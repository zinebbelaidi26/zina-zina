import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class VerificationScreen extends StatefulWidget {
  final String phoneNumber;
  const VerificationScreen({super.key, required this.phoneNumber});
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final List _otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List _focusNodes = List.generate(6, (index) => FocusNode());
  int _remainingSeconds = 120;
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    _timer.cancel();
    super.dispose();
  }

  void _submit() {
    String otp = _otpControllers.map((c) => c.text).join();
    if (otp.length == 6) {
      Navigator.pop(context);
    }
  }

  void _fieldFocusChange(BuildContext context, int index) {
    if (index < 5 && _otpControllers[index].text.isNotEmpty) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Verification',
          style: TextStyle(
            color: Color.fromARGB(255, 184, 177, 177),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 240, 242, 247),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              height: 150,
              margin: const EdgeInsets.only(bottom: 20),

              child: Image.asset(
                'images/verifier.PNG',
                height: 150,
                width: 1500,
              ),
            ),

            const SizedBox(height: 30),
            const Text(
              'OTP VERIFICATION',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Text(
              'Enter the OTP sent to ${widget.phoneNumber} ',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 45,
                  child: TextFormField(
                    controller: _otpControllers[index],
                    focusNode: _focusNodes[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        _fieldFocusChange(context, index);
                      }
                    },
                  ),
                );
              }),
            ),
            const SizedBox(height: 30),
            Text(
              '${(_remainingSeconds ~/ 60).toString().padLeft(2, '0')}:'
              '${(_remainingSeconds % 60).toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't receive code? ",
                  style: TextStyle(color: Colors.grey),
                ),
                TextButton(
                  onPressed:
                      _remainingSeconds == 0
                          ? () {
                            setState(() => _remainingSeconds = 120);
                            _startTimer();
                          }
                          : null,
                  child: const Text(
                    'Re-send',

                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 100,
                  vertical: 15,
                ),
              ),
              onPressed: _submit,
              child: const Text('Submit', style: TextStyle(fontSize: 25)),
            ),
          ],
        ),
      ),
    );
  }
}
