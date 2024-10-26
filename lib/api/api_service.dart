import 'dart:convert'; // Importeer de JSON conversie bibliotheek
import 'package:http/http.dart'
    as http; // Importeer de http package voor netwerkverzoeken

class ApiService {
  static const String baseUrl =
      'http://docker.taile0d53a.ts.net:8084'; // De basis-URL van de API
  // Functie om gebruikers voor de leaderboard op te halen
  Future<List<Map<String, dynamic>>> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse(
          '$baseUrl/users/all')); // Haal gebruikersgegevens op van de API

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
      final response = await http.get(Uri.parse('$baseUrl/users?email=$email'));

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
      final response =
          await http.get(Uri.parse('$baseUrl/users/$userId/products'));

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
      final response = await http.get(Uri.parse("$baseUrl/products/all"));

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

  // Method to fetch a single product by SKU
  Future<List<Map<String, dynamic>>> fetchProductBySku(String sku) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/products?skuCode=$sku'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data);
      } else {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load product');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load product');
    }
  }

  // Functie om gebruikersdata op te halen op basis van ID
  Future<Map<String, dynamic>?> fetchUserDataById(int userId) async {
    try {
      final response = await http.get(Uri.parse(
          '$baseUrl/users/$userId')); // Haal gebruikersgegevens op van de API
      if (response.statusCode == 200) {
        Map<String, dynamic> user = json
            .decode(response.body); // Converteer de JSON response naar een map
        print(
            'Fetched user: $user'); // Debug print om opgehaalde gebruiker te controleren
        return user; // Retourneer de gebruikersgegevens
      } else {
        print(
            'Failed to fetch user: ${response.statusCode}'); // Als de statuscode niet 200 is, geef een foutmelding
        return null; // Retourneer null als de gegevens niet succesvol zijn opgehaald
      }
    } catch (e) {
      print(
          'Error fetching user data: $e'); // Foutmelding indien er een uitzondering optreedt
      return null; // Retourneer null bij een fout
    }
  }
}
