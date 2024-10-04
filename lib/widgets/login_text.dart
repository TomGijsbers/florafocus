// import 'package:flutter/material.dart'; // Importeer de Flutter-material design bibliotheek

// class LoginTextField extends StatelessWidget {
//   final String label; // Label voor het tekstveld
//   final bool
//       obscureText; // Bepaalt of de tekst verborgen moet worden (voor wachtwoorden)

//   // Constructor voor de LoginTextField widget
//   const LoginTextField({
//     required this.label, // Label is verplicht
//     this.obscureText = false, // Standaardwaarde voor obscureText is false
//     Key? key, // Sleutel voor widget identificatie (optioneel)
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Bouw de UI van het LoginTextField
//     return TextField(
//       // Een invoerveld voor tekstinvoer
//       decoration: InputDecoration(
//         labelText: label, // Zet het label als de tekstlabel van het invoerveld
//         border: OutlineInputBorder(
//           // Voeg een omtrek toe aan het invoerveld
//           borderRadius: BorderRadius.circular(10), // Afgeronde hoeken
//         ),
//         filled: true, // Maak het invoerveld gevuld
//         fillColor: Colors.white, // Achtergrondkleur van het invoerveld
//       ),
//       obscureText:
//           obscureText, // Gebruik de obscureText waarde om te bepalen of de tekst verborgen moet worden
//     );
//   }
// }

// API Service
import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final TextEditingController controller; // Voeg de controller toe

  const LoginTextField({
    required this.label,
    this.obscureText = false,
    required this.controller, // Maak de controller verplicht
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, // Gebruik de controller in het invoerveld
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      obscureText: obscureText,
    );
  }
}
