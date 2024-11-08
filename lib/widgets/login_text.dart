import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final String label; // Het label van het invoerveld (bijv. 'Email')
  final bool
      obscureText; // Of de ingevoerde tekst verborgen moet zijn (bij wachtwoorden)
  final TextEditingController controller; // De controller die de invoer beheert
  final FormFieldValidator<String>?
      validator; // Validator functie voor het invoerveld

  const LoginTextField({
    required this.label, // Label is verplicht
    this.obscureText = false, // Standaard is de tekst niet verborgen
    required this.controller, // Controller is verplicht
    this.validator, // Validator is optioneel
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller, // Controller voor het invoerveld
      decoration: InputDecoration(
        labelText: label, // Het label dat boven het veld wordt weergegeven
        labelStyle: const TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.normal,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true, // Achtergrond invullen
        fillColor: Colors.white, // Kleur van het veld
      ),
      obscureText: obscureText, // Verberg de tekst als het wachtwoord is
      validator: validator, // Gebruik de validator als die is gedefinieerd
    );
  }
}
