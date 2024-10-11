import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final String label; // Het label van het invoerveld (bijv. 'Email')
  final bool
      obscureText; // Of de ingevoerde tekst verborgen moet zijn (bij wachtwoorden)
  final TextEditingController controller; // De controller die de invoer beheert

  const LoginTextField({
    required this.label, // Label is verplicht
    this.obscureText = false, // Standaard is de tekst niet verborgen
    required this.controller, // Controller is verplicht
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, // Controller voor het invoerveld
      decoration: InputDecoration(
        labelText: label, // Het label dat boven het veld wordt weergegeven
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(10), // Afgeronde hoeken van het veld
        ),
        filled: true, // Achtergrond invullen
        fillColor: Colors.white, // Kleur van het veld
      ),
      obscureText: obscureText, // Verberg de tekst als het wachtwoord is
    );
  }
}
