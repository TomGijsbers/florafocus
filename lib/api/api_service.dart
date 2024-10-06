import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://cute-waves-remain.loca.lt/users';

  // Functie om gebruikers voor de leaderboard op te halen
  Future<List<Map<String, dynamic>>> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse(baseUrl)); // Gebruikers ophalen

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data);
      } else {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load users');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load users');
    }
  }

  // Functie om een gebruiker te authentiseren en de gebruikersdata terug te geven
  Future<Map<String, dynamic>?> loginUser(String email, String password) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl?email=$email'));

      if (response.statusCode == 200) {
        List<dynamic> users = json.decode(response.body);
        if (users.isNotEmpty) {
          final user = users[0];
          if (user['password'] == password) {
            return user; // Login geslaagd, retourneer de gebruikersdata
          } else {
            print('Wachtwoord onjuist');
          }
        } else {
          print('Gebruiker niet gevonden');
        }
      } else {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error tijdens het inloggen: $e');
    }
    return null; // Login mislukt
  }
}
