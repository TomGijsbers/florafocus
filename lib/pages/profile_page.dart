import 'package:flutter/material.dart'; // Importeer de Flutter-material design bibliotheek
import '/widgets/profile_header.dart'; // Importeer de ProfileHeader widget
import '/widgets/edit_profile.dart'; // Importeer de EditProfileButton widget
import '/widgets/about.dart'; // Importeer de AboutMeSection widget

class ProfilePage extends StatelessWidget {
  final String userName = 'Jan Jansen'; // Gebruikersnaam
  final int userAge = 30; // Leeftijd van de gebruiker

  @override
  Widget build(BuildContext context) {
    // Bouw de UI van de ProfilePage
    return Scaffold(
      appBar: AppBar(
        title: Text('Profiel',
            style: TextStyle(
                fontFamily: 'Montserrat')), // Titel van de app met Montserrat
        backgroundColor: Colors.green[700], // Achtergrondkleur van de AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding rondom de body
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Centreer de inhoud
          children: [
            SizedBox(height: 20), // Ruimte boven de header
            ProfileHeader(
                userName: userName, userAge: userAge), // Toon profielheader
            SizedBox(height: 20), // Ruimte onder de header
            EditProfileButton(
              onPressed: () {
                // Voeg functionaliteit toe voor het bewerken van het profiel
              },
            ),
            SizedBox(height: 20), // Ruimte onder de knop
            AboutMeSection(
              description:
                  'Hier kan je een korte beschrijving van jezelf geven.', // Beschrijving voor de "Over mij" sectie
            ),
          ],
        ),
      ),
    );
  }
}
