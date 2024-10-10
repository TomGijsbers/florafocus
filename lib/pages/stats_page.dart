import 'package:flutter/material.dart'; // Importeer de Flutter-material design bibliotheek
import '/widgets/statistics_header.dart'; // Importeer de StatisticsHeader widget

class StatisticsPage extends StatelessWidget {
  final Map<String, dynamic> user; // Gebruikersgegevens

  StatisticsPage({required this.user}); // Constructor met gebruikersgegevens

  @override
  Widget build(BuildContext context) {
    List<dynamic> scannedSeeds =
        user['scanned_seeds']; // Verkrijg de gescande zaadjes van de gebruiker

    // Bouw de UI van de StatisticsPage
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Statistieken',
          style: TextStyle(
              fontFamily: 'Roboto'), // Gebruik Roboto voor de app-balk titel
        ), // Titel van de app
        backgroundColor: Colors.green[700], // Achtergrondkleur van de AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding rondom de body
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Uitlijnen aan de linkerkant
          children: [
            StatisticsHeader(
              text:
                  "Hier zijn je statistieken van de gescande zaadjes.", // Tekst voor de header
            ),
            SizedBox(height: 20), // Ruimte onder de header
            Expanded(
              child: ListView.builder(
                itemCount: scannedSeeds
                    .length, // Aantal items dat weergegeven moet worden
                itemBuilder: (context, index) {
                  var seed = scannedSeeds[index];

                  return Card(
                    color: Colors.green[100], // Achtergrondkleur van de kaart
                    elevation: 4, // Schaduw van de kaart
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12), // Afgeronde hoeken
                    ),
                    margin: EdgeInsets.symmetric(
                        vertical: 10), // Verticale marge tussen kaarten
                    child: ListTile(
                      title: Text(
                        seed['seed_name'], // Toon de naam van het zaadje
                        style: TextStyle(
                          color: Colors.green[800],
                          fontFamily: 'Roboto', // Gebruik Roboto voor de naam
                        ), // Tekstkleur
                      ),
                      subtitle: Text(
                        "Fruit: ${seed['fruit_name']}\nSKU: ${seed['sku_code']}", // Toon de fruitnaam en SKU
                        style: TextStyle(
                          color: Colors.green[600],
                          fontFamily: 'Roboto', // Gebruik Roboto voor de status
                        ),
                      ),
                      leading: Icon(
                        Icons.check_circle,
                        color: Colors.green[700], // Icoon voor gescande zaadjes
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
