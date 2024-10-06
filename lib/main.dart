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
        '/home': (context) => HomePage(user: {'name': 'gebruiker'}),
        '/profile': (context) => ProfilePage(),
        '/statistics': (context) => StatisticsPage(),
        '/leaderboard': (context) => LeaderboardPage(),
      },
    );
  }
}
