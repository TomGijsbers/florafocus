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

  // Controllers for new account creation
  final TextEditingController newEmailController = TextEditingController();
  final TextEditingController newNameController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  void _login() async {
    String email = emailController.text;
    String password = passwordController.text;

    Map<String, dynamic>? user = await apiService.loginUser(email, password);
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage(user: user)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Login mislukt. Controleer uw inloggegevens.')),
      );
    }
  }

  bool _isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  void _createAccount() async {
    String email = newEmailController.text;
    String name = newNameController.text;
    String password = newPasswordController.text;

    if (!_isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ongeldig e-mailadres.')),
      );
      return;
    }

    var response = await http.post(
      Uri.parse('http://docker.taile0d53a.ts.net:8083/api/user'), // Updated URL
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
      Navigator.of(context).pop(); // Close the create account dialog
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account aanmaken mislukt.')),
      );
    }
  }

  void _showCreateAccountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Maak een nieuw account aan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LoginTextField(
                label: "Email",
                controller: newEmailController,
              ),
              const SizedBox(height: 16),
              LoginTextField(
                label: "Naam",
                controller: newNameController,
              ),
              const SizedBox(height: 16),
              LoginTextField(
                label: "Wachtwoord",
                obscureText: true,
                controller: newPasswordController,
              ),
            ],
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
                LoginTextField(
                  label: "Email",
                  controller: emailController,
                ),
                const SizedBox(height: 16),
                LoginTextField(
                  label: "Wachtwoord",
                  obscureText: true,
                  controller: passwordController,
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
    );
  }
}
