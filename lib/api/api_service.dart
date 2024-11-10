import 'dart:convert'; // Importeer de JSON conversie bibliotheek
import 'package:florafocus/models/product.dart';
import 'package:florafocus/models/user.dart';
import 'package:http/http.dart'
    as http; // Importeer de http package voor netwerkverzoeken

class ApiService {
  static const String baseUrl =
      'http://docker.taile0d53a.ts.net:8084'; // De basis-URL van de API
  // Functie om gebruikers voor de leaderboard op te halen
  Future<List<User>> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse(
          '$baseUrl/users/all')); // Haal gebruikersgegevens op van de API

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(
            response.body); // Converteer de JSON response naar een lijst
        return data
            .map((item) => User.fromJson(item))
            .toList(); // Retourneer de gebruikersgegevens als een lijst van mappen
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
  Future<User?> loginUser(String email, String password) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/users?email=$email'));

      if (response.statusCode == 200) {
        Map<String, dynamic> user = json.decode(response.body);
        if (user.isNotEmpty) {
          if (user['password'] == password) {
            User userObj = User.fromJson(user);
            // Haal de gescande zaadjes op
            final userId = user['id'];
            final products = await fetchUserProducts(userId);
            userObj.scannedProducts =
                products.map((product) => product.skuCode).toList();
            return userObj;
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

  Future<List<Product>> fetchUserProducts(int userId) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/users/$userId/products'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((item) => Product.fromJson(item)).toList();
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
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/products/all"));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((item) => Product.fromJson(item)).toList();
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
  Future<List<Product>> getProductBySku(String sku) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/products?skuCode=$sku'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((item) => Product.fromJson(item)).toList();
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

// Method to add a single product to a user by SKU
  Future<void> addProductToUserBySku(String sku, int id) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/$id/products/$sku'),
      );
      if (response.statusCode == 400) {
        print('Product already scanned');
        throw Exception('Product already scanned');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to add product');
    }
  }

  // Functie om gebruikersdata op te halen op basis van ID
  Future<User?> fetchUserDataById(int userId) async {
    try {
      final response = await http.get(Uri.parse(
          '$baseUrl/users/$userId')); // Haal gebruikersgegevens op van de API
      if (response.statusCode == 200) {
        Map<String, dynamic> userMap = json
            .decode(response.body); // Converteer de JSON response naar een map
        User user =
            User.fromJson(userMap); // Converteer de map naar een User object
        print(
            'Fetched user: ${user.name}'); // Debug print om opgehaalde gebruiker te controleren
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

// Functie om gebruikersdata bij te werken
  Future<void> updateUserData(int userId, String name, String email) async {
    try {
      final response = await http.put(
        Uri.parse(
            '$baseUrl/users/$userId'), // Stuur een PUT verzoek naar de API
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
}
