import 'package:florafocus/models/user.dart';
import 'package:florafocus/providers/user_provider.dart';
import 'package:flutter/material.dart'; // Importeer de Flutter-material design bibliotheek
import 'package:provider/provider.dart';
import '../widgets/camera_button.dart'; // Importeer de CameraButton widget
import '../widgets/grid_item.dart';
import '../widgets/logout_button.dart'; // Importeer de GridItem widget

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Welkom bij de FloraFocus",
            style: TextStyle(
                fontFamily: 'Roboto', color: Colors.white)), // Titel van de app
        centerTitle: true, // Centreer de titel
        backgroundColor: Colors.green[700], // Achtergrondkleur van de AppBar
        actions: const [
          LogoutButton(), // Add the LogoutButton here
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding rondom de body
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Inhoud uitlijnen aan de linkerkant
          children: [
            Container(
              padding: const EdgeInsets.all(16), // Padding binnen de container
              decoration: BoxDecoration(
                color: Colors.green[50], // Achtergrondkleur van de container
                borderRadius: BorderRadius.circular(10), // Ronde hoeken
              ),
              child: Text(
                "Hallo ${user.name}! Welkom op de homepage! Gebruik de onderstaande knoppen om de verschillende functies van de app te verkennen.",
                style: TextStyle(
                  fontSize: 18, // Tekstgrootte
                  color: Colors.green[900], // Tekstkleur
                  fontFamily: 'Montserrat', // Tekstfont
                ),
              ),
            ),
            const SizedBox(height: 20), // Ruimte onder de welkomsttekst
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // Twee kolommen
                crossAxisSpacing: 16.0, // Ruimte tussen kolommen
                mainAxisSpacing: 16.0, // Ruimte tussen rijen
                children: [
                  GridItem(
                    icon: Icons.bar_chart,
                    // Icoon voor statistieken
                    label: "Statistieken",
                    // Label voor statistieken
                    route: '/statistics',
                    // Route naar statistiekenpagina
                    color: Colors.green[400]!,
                    // Kleur van het item
                    user: user, // Gebruikersdata meegeven
                  ),
                  GridItem(
                    icon: Icons.leaderboard,
                    // Icoon voor klassement
                    label: "Klassement",
                    // Label voor klassement
                    route: '/leaderboard',
                    // Route naar klassementpagina
                    color: Colors.green[600]!,
                    // Kleur van het item
                    user: user, // Gebruikersdata meegeven
                  ),
                  GridItem(
                    icon: Icons.shopping_bag,
                    // Icoon voor producten
                    label: "Producten",
                    // Label voor producten
                    route: '/products',
                    // Route naar productpagina
                    color: Colors.green[500]!,
                    // Kleur van het item
                    user: user, // Gebruikersdata meegeven
                  ),
                  GridItem(
                    icon: Icons.person,
                    // Icoon voor profiel
                    label: "Profiel",
                    // Label voor profiel
                    route: '/profile',
                    // Route naar profielpagina
                    color: Colors.green[700]!,
                    // Kleur van het item
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
          Navigator.pushNamed(context, '/image_target', arguments: user);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerFloat, // Locatie van de camera-knop
    );
  }
}
