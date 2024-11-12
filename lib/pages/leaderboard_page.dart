import 'package:florafocus/models/user.dart';
import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../widgets/leaderboard_item.dart'; // Importeer de LeaderboardItem widget

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  final ApiService _apiService =
      ApiService(); // Maak een instantie van de API-service
  List<User> _users = []; // Lijst van gebruikers voor het klassement
  String _errorMessage = ''; // Bericht om eventuele fouten weer te geven

  @override
  void initState() {
    super.initState();
    _fetchUsers(); // Haal de gebruikers op wanneer de pagina wordt geladen
  }

  // Methode om gebruikers op te halen en het klassement te sorteren
  Future<void> _fetchUsers() async {
    try {
      // Haal de gebruikers op van de API
      List<User> users = await _apiService.fetchUsers();

      // Sorteer de gebruikers op basis van het aantal gescande producten, aflopend
      users.sort((a, b) =>
          b.scannedProducts.length.compareTo(a.scannedProducts.length));

      // Update de state met de gesorteerde gebruikers
      setState(() {
        _users = users;
      });
    } catch (e) {
      // Als er een fout optreedt, stel de foutboodschap in
      setState(() {
        _errorMessage = 'Fout bij het ophalen van gebruikers: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Klassement", // Titel van de pagina
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: Colors.white), // Gebruik Roboto voor de titel
        ),
        backgroundColor: Colors.green[700], // Achtergrondkleur van de appbalk
      ),
      // Als er een foutboodschap is, toon die in het midden van de pagina
      body: _errorMessage.isNotEmpty
          ? Center(
              child: Text(
                _errorMessage, // Toon de foutboodschap
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                  fontFamily: 'Montserrat',
                ),
              ),
            )
          // Als er geen fout is, toon de lijst met gebruikers
          : ListView.builder(
              itemCount: _users.length, // Aantal gebruikers in de lijst
              itemBuilder: (context, index) {
                final user = _users[index]; // Haal een gebruiker uit de lijst
                return LeaderboardItem(
                  user: user, // Geef de gebruiker door aan LeaderboardItem
                  rank: index + 1, // De rang van de gebruiker
                );
              },
            ),
    );
  }
}
