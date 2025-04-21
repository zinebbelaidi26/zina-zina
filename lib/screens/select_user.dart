import 'dart:async';
import 'package:flutter/material.dart';

class SelectUserTypeScreen extends StatefulWidget {
  const SelectUserTypeScreen({super.key});

  @override
  _SelectUserTypeScreenState createState() => _SelectUserTypeScreenState();
}

class _SelectUserTypeScreenState extends State<SelectUserTypeScreen> {
  int selectedIndex = -1;
  bool isFirstColor = true;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        isFirstColor = !isFirstColor;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(seconds: 3),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors:
                isFirstColor
                    ? [
                      const Color.fromARGB(255, 6, 26, 207),
                      const Color.fromRGBO(255, 255, 255, 1),
                    ]
                    : [
                      const Color.fromRGBO(255, 255, 255, 1),
                      const Color.fromARGB(255, 6, 26, 207),
                    ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  "Select User Type",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  padding: const EdgeInsets.all(16),
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.8,
                  children: List.generate(4, (index) {
                    return UserOptionCard(
                      title:
                          index == 0
                              ? "I am a regular user"
                              : index == 1
                              ? "For Deaf and Mute people"
                              : index == 2
                              ? "Learn sign language"
                              : "Chat with SignBot",
                      image:
                          index == 0
                              ? "images/jhgvc.PNG"
                              : index == 1
                              ? "images/zin.jpg"
                              : index == 2
                              ? "images/zina.jpg"
                              : "images/CHAT.jpeg",
                      isSelected: selectedIndex == index,
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });

                        // Navigation based on selection
                        switch (index) {
                          case 0:
                            Navigator.pushNamed(context, '/select');
                            break;
                          case 1:
                            Navigator.pushNamed(context, '/select');
                            break;
                          case 2:
                            Navigator.pushNamed(context, '/start');
                            break;
                          case 3:
                            Navigator.pushNamed(context, '/chat');
                            break;
                        }
                      },
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserOptionCard extends StatelessWidget {
  final String title;
  final String image;
  final bool isSelected;
  final VoidCallback onTap;

  const UserOptionCard({
    required this.title,
    required this.image,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
            colorFilter:
                isSelected
                    ? null
                    : ColorFilter.mode(
                      Colors.black.withOpacity(0.5),
                      BlendMode.darken,
                    ),
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 10,
                spreadRadius: 2,
              ),
          ],
        ),
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
