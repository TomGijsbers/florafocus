import 'package:flutter/material.dart'; // Importeer de Flutter-material design bibliotheek

class AboutMeSection extends StatelessWidget {
  final String description; // Beschrijving van de gebruiker

  // Constructor voor de AboutMeSection widget
  const AboutMeSection({required this.description, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Bouw de UI van de AboutMeSection
    return Container(
      padding: EdgeInsets.all(16), // Padding rondom de container
      decoration: BoxDecoration(
        color: Colors.green[50], // Achtergrondkleur van de sectie
        borderRadius: BorderRadius.circular(10), // Afgeronde hoeken
        boxShadow: [
          // Schaduw effect voor diepte
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3), // Offset van de schaduw
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Over mij', // Titel voor de sectie
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.green[900],
              fontFamily: 'Montserrat', // Gebruik Montserrat voor de titel
            ), // Tekststijl
          ),
          SizedBox(height: 10), // Ruimte onder de titel
          Text(
            description, // Beschrijvingstekst
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontFamily: 'Roboto', // Gebruik Roboto voor de beschrijving
            ), // Tekststijl
            textAlign: TextAlign.center, // Centreer de tekst
          ),
        ],
      ),
    );
  }
}
