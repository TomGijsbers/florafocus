import 'package:florafocus/models/user.dart';
import 'package:flutter/material.dart';
import '/widgets/profile_header.dart'; // Importeer de ProfileHeader widget
import '/widgets/edit_profile.dart'; // Importeer de EditProfileButton widget
import '../api/api_service.dart'; // Importeer de ApiService

class ProfilePage extends StatefulWidget {
  final User user; // Gebruikersdata in de vorm van een map

  const ProfilePage(
      {super.key,
      required this.user}); // Constructor die de gebruikersdata vereist

  @override
  State<StatefulWidget> createState() =>
      _ProfilePageState(); // Creëer de state voor de ProfilePage
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _nameController; // Controller voor de naam
  late TextEditingController _emailController; // Controller voor het emailadres
  final ApiService apiService = ApiService(); // Instantie van ApiService
  final int _productCount = 0; // Aantal producten

  @override
  void initState() {
    super.initState(); // Voer de initState van de superclass uit
    // Initialiseer de controllers met de huidige waarde van de gebruikersdata
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _fetchUserData(); // Roep de async functie aan
  }

  @override
  void dispose() {
    // Ruim de controllers op wanneer de widget wordt verwijderd
    _nameController.dispose();
    _emailController.dispose();
    super.dispose(); // Voer de dispose van de superclass uit
  }

  void _fetchUserData() async {
    User? fetchedUser = await apiService.fetchUserDataById(widget.user.id);
    if (fetchedUser != null) {
      setState(() {
        widget.user.name = fetchedUser.name;
        widget.user.email = fetchedUser.email;
        widget.user.scannedProducts = fetchedUser.scannedProducts;
        _nameController.text = fetchedUser.name;
        _emailController.text = fetchedUser.email;
      });
    }
  }

  void _showEditProfileModal(BuildContext context) {
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
                final userId = widget.user.id;
                final name = _nameController.text;
                final email = _emailController.text;
                await apiService.updateUserData(userId, name, email);
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
                    userName:
                        _nameController.text), // Toon profielheader met naam
                const SizedBox(height: 20), // Ruimte onder de header
                EditProfileButton(
                  onPressed: () {
                    _showEditProfileModal(
                        context); // Toon het bewerk profiel dialoogvenster
                  },
                ),
                const SizedBox(height: 20), // Ruimte onder de knop
                Text(
                  "Email: ${_emailController.text}", // Toon het emailadres
                  style: TextStyle(
                    fontSize: 18, // Tekstgrootte
                    color: Colors.green[900], // Tekstkleur
                    fontFamily: 'Roboto', // Tekstfont
                  ),
                ),
                const SizedBox(height: 10), // Ruimte onder het emailadres
                Text(
                  "Aantal producten: $_productCount", // Toon het aantal producten
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
