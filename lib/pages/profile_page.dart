import 'package:flutter/material.dart'; // Importeer de Flutter-material design bibliotheek
import '/widgets/profile_header.dart'; // Importeer de ProfileHeader widget
import '/widgets/edit_profile.dart'; // Importeer de EditProfileButton widget
import '/widgets/about.dart'; // Importeer de AboutMeSection widget

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic> user; // Add user data

  ProfilePage({required this.user}); // Add user data

  @override
  Widget build(BuildContext context) {
    // Provide a default value for age if it is null
    int userAge = user['age'] ?? 0;

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
                userName: "${user['first_name']} ${user['last_name']}",
                userAge: userAge), // Toon profielheader
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
            SizedBox(height: 20), // Ruimte onder de beschrijving
            Text(
              "Email: ${user['email']}",
              style: TextStyle(
                fontSize: 18,
                color: Colors.green[900],
                fontFamily: 'Roboto',
              ),
            ),
            SizedBox(height: 10), // Ruimte onder de email
          ],
        ),
      ),
    );
  }
}
