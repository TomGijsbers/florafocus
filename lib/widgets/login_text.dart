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
