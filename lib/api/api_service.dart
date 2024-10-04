import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'https://lucky-cats-marry.loca.lt/users'; // Juiste API-URL

  // Functie om gebruikers van de API op te halen
  Future<List<Map<String, dynamic>>> fetchUsers() async {
    try {
      final response = await http.get(
          Uri.parse(baseUrl)); // Geen '/users' hier, want baseUrl is al correct

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

  // Functie om een gebruiker te authentiseren
  Future<bool> loginUser(String email, String password) async {
    final response = await http.get(Uri.parse('$baseUrl?email=$email'));

    if (response.statusCode == 200) {
      List<dynamic> users = json.decode(response.body);
      if (users.isNotEmpty) {
        final user = users[0];
        if (user['password'] == password) {
          return true; // Login geslaagd
        }
      }
    }
    return false; // Login mislukt
  }
}
