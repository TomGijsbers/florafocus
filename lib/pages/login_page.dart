import 'package:flutter/material.dart';
import '../widgets/login_text.dart'; // Zorg ervoor dat dit widget correct geïmplementeerd is
import '../api/api_service.dart'; // Importeer de ApiService
import 'home_page.dart'; // Correcte import voor HomePage
import '../pages/stats_page.dart'; // Import voor de statistiekenpagina

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ApiService apiService = ApiService(); // Initialiseer de API service
  final TextEditingController emailController =
      TextEditingController(); // Controller voor het email veld
  final TextEditingController passwordController =
      TextEditingController(); // Controller voor het wachtwoord veld

  // Functie om in te loggen
  void _login() async {
    String email = emailController.text;
    String password = passwordController.text;

    // Controleer de inloggegevens via de API
    Map<String, dynamic>? user = await apiService.loginUser(email, password);
    if (user != null) {
      // Als de inloggegevens correct zijn, navigeer naar de homepage met user data
      Navigator.pushReplacementNamed(
        context,
        '/home',
        arguments: user,
      );
    } else {
      // Toon een foutmelding als de inloggegevens onjuist zijn
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login mislukt. Controleer uw inloggegevens.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.transparent,
        elevation: 0, // Geen schaduw onder de AppBar
      ),
      body: Container(
        // Achtergrond met een kleurverloop
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.green[300]!
            ], // Wit naar groen verloop
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Uitlijning in het midden
              children: [
                SizedBox(height: 40),
                // Welkomsttekst
                Text(
                  "Welkom bij de FloraFocus",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    fontFamily: 'Montserrat',
                  ),
                ),
                SizedBox(height: 40),
                // Invoerveld voor email
                LoginTextField(
                  label: "Email",
                  controller: emailController,
                ),
                SizedBox(height: 16),
                // Invoerveld voor wachtwoord
                LoginTextField(
                  label: "Wachtwoord",
                  obscureText: true, // Verberg de tekst voor wachtwoord
                  controller: passwordController,
                ),
                SizedBox(height: 20),
                // Login knop
                ElevatedButton(
                  onPressed:
                      _login, // Login functie wordt aangeroepen bij klikken
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[600],
                    padding: EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15), // Grootte van de knop
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Afgeronde hoeken
                    ),
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  child: Text("Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
