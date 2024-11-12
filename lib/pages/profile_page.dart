import 'package:florafocus/models/user.dart';
import 'package:florafocus/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/widgets/profile_header.dart'; // Importeer de ProfileHeader widget
import '/widgets/edit_profile.dart'; // Importeer de EditProfileButton widget
import '../api/api_service.dart'; // Importeer de ApiService

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final ApiService apiService = ApiService(); // Instantie van ApiService

  void _showEditProfileModal(BuildContext context, User user) {
    final TextEditingController _nameController =
        TextEditingController(text: user.name);
    final TextEditingController _emailController =
        TextEditingController(text: user.email);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Bewerk Profiel'), // Titel van het dialoogvenster
          content: SizedBox(
            width: double.maxFinite, // Titel van het dialoogvenster
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nameController, // Controller voor de naam
                  decoration: InputDecoration(
                    labelText: 'Naam', // Label voor het tekstveld
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                const SizedBox(height: 10), // Ruimte tussen de tekstvelden
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email', // Label voor het tekstveld
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true, // Vul het tekstveld
                    fillColor:
                        Colors.grey[200], // Achtergrondkleur van het tekstveld
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('Annuleren'),
            ),
            ElevatedButton(
              onPressed: () async {
                user.name = _nameController.text;
                user.email = _emailController.text;
                Provider.of<UserProvider>(context, listen: false).setUser(user);
                // Optionally, call an API to update the user data on the server
                apiService.updateUserData(user.id, user.name, user.email);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.green[700], // Kleuring van de knop
              ),
              child: const Text('Opslaan'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).user;
    // Bouw de gebruikersinterface van de profielpagina
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profiel',
            style: TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.white)), // Titel van de app met Montserrat
        backgroundColor: Colors.green[700], // Achtergrondkleur van de AppBar
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Padding rondom de body
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Centreer de inhoud
              children: [
                const SizedBox(height: 20), // Ruimte boven de header
                ProfileHeader(
                    userName: user.name), // Toon profielheader met naam
                const SizedBox(height: 20), // Ruimte onder de header
                EditProfileButton(
                  onPressed: () {
                    _showEditProfileModal(context,
                        user); // Toon het bewerk profiel dialoogvenster
                  },
                ),
                const SizedBox(height: 20), // Ruimte onder de knop
                Text(
                  "Email: ${user.email}", // Toon het emailadres
                  style: TextStyle(
                    fontSize: 18, // Tekstgrootte
                    color: Colors.green[900], // Tekstkleur
                    fontFamily: 'Roboto', // Tekstfont
                  ),
                ),
                const SizedBox(height: 10), // Ruimte onder het emailadres
                Text(
                  "Aantal producten: ${user.scannedProducts.length}",
                  // Toon het aantal producten
                  style: TextStyle(
                    fontSize: 18, // Tekstgrootte
                    color: Colors.green[900], // Tekstkleur
                    fontFamily: 'Roboto', // Tekstfont
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
