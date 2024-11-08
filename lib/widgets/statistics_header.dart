import 'package:flutter/material.dart'; // Importeer de Flutter-material design bibliotheek

class StatisticsHeader extends StatelessWidget {
  final String text; // Tekst voor de header

  // Constructor voor de StatisticsHeader widget
  const StatisticsHeader({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Bouw de UI van de StatisticsHeader
    return Container(
      padding: const EdgeInsets.all(16), // Padding rondom de container
      decoration: BoxDecoration(
        color: Colors.green[50], // Achtergrondkleur van de header
        borderRadius: BorderRadius.circular(10), // Afgeronde hoeken
      ),
      child: Text(
        text, // Toon de tekst
        style: TextStyle(
          fontSize: 18,
          color: Colors.green[900],
          fontFamily: 'Montserrat', // Gebruik Montserrat voor de header
        ), // Tekststijl
      ),
    );
  }
}
