import 'dart:convert'; // Importeer de JSON conversie bibliotheek
import 'package:http/http.dart'
    as http; // Importeer de http package voor netwerkverzoeken

class ApiService {
  static const String baseUrl =
      'http://docker.taile0d53a.ts.net:8083/api/user'; // De basis-URL van de API
  static const String productUrl =
      'http://docker.taile0d53a.ts.net:8080/api/product/all'; // De URL voor producten

  // Functie om gebruikers voor de leaderboard op te halen
  Future<List<Map<String, dynamic>>> fetchUsers() async {
    try {
      final response = await http.get(
          Uri.parse('$baseUrl/all')); // Haal gebruikersgegevens op van de API

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
      final response = await http.get(Uri.parse('$baseUrl?email=$email'));

      if (response.statusCode == 200) {
        List<dynamic> users = json.decode(response.body);
        if (users.isNotEmpty) {
          final user = users[0];
          if (user['password'] == password) {
            // Haal de gescande zaadjes op
            final userId = user['id'];
            final products = await fetchUserProducts(userId);
            user['scanned_seeds'] = products;
            return user;
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
    return null;
  }

  Future<List<Map<String, dynamic>>> fetchUserProducts(int userId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$userId/products'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data);
      } else {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load user products');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load user products');
    }
  }

  // Functie om producten op te halen
  Future<List<Map<String, dynamic>>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(productUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data);
      } else {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load products');
    }
  }

  // Functie om gebruikersdata op te halen op basis van naam
  Future<Map<String, dynamic>?> fetchUserDataByName(String name) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/all'));
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> users =
            List<Map<String, dynamic>>.from(json.decode(response.body));
        print('Fetched users: $users'); // Debug print to check fetched users
        // Zoek de gebruiker met de overeenkomende naam
        Map<String, dynamic>? user = users.firstWhere(
          (user) => user['name'] == name,
          orElse: () => {},
        );
        if (user.isNotEmpty) {
          return user;
        } else {
          print('User not found'); // Debug print
          return null;
        }
      } else {
        print('Failed to fetch users: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }
}
