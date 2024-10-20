import 'package:flutter/material.dart';

import 'pages/login_page.dart'; // Zorg ervoor dat deze import correct is
import 'pages/home_page.dart';
import 'pages/profile_page.dart';
import 'pages/stats_page.dart';
import 'pages/leaderboard_page.dart';
import 'pages/products_page.dart'; // Importeer de ProductsPage
import 'pages/image_target_page.dart'; // Importeer de ImageTargetPage

// Hoofdfunctie om de app te starten
void main() {
  runApp(MyApp()); // Start de MyApp klasse
}

// Hoofdapplicatieklasse
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Verberg de debug banner
      initialRoute: '/', // Stel de initiële route in op de loginpagina
      routes: {
        '/': (context) =>
            LoginPage(), // Verwijs naar de LoginPage als de initiële route
        '/profile': (context) => ProfilePage(
            user: ModalRoute.of(context)!.settings.arguments as Map<String,
                dynamic>), // Haal de gebruikersdata op uit de instellingen van de route
        '/leaderboard': (context) =>
            LeaderboardPage(), // Verwijs naar de LeaderboardPage
        '/products': (context) =>
            ProductsPage(), // Verwijs naar de ProductsPage
        '/image_target': (context) =>
            ImageTargetPage(), // Verwijs naar de ImageTargetPage
      },
      // Dynamisch routes genereren
      onGenerateRoute: (settings) {
        if (settings.name == '/home') {
          final user = settings.arguments
              as Map<String, dynamic>; // Haal gebruikersdata op
          return MaterialPageRoute(
            builder: (context) =>
                HomePage(user: user), // Bouw de HomePage met gebruikersdata
          );
        } else if (settings.name == '/statistics') {
          final user = settings.arguments
              as Map<String, dynamic>; // Haal gebruikersdata op
          return MaterialPageRoute(
            builder: (context) => StatisticsPage(
                user: user), // Bouw de StatisticsPage met gebruikersdata
          );
        }
        return null; // Retourneer null als er geen overeenkomende route is
      },
    );
  }
}
