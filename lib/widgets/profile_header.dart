import 'package:flutter/material.dart'; // Importeer de Flutter-material design bibliotheek

class ProfileHeader extends StatelessWidget {
  final String userName; // Gebruikersnaam
  final int userAge; // Leeftijd van de gebruiker

  // Constructor voor de ProfileHeader widget
  const ProfileHeader({
    required this.userName, // Gebruikersnaam is verplicht
    required this.userAge, // Leeftijd is verplicht
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Bouw de UI van de ProfileHeader
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center, // Centreer de inhoud
      children: [
        Text(
          userName, // Toon de gebruikersnaam
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.green[900],
            fontFamily:
                'Montserrat', // Gebruik Montserrat voor de gebruikersnaam
          ), // Tekststijl
        ),
        SizedBox(height: 10), // Ruimte onder de gebruikersnaam
        Text(
          'Leeftijd: $userAge', // Toon de leeftijd
          style: TextStyle(
            fontSize: 20,
            color: Colors.green[600],
            fontFamily: 'Roboto', // Gebruik Roboto voor de leeftijd
          ), // Tekststijl
        ),
      ],
    );
  }
}
