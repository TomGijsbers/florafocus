import 'package:flutter/material.dart';
import '../widgets/login_text.dart';
import '../api/api_service.dart';
import 'home_page.dart';
import '../pages/stats_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ApiService apiService = ApiService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Sleutel voor het login-formulier
  String? passwordError; // Variabele voor foutmelding van wachtwoord

  // Controllers voor het nieuwe account aanmaken
  final TextEditingController newEmailController = TextEditingController();
  final TextEditingController newNameController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final GlobalKey<FormState> _createAccountFormKey =
      GlobalKey<FormState>(); // Sleutel voor het aanmaak-formulier

  void _login() async {
    setState(() {
      passwordError = null; // Reset de foutmelding bij elke poging
    });

    if (_formKey.currentState!.validate()) {
      // Alleen als het login-formulier geldig is, proberen we in te loggen
      String email = emailController.text;
      String password = passwordController.text;

      Map<String, dynamic>? user = await apiService.loginUser(email, password);
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage(user: user)),
        );
      } else {
        setState(() {
          passwordError = 'Onjuist wachtwoord'; // Stel de foutmelding in
        });
      }
    }
  }

  bool _isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  void _createAccount() async {
    if (_createAccountFormKey.currentState!.validate()) {
      // Alleen als het aanmaak-formulier geldig is, proberen we een nieuw account aan te maken
      String email = newEmailController.text;
      String name = newNameController.text;
      String password = newPasswordController.text;

      var response = await http.post(
        Uri.parse('http://docker.taile0d53a.ts.net:8084/users'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'name': name,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'Account succesvol aangemaakt. Log in om verder te gaan.')),
        );
        Navigator.of(context).pop(); // Sluit het aanmaak-dialoog
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account aanmaken mislukt.')),
        );
      }
    }
  }

  void _showCreateAccountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Maak een nieuw account aan'),
          content: SingleChildScrollView(
            // Zorgt voor scrollbaarheid
            child: Form(
              key:
                  _createAccountFormKey, // Formulier-sleutel voor het aanmaak-formulier
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: newEmailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Voer een e-mailadres in';
                      } else if (!_isValidEmail(value)) {
                        return 'Voer een geldig e-mailadres in';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: newNameController,
                    decoration: const InputDecoration(labelText: 'Naam'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Voer een naam in';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: newPasswordController,
                    decoration: const InputDecoration(labelText: 'Wachtwoord'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Voer een wachtwoord in';
                      } else if (value.length < 6) {
                        return 'Wachtwoord moet minimaal 6 tekens bevatten';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annuleren'),
            ),
            ElevatedButton(
              onPressed: _createAccount,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[600],
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
              child: const Text('Aanmaken'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.green[300]!,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey, // Formulier-sleutel voor het login-formulier
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    "Welkom bij de FloraFocus",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Voer een e-mailadres in';
                      } else if (!_isValidEmail(value)) {
                        return 'Voer een geldig e-mailadres in';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Wachtwoord',
                      errorText: passwordError, // Toont dynamische foutmelding
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Voer een wachtwoord in';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[600],
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    child: const Text("Login"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _showCreateAccountDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[600],
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    child: const Text("Maak een nieuw account aan"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
