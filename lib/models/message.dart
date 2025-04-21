class Message {
  final String text;
  final bool isUserMessage;

  Message({this.text = '', this.isUserMessage = false});

  bool get isBotMessage => !isUserMessage;
}
