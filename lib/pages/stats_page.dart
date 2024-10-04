import 'package:flutter/material.dart'; // Importeer de Flutter-material design bibliotheek
import '/widgets/statistics_header.dart'; // Importeer de StatisticsHeader widget

class StatisticsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                itemCount: 5, // Aantal items dat weergegeven moet worden
                itemBuilder: (context, index) {
                  List<String> seedNames = [
                    "Zaadje 1", // Naam van het zaadje
                    "Zaadje 2",
                    "Zaadje 3",
                    "Zaadje 4",
                    "Zaadje 5",
                  ];
                  List<bool> isScanned = [
                    true, // Scanstatus van het zaadje
                    false,
                    true,
                    false,
                    true,
                  ];

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
                        seedNames[index], // Toon de naam van het zaadje
                        style: TextStyle(
                          color: Colors.green[800],
                          fontFamily: 'Roboto', // Gebruik Roboto voor de naam
                        ), // Tekstkleur
                      ),
                      subtitle: Text(
                        "Status: ${isScanned[index] ? "Gescand" : "Niet Gescand"}", // Toon de scanstatus
                        style: TextStyle(
                          color: isScanned[
                                  index] // Kleur afhankelijk van de scanstatus
                              ? Colors.green[600]
                              : Colors.red[600],
                          fontFamily: 'Roboto', // Gebruik Roboto voor de status
                        ),
                      ),
                      leading: Icon(
                        isScanned[index]
                            ? Icons.check_circle
                            : Icons
                                .cancel, // Toon een icoon afhankelijk van de scanstatus
                        color: isScanned[index]
                            ? Colors.green[700]
                            : Colors.red[700],
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
