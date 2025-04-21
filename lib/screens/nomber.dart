import 'package:flutter/material.dart';

class NumbersPage extends StatelessWidget {
  static const List<String> numbersList = [
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
  ];

  const NumbersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Language Numbers")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: numbersList.length,
          itemBuilder: (context, index) {
            String number = numbersList[index];
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Colors.blueAccent),
                ),
              ),
              onPressed: () => _showSignDialog(context, number),
              child: Text(
                number,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showSignDialog(BuildContext context, String number) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('number $number'),
        content: Image.asset('assets/days/$number.png', fit: BoxFit.cover),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("closing"),
          ),
        ],
      ),
    );
  }
}
