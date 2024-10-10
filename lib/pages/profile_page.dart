import 'package:flutter/material.dart'; // Importeer de Flutter-material design bibliotheek
import '/widgets/profile_header.dart'; // Importeer de ProfileHeader widget
import '/widgets/edit_profile.dart'; // Importeer de EditProfileButton widget

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic> user; // Gebruikersdata

  ProfilePage(
      {required this.user}); // Constructor met verplichte gebruikersdata

  @override
  Widget build(BuildContext context) {
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
                userName:
                    "${user['first_name']} ${user['last_name']}"), // Toon profielheader met naam
            SizedBox(height: 20), // Ruimte onder de header
            EditProfileButton(
              onPressed: () {
                // Voeg hier de logica toe voor de bewerk profiel knop
              },
            ),
            SizedBox(height: 20), // Ruimte onder de knop
            Text(
              "Email: ${user['email']}", // Toon het emailadres
              style: TextStyle(
                fontSize: 18, // Tekstgrootte
                color: Colors.green[900], // Tekstkleur
                fontFamily: 'Roboto', // Tekstfont
              ),
            ),
          ],
        ),
      ),
    );
  }
}
