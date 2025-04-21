import 'package:projet_signe/Models/Message.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_tts/flutter_tts.dart';
import 'package:projet_signe/service/api_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Message> _message = [];
  final ApiService apiService = ApiService();

  FlutterTts flutterTts = FlutterTts();
  bool _isTtsEnabled = true;
  String _selectedLanguage = 'fr-FR';

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  void _initTts() async {
    await flutterTts.setLanguage(_selectedLanguage);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(1.0);
  }

  Future<void> _speak(String text) async {
    if (_isTtsEnabled && text.isNotEmpty) {
      await flutterTts.speak(text);
    }
  }

  void _toggleTts() {
    setState(() {
      _isTtsEnabled = !_isTtsEnabled;
    });
    if (!_isTtsEnabled) {
      flutterTts.stop();
    } else {
      if (_message.isNotEmpty && _message.last.isBotMessage) {
        _speak(_message.last.text);
      }
    }
  }

  // envoie un message à l'API et affiche la réponse du bot
  void _sendMessage() async {
    String message = _controller.text.trim();
    if (message.isEmpty) return;

    setState(() {
      //ajout du message utilisateur a la liste des messages
      _message.add(Message(text: message, isUserMessage: true));
      // points de suspension en attendant la réponse
      _message.add(Message(text: "...", isUserMessage: false));
      _controller.clear();
    });

    FocusScope.of(context).unfocus();

    String botResponse;
    try {
      botResponse = await apiService.getChatResponse(message);
    } catch (e) {
      botResponse = "Erreur lors de la récupération de la réponse";
    }

    await Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _message.removeLast();
        _message.add(Message(text: botResponse, isUserMessage: false));
      });
      _controller.clear();
    }); // Future.delayed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("AI Chat Bot")),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 15, 39, 252), // Bleu intense
                Color.fromARGB(255, 0, 191, 255), // Bleu clair
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text("AI Chat Bot", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: _toggleTts,
            icon: Icon(
              _isTtsEnabled ? Icons.volume_up : Icons.volume_off,
              color: Colors.white,
            ),
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.language),
            onSelected: (String lang) {
              setState(() {
                _selectedLanguage = lang;
                _initTts();
              });
            },
            itemBuilder:
                (BuildContext context) => [
                  PopupMenuItem(value: 'fr-FR', child: Text('Français')),
                  PopupMenuItem(value: 'en-US', child: Text('English')),
                  PopupMenuItem(
                    value: 'ar-AR',
                    child: Text('Arabe(simplified)'),
                  ),
                  PopupMenuItem(value: 'es-ES', child: Text('Espagnol')),
                  PopupMenuItem(
                    value: 'zh-CN',
                    child: Text('Chinois(Simplified)'),
                  ),
                ],
          ),
        ],

        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(
              context,
            ).pop(); // Retour à l'écran précédent (TranslationScreen)
          },
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _message.length,
              itemBuilder: (context, index) {
                final msg = _message[index];
                final isUser = msg.isUserMessage;
                final avatar = CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(
                    isUser ? 'images/edf.PNG' : 'images/chat.png',
                  ),
                );

                final messageText = Text(msg.text);
                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment:
                        isUser
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isUser) avatar,
                      SizedBox(width: 5),
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isUser ? Colors.blue : Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: messageText,
                        ),
                      ),
                      if (isUser) ...[SizedBox(width: 5), avatar],
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Entrez votre message",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.send, color: Colors.blue),
                          onPressed: _sendMessage,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /*Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Entrez votre message",
                      suffix:IconButton(
                        icon: Icon(Icons.send),
                        onPressed: _sendMessage,
                      ),
                    ),
                  ),
                ),
                
              ],
            ),
            ),*/
        ],
      ),
    );
  }
}
