import 'package:flutter/material.dart'; // Importeer de Flutter-material design bibliotheek
import '../widgets/camera_button.dart'; // Importeer de CameraButton widget
import '../widgets/grid_item.dart'; // Importeer de GridItem widget

class HomePage extends StatelessWidget {
  final Map<String, dynamic> user; // Gebruikersdata

  HomePage({required this.user}); // Constructor met verplichte gebruikersdata

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welkom bij de FloraFocus",
            style: TextStyle(fontFamily: 'Roboto')), // Titel van de app
        centerTitle: true, // Centreer de titel
        backgroundColor: Colors.green[700], // Achtergrondkleur van de AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding rondom de body
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Inhoud uitlijnen aan de linkerkant
          children: [
            Container(
              padding: EdgeInsets.all(16), // Padding binnen de container
              decoration: BoxDecoration(
                color: Colors.green[50], // Achtergrondkleur van de container
                borderRadius: BorderRadius.circular(10), // Ronde hoeken
              ),
              child: Text(
                "Hello ${user['name']}! Welkom op de homepage! Gebruik de onderstaande knoppen om de verschillende functies van de app te verkennen.",
                style: TextStyle(
                  fontSize: 18, // Tekstgrootte
                  color: Colors.green[900], // Tekstkleur
                  fontFamily: 'Montserrat', // Tekstfont
                ),
              ),
            ),
            SizedBox(height: 20), // Ruimte onder de welkomsttekst
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // Twee kolommen
                crossAxisSpacing: 16.0, // Ruimte tussen kolommen
                mainAxisSpacing: 16.0, // Ruimte tussen rijen
                children: [
                  GridItem(
                    icon: Icons.bar_chart, // Icoon voor statistieken
                    label: "Statistieken", // Label voor statistieken
                    route: '/statistics', // Route naar statistiekenpagina
                    color: Colors.green[400]!, // Kleur van het item
                    user: user, // Gebruikersdata meegeven
                  ),
                  GridItem(
                    icon: Icons.leaderboard, // Icoon voor klassement
                    label: "Klassement", // Label voor klassement
                    route: '/leaderboard', // Route naar klassementpagina
                    color: Colors.green[600]!, // Kleur van het item
                    user: user, // Gebruikersdata meegeven
                  ),
                  GridItem(
                    icon: Icons.settings, // Icoon voor instellingen
                    label: "Instellingen", // Label voor instellingen
                    route: '/settings', // Route naar instellingenpagina
                    color: Colors.green[500]!, // Kleur van het item
                    user: user, // Gebruikersdata meegeven
                  ),
                  GridItem(
                    icon: Icons.person, // Icoon voor profiel
                    label: "Profiel", // Label voor profiel
                    route: '/profile', // Route naar profielpagina
                    color: Colors.green[700]!, // Kleur van het item
                    user: user, // Gebruikersdata meegeven
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: CameraButton(
        onPressed: () {
          // Voeg hier de functie toe om de camera te openen of een object te scannen
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerFloat, // Locatie van de camera-knop
    );
  }
}
