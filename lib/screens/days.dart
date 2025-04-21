import 'package:flutter/material.dart';

class SignLanguageDays extends StatelessWidget {
  static const Map<String, String> dayImages = {
    'Monday': 'images/monday1.jpg',
    'Tuesday': 'images/tusday.PNG',
    'Wednesday': 'images/wedensday.PNG',
    'Thursday': 'images/thursday.PNG',
    'Friday': 'images/friday.jpg',
    'Saturday': 'images/saturday.jpg',
    'Sunday': 'images/sunday1.png',
  };

  const SignLanguageDays({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Jours de la semaine")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: dayImages.length,
          itemBuilder: (context, index) {
            String day = dayImages.keys.elementAt(index);
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Colors.blueAccent),
                ),
              ),
              onPressed: () => _showDayDialog(context, dayImages[day]!, day),
              child: Text(
                day,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showDayDialog(BuildContext context, String imagePath, String day) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Jour : $day'),
        content: Image.asset(imagePath, fit: BoxFit.cover),
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
