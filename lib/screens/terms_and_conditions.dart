import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});
  final String termsAndConditionsText = '''
1. **Objet**  
   Ces termes et conditions régissent l’utilisation de notre application visant à améliorer la communication entre 
   les personnes entendantes, aveugles et muettes.

2. **Utilisation de l’application**  
   - L’application est destinée à un usage éducatif et de communication.  
   - L’utilisateur s’engage à ne pas utiliser l’application à des fins illégales ou nuisibles.  

3. **Confidentialité**  
   - Nous respectons la vie privée des utilisateurs et ne collectons que les données strictement nécessaires au bon 
     fonctionnement de l’application.  

4. **Responsabilité**  
   - Nous nous efforçons de fournir une application fiable, mais nous ne garantissons pas l’absence d’éventuels 
     dysfonctionnements.  
   - Les développeurs ne peuvent être tenus responsables d’une mauvaise utilisation de l’application.

5. **Modifications**  
   - Nous nous réservons le droit de modifier ces termes et conditions à tout moment.
''';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Terms And Conditions  ', style: TextStyle(fontSize: 28)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.00),
          child: Column(
            children: [
              Title(
                color: Colors.black,
                child: Text(
                  termsAndConditionsText,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
