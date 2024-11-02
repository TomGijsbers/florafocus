import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '/widgets/statistics_header.dart';

class StatisticsPage extends StatefulWidget {
  final Map<String, dynamic> user;

  const StatisticsPage({super.key, required this.user});

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  List<dynamic> productSkucodes =
  []; // Lijst om SKU-codes van producten op te slaan
  final ApiService apiService =
  ApiService(); // Instantieer ApiService voor API-aanroepen

  @override
  void initState() {
    super.initState();
    _fetchUserData(); // Haal gebruikersgegevens op bij het initialiseren van de pagina
  }

  // Functie om gebruikersgegevens op te halen en de productSkucodes bij te werken
  void _fetchUserData() async {
    int userId = widget.user['id']; // Haal de userId op uit de widget
    Map<String, dynamic>? user = await apiService
        .fetchUserDataById(userId); // Haal gebruikersgegevens op via userId
    if (user != null) {
      setState(() {
        productSkucodes = user['productSkucodes'] ??
            []; // Update de productSkucodes, of een lege lijst als deze null is
      });
      print(
          'User data updated: ${user['name']}, Product SKU Codes: $productSkucodes'); // Debug print om de bijgewerkte gegevens te controleren
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Statistieken',
          style: TextStyle(fontFamily: 'Roboto'),
        ),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding rondom de inhoud
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StatisticsHeader(
              text:
              "Hier zijn je statistieken van de gescande producten.", // Toon de statistieken header
            ),
            const SizedBox(height: 20), // Ruimte tussen de header en de lijst
            Expanded(
              child: ListView.builder(
                itemCount: productSkucodes.length, // Aantal items in de lijst
                itemBuilder: (context, index) {
                  var skuCode = productSkucodes[index]; // Haal de SKU-code op

                  return Card(
                    color: Colors.green[100],
                    // Achtergrondkleur van de kaart
                    elevation: 4,
                    // Hoogte-effect voor de kaart
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(12), // Afronden van de hoeken
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    // Ruimte tussen de kaarten
                    child: ListTile(
                      title: Text(
                        skuCode, // Toon de SKU-code in de titel
                        style: TextStyle(
                          color: Colors.green[800], // Tekstkleur
                          fontFamily: 'Roboto',
                        ),
                      ),
                      leading: Icon(
                        Icons.check_circle, // Icoon aan de linkerkant
                        color: Colors.green[700], // Kleur van het icoon
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
