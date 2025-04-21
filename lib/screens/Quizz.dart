import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const Color dark1 = Color(0xFF0F2EA8);
const Color dark2 = Color(0xFF133FCC);
const Color original = Color(0xFF1649F1);
const Color light1 = Color(0xFF4F77F6);
const Color light2 = Color(0xFFAFC7FF);
const Color yellowTitle = Color(0xFFFFD700);

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [light2, light1, original, dark2, dark1],
            stops: const [0.1, 0.3, 0.5, 0.7, 0.9],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Introduction",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Quiz Sign Language",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: yellowTitle,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "PLAYING THE GAME AND LEARN",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 100),
              Image.asset('images/PLAY.jpeg', height: 450),
              const SizedBox(height: 100),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const QuizPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "START PLAYING",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Question {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String image;

  Question({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.image,
  });
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestion = 0;
  int selectedIndex = -1;
  bool showResult = false;
  int score = 0;

  final List<Question> questions = [
    Question(
      question: 'What does this sign mean?',
      options: ['a) yes', 'b) NO', 'c) I love you'],
      correctIndex: 0,
      image: 'images/yes.jpeg',
    ),
    Question(
      question: 'What does this sign mean?',
      options: ['a) Good morning', 'b) Good by', 'c) I love you'],
      correctIndex: 0,
      image: 'images/q2.png',
    ),
    Question(
      question: 'What does this sign mean?',
      options: ['a) hello', 'b) you', 'c) dad'],
      correctIndex: 2,
      image: 'images/dad.gif',
    ),
    Question(
      question: 'What does this sign mean?',
      options: ['a) go', 'b) mam', 'c) by'],
      correctIndex: 1,
      image: 'images/MAM.jpeg',
    ),
    Question(
      question: 'What does this sign mean?',
      options: ['a) help', 'b) good', 'c) yes'],
      correctIndex: 0,
      image: 'images/help.webp',
    ),
    Question(
      question: 'What does this sign mean?',
      options: ['a) hi', 'b) go', 'c) thanks'],
      correctIndex: 2,
      image: 'images/THANK.jpeg',
    ),
    Question(
      question: 'What does this sign mean?',
      options: ['a) by', 'b) dont_like', 'c) like'],
      correctIndex: 1,
      image: 'images/dont_like.gif',
    ),
    Question(
      question: 'What does this sign mean?',
      options: ['a) big', 'b) what', 'c) small'],
      correctIndex: 0,
      image: 'images/OIP (1).jpeg',
    ),
    Question(
      question: 'What does this sign mean?',
      options: ['a) good', 'b) plaise', 'c) No'],
      correctIndex: 1,
      image: 'images/plaise.png',
    ),
  ];

  Future<void> saveScore(String userId, int score) async {
    final supabase = Supabase.instance.client;

    final response = await supabase.from('scores').insert({
      'user_id': userId,
      'score': score,
      'created_at': DateTime.now().toIso8601String(),
    });

    if (response.error != null) {
      print('❌ Error saving score: ${response.error!.message}');
    } else {
      print('✅ Score saved successfully!');
    }
  }

  void onNext() {
    if (!showResult) {
      if (selectedIndex == questions[currentQuestion].correctIndex) {
        setState(() => score++);
      }
      setState(() => showResult = true);
    } else {
      if (currentQuestion < questions.length - 1) {
        setState(() {
          currentQuestion++;
          selectedIndex = -1;
          showResult = false;
        });
      } else {
        final userId = Supabase.instance.client.auth.currentUser?.id;
        saveScore(userId ?? 'guest', score);

        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                title: const Text("Quiz Finished!"),
                content: Text("Your score: $score/${questions.length}"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: const Text("OK"),
                  ),
                ],
              ),
        );
      }
    }
  }

  Color getBorderColor(int index) {
    if (!showResult) return Colors.grey;

    if (index == questions[currentQuestion].correctIndex) {
      return Colors.green;
    }

    if (index == selectedIndex &&
        selectedIndex != questions[currentQuestion].correctIndex) {
      return Colors.red;
    }

    return Colors.grey;
  }

  Widget buildOption(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: getBorderColor(index), width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: RadioListTile<int>(
        title: Text(
          questions[currentQuestion].options[index],
          style: TextStyle(
            color:
                showResult && index == questions[currentQuestion].correctIndex
                    ? Colors.green
                    : null,
            fontWeight:
                showResult && index == questions[currentQuestion].correctIndex
                    ? FontWeight.bold
                    : null,
          ),
        ),
        value: index,
        groupValue: selectedIndex,
        onChanged: (value) {
          if (!showResult) {
            setState(() => selectedIndex = value!);
          }
        },
        activeColor: original,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestion];

    return Scaffold(
      backgroundColor: const Color(0xFFFDF3E7),
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: Padding(
            key: ValueKey(currentQuestion),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: original,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "Score: $score/${questions.length}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: original, width: 2),
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          question.question,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Center(child: Image.asset(question.image, height: 150)),
                        const SizedBox(height: 12),
                        ...List.generate(question.options.length, buildOption),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: selectedIndex != -1 || showResult ? onNext : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: original,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    currentQuestion == questions.length - 1 && showResult
                        ? "Finish"
                        : "Next",
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
