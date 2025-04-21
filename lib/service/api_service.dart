import 'package:google_generative_ai/google_generative_ai.dart';

class ApiService {
  static const String apiKey = "AIzaSyBJH8LNTGVF_4pNPqWqqG4ifbQZOEokkdQ";

  final model = GenerativeModel(model: 'gemini-2.0-flash', apiKey: apiKey);

  Future<String> getChatResponse(String userMessage) async {
    try {
      final content = [Content.text(userMessage)];
      final response = await model.generateContent(content);
      if (response.text != null && response.text!.isNotEmpty) {
        return response.text!;
      } else {
        return "L'IA n'a pas pu generer la réponse Reessaie.";
      }
    } catch (e) {
      if (e is GenerativeAIException) {
        return "Erreur de l'API:${e.message}";
      } else {
        return " erreur inattendue.vérifie la connexion";
      }
    }
  }
}
























