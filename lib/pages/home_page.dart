import 'package:flutter/material.dart'; // Importeer de Flutter-material design bibliotheek

import '/widgets/grid_item.dart'; // Importeer de GridItem widget
import '/widgets/camera_button.dart'; // Importeer de CameraButton widget

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Bouw de UI van de HomePage
    return Scaffold(
      appBar: AppBar(
        title: Text("Welkom bij de FloraFocus",
            style: TextStyle(fontFamily: 'Roboto')), // Titel van de app
        centerTitle: true, // Centreer de titel in de AppBar
        backgroundColor: Colors.green[700], // Achtergrondkleur van de AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding rondom de body
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align de kinderen aan de linkerkant
          children: [
            Container(
              padding: EdgeInsets.all(16), // Padding rondom de container
              decoration: BoxDecoration(
                color: Colors.green[50], // Achtergrondkleur van de container
                borderRadius: BorderRadius.circular(10), // Afgeronde hoeken
              ),
              child: Text(
                "Welkom op de homepage! Gebruik de onderstaande knoppen om de verschillende functies van de app te verkennen.",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.green[900],
                  fontFamily: 'Montserrat', // Gebruik het Montserrat lettertype
                ), // Tekststijl
              ),
            ),
            SizedBox(height: 20), // Ruimte tussen container en grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // Aantal kolommen in de grid
                crossAxisSpacing: 16.0, // Ruimte tussen kolommen
                mainAxisSpacing: 16.0, // Ruimte tussen rijen
                children: [
                  // GridItems met iconen en labels
                  GridItem(
                    icon: Icons.bar_chart,
                    label: "Statistieken",
                    route: '/statistics',
                    color: Colors.green[400]!,
                  ),
                  GridItem(
                    icon: Icons.leaderboard,
                    label: "Klassement",
                    route: '/leaderboard',
                    color: Colors.green[600]!,
                  ),
                  GridItem(
                    icon: Icons.settings,
                    label: "Instellingen",
                    route: '/settings',
                    color: Colors.green[500]!,
                  ),
                  GridItem(
                    icon: Icons.person,
                    label: "Profiel",
                    route: '/profile',
                    color: Colors.green[700]!,
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
          .centerFloat, // Plaats de floating action button in het midden onderaan
    );
  }
}
