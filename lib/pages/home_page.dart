import 'package:flutter/material.dart';
import '../widgets/camera_button.dart';

class HomePage extends StatelessWidget {
  final Map<String, dynamic> user;

  HomePage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welkom bij de FloraFocus",
            style: TextStyle(fontFamily: 'Roboto')),
        centerTitle: true,
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Welkom op de homepage! Gebruik de onderstaande knoppen om de verschillende functies van de app te verkennen.",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.green[900],
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
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
          // Je kunt hier ook navigeren naar een andere pagina, bijvoorbeeld:
          // Navigator.pushNamed(context, '/camera');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class GridItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String route;
  final Color color;

  GridItem({
    required this.icon,
    required this.label,
    required this.route,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.white),
            SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontFamily: 'Montserrat',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
