import 'package:flutter/material.dart'; // Importeer de Flutter-material design bibliotheek

class CameraButton extends StatelessWidget {
  final VoidCallback onPressed; // Callback voor de knop actie

  // Constructor voor de CameraButton widget
  const CameraButton({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Bouw de UI van de CameraButton
    return GestureDetector(
      onTap: onPressed, // Voer de callback uit wanneer de knop wordt ingedrukt
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: 20, vertical: 10), // Padding voor de knop
        decoration: BoxDecoration(
          color: Colors.green[600], // Achtergrondkleur van de knop
          borderRadius: BorderRadius.circular(30), // Afgeronde hoeken
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // Offset van de schaduw
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize
              .min, // Zorg ervoor dat de rij niet groter wordt dan de inhoud
          children: [
            Icon(
              Icons.camera_alt,
              color: Colors.white, // Kleur van het icoon
            ),
            SizedBox(width: 8), // Ruimte tussen het icoon en de tekst
            Text(
              "Scan een zaadje!", // Tekst op de knop
              style: TextStyle(
                color: Colors.white, // Kleur van de tekst
                fontSize: 16, // Lettergrootte
              ),
            ),
          ],
        ),
      ),
    );
  }
}
