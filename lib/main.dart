import 'package:flutter/material.dart';
import 'package:projet_signe/screens/Mycours.dart';
import 'package:projet_signe/screens/Quizz.dart';
// ignore: unused_import
import 'package:projet_signe/screens/SettingsScreen.dart';
import 'package:projet_signe/screens/about_us.dart';
import 'package:projet_signe/screens/alphabet_cour.dart';
import 'package:projet_signe/screens/animation.dart';
import 'package:projet_signe/screens/change_password_page.dart';
import 'package:projet_signe/screens/chatboot.dart';
import 'package:projet_signe/screens/days.dart';
import 'package:projet_signe/screens/edit_profile.dart';
import 'package:projet_signe/screens/forget_passwored.dart';
import 'package:projet_signe/screens/homme_coures.dart';
import 'package:projet_signe/screens/nomber.dart';
import 'package:projet_signe/screens/start_cour.dart';
import 'package:projet_signe/screens/terms_and_conditions.dart';
import 'package:projet_signe/screens/text.dart';
import 'package:projet_signe/screens/verification.dart';
import 'package:projet_signe/screens/voice.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:projet_signe/theme/app_theme.dart';
import 'screens/profile_screen.dart';
import 'screens/Log_in.dart';
import 'screens/sing_up.dart';
import 'screens/first_page.dart';
import 'screens/seconed_page.dart';
import 'screens/select_user.dart';
import 'screens/select.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://rpdvzbdycjhetwfcqhzj.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJwZHZ6YmR5Y2poZXR3ZmNxaHpqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDE0NjIwMzksImV4cCI6MjA1NzAzODAzOX0.uLXYVTaRB_D8oWi4ifLjdbucOy8PF5qIsWYfG8ork3g',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const FirstPage(),
        '/auth': (context) => const SecondPage(),
        '/login': (context) => const LogIn(),
        '/signup': (context) => const SignUp(),
        '/main': (context) => const MainNavigation(),
        '/profile': (context) => const ProfileScreen(username: 'belaidi', email: 'zineb@gmail.com'),
        '/settings': (context) => const SettingsScreen(),
        '/about': (context) => const AboutUs(),
        '/terms': (context) => const TermsAndConditions(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/verify': (context) => const VerificationScreen(phoneNumber: '0670898760'),
        '/selectuser': (context) => const SelectUserTypeScreen(),
        '/select': (context) => const InputModeSelectionScreen(),
        '/voice': (context) => const NewRecordingScreen(),
        '/animation': (context) => const MainScreen(translatedText: 'taxt'),
        '/text': (context) => const TranslationScreen(),
        '/start': (context) => const WelcomeScreen(),
        '/homme': (context) => const HomeScreen(),
        '/coures': (context) => const MyCoursesScreen(),
        '/start_page_quizz': (context) => const StartPage(),
        '/quizz': (context) => const QuizPage(),
        '/changhe': (context) => const ChangePasswordPage(),
        '/alpha': (context) => const AlphabetCour(),
        '/day': (context) => const SignLanguageDays(),
        '/chat': (context) => const ChatScreen(),
        '/nomber': (context) => const NumbersPage(),
      },
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(), // Learning content
    const MyCoursesScreen(), // My courses
    const ChatScreen(), // Chat/Help
    const ProfileScreen(username: 'belaidi', email: 'zineb@gmail.com'), // Profile
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Learn',
          ),
          NavigationDestination(
            icon: Icon(Icons.school_outlined),
            selectedIcon: Icon(Icons.school),
            label: 'My Courses',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_outlined),
            selectedIcon: Icon(Icons.chat),
            label: 'Help',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
