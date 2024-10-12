import 'package:flutter/material.dart'; // Importeer de Flutter-material design bibliotheek
import '/widgets/profile_header.dart'; // Importeer de ProfileHeader widget
import '/widgets/edit_profile.dart'; // Importeer de EditProfileButton widget
import '../api/api_service.dart'; // Importeer de ApiService

class ProfilePage extends StatefulWidget {
  final Map<String, dynamic> user; // Gebruikersdata in de vorm van een map

  ProfilePage(
      {required this.user}); // Constructor die de gebruikersdata vereist

  @override
  _ProfilePageState createState() =>
      _ProfilePageState(); // Creëer de state voor de ProfilePage
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _nameController; // Controller voor de naam
  late TextEditingController _emailController; // Controller voor het emailadres
  final ApiService apiService = ApiService(); // Instantie van ApiService

  @override
  void initState() {
    super.initState(); // Voer de initState van de superclass uit
    // Initialiseer de controllers met de huidige waarde van de gebruikersdata
    _nameController = TextEditingController(text: widget.user['name']);
    _emailController = TextEditingController(text: widget.user['email']);
    _fetchUserData(); // Haal de gebruikersdata op van de API
  }

  @override
  void dispose() {
    // Ruim de controllers op wanneer de widget wordt verwijderd
    _nameController.dispose();
    _emailController.dispose();
    super.dispose(); // Voer de dispose van de superclass uit
  }

  void _fetchUserData() async {
    try {
      List<Map<String, dynamic>> users = await apiService.fetchUsers();
      // Zoek de gebruiker met het overeenkomende emailadres
      Map<String, dynamic>? user = users.firstWhere(
        (user) => user['email'] == widget.user['email'],
        orElse: () => {},
      );
      if (user.isNotEmpty) {
        // Controleer of de gebruiker niet leeg is
        setState(() {
          _nameController.text = user['name'];
          _emailController.text = user['email'];
        });
        print(
            'User data updated: ${user['name']}, ${user['email']}'); // Debug print
      } else {
        print('User not found'); // Debug print
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  void _showEditProfileModal(BuildContext context) {
    // Functie om het bewerk profiel dialoogvenster te tonen
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Bewerk Profiel'), // Titel van het dialoogvenster
          content: Container(
            width: double.maxFinite, // Zorg dat de container maximaal breed is
            child: Column(
              mainAxisSize: MainAxisSize.min, // Minimale hoogte van de kolom
              children: [
                TextField(
                  controller: _nameController, // Controller voor de naam
                  decoration: InputDecoration(
                    labelText: 'Naam', // Label voor het tekstveld
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Hoeken van de rand afronden
                    ),
                    filled: true, // Vul het tekstveld
                    fillColor:
                        Colors.grey[200], // Achtergrondkleur van het tekstveld
                  ),
                ),
                SizedBox(height: 10), // Ruimte tussen de tekstvelden
                TextField(
                  controller:
                      _emailController, // Controller voor het emailadres
                  decoration: InputDecoration(
                    labelText: 'Email', // Label voor het tekstveld
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Hoeken van de rand afronden
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
                Navigator.of(context)
                    .pop(); // Sluit het dialoogvenster zonder wijzigingen
              },
              child: Text('Annuleren'), // Knop om te annuleren
              style: TextButton.styleFrom(
                foregroundColor: Colors.red, // Kleuring van de knop
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // Werk de gebruikersdata bij met de waarden uit de tekstvelden
                  widget.user['name'] = _nameController.text;
                  widget.user['email'] = _emailController.text;
                });
                Navigator.of(context)
                    .pop(); // Sluit het dialoogvenster na het opslaan
              },
              child: Text('Opslaan'), // Knop om wijzigingen op te slaan
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.green[700], // Kleuring van de knop
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Bouw de gebruikersinterface van de profielpagina
    return Scaffold(
      appBar: AppBar(
        title: Text('Profiel',
            style: TextStyle(
                fontFamily: 'Montserrat')), // Titel van de app met Montserrat
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
                SizedBox(height: 20), // Ruimte boven de header
                ProfileHeader(
                    userName:
                        _nameController.text), // Toon profielheader met naam
                SizedBox(height: 20), // Ruimte onder de header
                EditProfileButton(
                  onPressed: () {
                    _showEditProfileModal(
                        context); // Toon het bewerk profiel dialoogvenster
                  },
                ),
                SizedBox(height: 20), // Ruimte onder de knop
                Text(
                  "Email: ${_emailController.text}", // Toon het emailadres
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
