import 'package:flutter/material.dart'; // Importeer de Flutter-material design bibliotheek

class EditProfileButton extends StatelessWidget {
  final VoidCallback onPressed; // Callback voor de knop actie

  // Constructor voor de EditProfileButton widget
  const EditProfileButton({required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Bouw de UI van de EditProfileButton
    return ElevatedButton(
      onPressed: onPressed, // Tekst op de knop met Roboto
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green[500], // Achtergrondkleur van de knop
        padding: const EdgeInsets.symmetric(
            horizontal: 30, vertical: 15), // Padding rondom de tekst
        textStyle: const TextStyle(fontSize: 18), // Tekststijl
      ), // Voer de callback uit wanneer de knop wordt ingedrukt
      child: const Text('Bewerk Profiel',
          style: TextStyle(fontFamily: 'Roboto', color: Colors.white)),
    );
  }
}
