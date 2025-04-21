import 'package:flutter/material.dart';
// ignore: unused_import
import 'homme_coures.dart';

class MyCoursesScreen extends StatelessWidget {
  const MyCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My Courses',
          style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.purple),
      ),
      backgroundColor: const Color.fromARGB(255, 193, 110, 209),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCourseItemWithImage(
              context,
              title: 'Every day Communication Signs',
              progress: 0.6,
              imagePath: 'images/n.PNG',
              imageOnLeft: false,
              onTap: () {
                Navigator.of(context).pushNamed('/day');
              },
            ),
            const SizedBox(height: 20),
            _buildCourseItemWithImage(
              context,
              title: 'nomber Sign Language Sentences',
              progress: 0.3,
              imagePath: 'images/ko.PNG',
              imageOnLeft: true,
              onTap: () {
                Navigator.of(context).pushNamed('/nomber');
              },
            ),
            const SizedBox(height: 20),
            _buildCourseItemWithImage(
              context,
              title: 'Sign Language Alphabet',
              progress: 0.9,
              imagePath: 'images/sf.PNG',
              imageOnLeft: false,
              onTap: () {
                Navigator.of(context).pushNamed('/alpha');
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavButton(
              Icons.home_filled,
              'Home',
              isActive: true,
              onPressed: () => Navigator.pop(context), // Back to home screen
            ),
            _buildNavButton(
              Icons.quiz,
              'Quiz',
              onPressed: () {
                // Add navigation to Quiz screen here
              },
            ),
            _buildNavButton(
              Icons.text_fields,
              'Aa',
              onPressed: () {
                // Add Aa button actions here
              },
            ),
            _buildNavButton(
              Icons.person,
              'Profile',
              onPressed: () {
                // Add navigation to Profile screen here
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseItemWithImage(
    BuildContext context, {
    required String title,
    required double progress,
    required String imagePath,
    required VoidCallback onTap,
    required bool imageOnLeft,
  }) {
    final imageWidget = ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset(imagePath, width: 60, height: 60, fit: BoxFit.cover),
    );

    final textContent = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[200],
            color: Colors.purple,
          ),
          const SizedBox(height: 5),
          Text('Completed ${(progress * 100).toInt()}%'),
        ],
      ),
    );

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5),
          ],
        ),
        child: Row(
          children:
              imageOnLeft
                  ? [imageWidget, const SizedBox(width: 16), textContent]
                  : [textContent, const SizedBox(width: 16), imageWidget],
        ),
      ),
    );
  }

  Widget _buildNavButton(
    IconData icon,
    String label, {
    bool isActive = false,
    VoidCallback? onPressed,
  }) {
    return IconButton(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isActive ? Colors.purple : Colors.grey),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.purple : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
      onPressed: onPressed,
    );
  }
}
