import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '/widgets/profile_header.dart'; // Importeer de ProfileHeader widget
import '/widgets/edit_profile.dart'; // Importeer de EditProfileButton widget
import '../api/api_service.dart'; // Importeer de ApiService

class ProfilePage extends StatefulWidget {
  final Map<String, dynamic> user; // Gebruikersdata in de vorm van een map

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
  int _productCount = 0; // Aantal producten

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
      final response = await http
          .get(Uri.parse('http://docker.taile0d53a.ts.net:8084/users/all'));
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> users =
            List<Map<String, dynamic>>.from(json.decode(response.body));
        print('Fetched users: $users'); // Debug print to check fetched users
        // Zoek de gebruiker met de overeenkomende naam
        Map<String, dynamic>? user = users.firstWhere(
          (user) => user['name'] == widget.user['name'],
          orElse: () => {},
        );
        if (user.isNotEmpty) {
          // Controleer of de gebruiker niet leeg is
          setState(() {
            _nameController.text = user['name'];
            _emailController.text = user['email'];
            _productCount =
                user['productSkucodes']?.length ?? 0; // Aantal producten
          });
          print(
              'User data updated: ${user['name']}, ${user['email']}, Product count: $_productCount'); // Debug print
        } else {
          print('User not found'); // Debug print
        }
      } else {
        print('Failed to fetch users: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> _updateUserData(int userId, String name, String email) async {
    try {
      final response = await http.put(
        Uri.parse('http://docker.taile0d53a.ts.net:8084/user/$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
        print('User data updated successfully');
      } else {
        print('Failed to update user data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating user data: $e');
    }
  }

  void _showEditProfileModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Bewerk Profiel'),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Naam',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
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
                final userId = widget.user['id'];
                final name = _nameController.text;
                final email = _emailController.text;
                final success =
                    await apiService.updateUserData(userId, name, email);
                if (success) {
                  setState(() {
                    widget.user['name'] = name;
                    widget.user['email'] = email;
                  });
                  Navigator.of(context).pop();
                } else {
                  // Handle error
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.green[700],
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
