import 'package:flutter/material.dart';

class AlphabetCour extends StatelessWidget {
  static const List<String> alphabetList = [
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
    'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
  ];

  const AlphabetCour({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Alphabets")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: alphabetList.length,
          itemBuilder: (context, index) {
            String letter = alphabetList[index];
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Colors.redAccent),
                ),
              ),
              onPressed: () => _showSignDialog(context, letter),
              child: Text(
                letter,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showSignDialog(BuildContext context, String letter) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Lettre $letter'),
        content: Image.asset(
          'assets/alphabets/$letter.png',
          fit: BoxFit.cover,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Fermer"),
          ),
        ],
      ),
    );
  }
}
