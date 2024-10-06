import 'package:flutter/material.dart';
import 'pages/login_page.dart'; // Ensure this import is correct
import 'pages/home_page.dart';
import 'pages/profile_page.dart';
import 'pages/stats_page.dart';
import 'pages/leaderboard_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) =>
            LoginPage(), // Ensure LoginPage is correctly referenced
        '/profile': (context) => ProfilePage(
            user: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        '/leaderboard': (context) => LeaderboardPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/home') {
          final user = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => HomePage(user: user),
          );
        } else if (settings.name == '/statistics') {
          final user = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => StatisticsPage(user: user),
          );
        }
        return null;
      },
    );
  }
}
