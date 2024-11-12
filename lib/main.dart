import 'package:florafocus/models/user.dart';
import 'package:flutter/material.dart';

import 'pages/login_page.dart'; // Zorg ervoor dat deze import correct is
import 'pages/home_page.dart';
import 'pages/profile_page.dart';
import 'pages/stats_page.dart';
import 'pages/leaderboard_page.dart';
import 'pages/products_page.dart'; // Importeer de ProductsPage
import 'pages/image_target_page.dart'; // Importeer de ImageTargetPage
import 'providers/user_provider.dart';
import 'package:provider/provider.dart';

// Hoofdfunctie om de app te starten
void main() {
  runApp(MyApp()); // Start de MyApp klasse
}

// Hoofdapplicatieklasse
class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => UserProvider(User(
              id: 0,
              name: '',
              email: '',
              password: '',
              scannedProducts: [],
            )),
        child: MaterialApp(
          debugShowCheckedModeBanner: false, // Verberg de debug banner
          initialRoute: '/', // Stel de initiële route in op de loginpagina
          routes: {
            '/': (context) => const LoginPage(),
            // Verwijs naar de LoginPage als de initiële route
            '/profile': (context) => ProfilePage(),
            // Haal de gebruikersdata op uit de instellingen van de route
            '/leaderboard': (context) => LeaderboardPage(),
            // Verwijs naar de LeaderboardPage
            '/products': (context) => ProductsPage(),
            // Verwijs naar de ProductsPage
            '/image_target': (context) => ImageTargetPage(),
            // Verwijs naar de ImageTargetPage
            '/home': (context) => HomePage(),
            // Bouw de HomePage met gebruikersdata
            '/statistics': (context) => StatisticsPage(),
            // Bouw de StatisticsPage met gebruikersdata
          },
        ));
  }
}
