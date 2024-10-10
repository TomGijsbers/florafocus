import 'dart:convert'; // Importeer de JSON conversie bibliotheek
import 'package:http/http.dart'
    as http; // Importeer de http package voor netwerkverzoeken

class ApiService {
  static const String baseUrl =
      'https://dull-rocks-like.loca.lt/users'; // De basis-URL van de API

  // Functie om gebruikers voor de leaderboard op te halen
  Future<List<Map<String, dynamic>>> fetchUsers() async {
    try {
      final response = await http
          .get(Uri.parse(baseUrl)); // Haal gebruikersgegevens op van de API

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(
            response.body); // Converteer de JSON response naar een lijst
        return List<Map<String, dynamic>>.from(
            data); // Retourneer de gebruikersgegevens als een lijst van mappen
      } else {
        print(
            'Response status: ${response.statusCode}'); // Toon de response code als er iets mis gaat
        print(
            'Response body: ${response.body}'); // Toon de body van de response
        throw Exception(
            'Failed to load users'); // Gooi een exceptie bij een fout
      }
    } catch (e) {
      print('Error: $e'); // Print de foutmelding
      throw Exception('Failed to load users'); // Gooi een exceptie bij een fout
    }
  }

  // Functie om een gebruiker te authentiseren en de gebruikersdata terug te geven
  Future<Map<String, dynamic>?> loginUser(String email, String password) async {
    try {
      final response = await http.get(Uri.parse(
          '$baseUrl?email=$email')); // Haal gebruikersgegevens op met het opgegeven emailadres

      if (response.statusCode == 200) {
        List<dynamic> users = json.decode(
            response.body); // Converteer de JSON response naar een lijst
        if (users.isNotEmpty) {
          final user = users[0]; // Selecteer de eerste gebruiker
          if (user['password'] == password) {
            return user; // Login geslaagd, retourneer de gebruikersgegevens
          } else {
            print(
                'Wachtwoord onjuist'); // Toon een melding bij een onjuist wachtwoord
          }
        } else {
          print(
              'Gebruiker niet gevonden'); // Toon een melding als de gebruiker niet wordt gevonden
        }
      } else {
        print(
            'Response status: ${response.statusCode}'); // Toon de response code
        print('Response body: ${response.body}'); // Toon de response body
      }
    } catch (e) {
      print('Error tijdens het inloggen: $e'); // Print de foutmelding
    }
    return null; // Retourneer null bij mislukte login
  }
}
