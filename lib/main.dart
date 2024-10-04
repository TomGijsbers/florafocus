import 'package:flutter/material.dart';
import 'pages/login_page.dart'; // Controleer of dit pad klopt
import 'pages/home_page.dart'; // Controleer of dit pad klopt
import 'pages/profile_page.dart';
import 'pages/stats_page.dart'; // Controleer of dit pad klopt

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
        '/': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/profile': (context) => ProfilePage(),
        '/statistics': (context) => StatisticsPage(),
      },
    );
  }
}
