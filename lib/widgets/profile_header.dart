import 'package:flutter/material.dart'; // Importeer de Flutter-material design bibliotheek

class ProfileHeader extends StatelessWidget {
  final String userName; // Gebruikersnaam

  // Constructor voor de ProfileHeader widget
  const ProfileHeader({
    required this.userName, // Gebruikersnaam is verplicht
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
        const SizedBox(height: 10), // Ruimte onder de gebruikersnaam
      ],
    );
  }
}
