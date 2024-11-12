import 'package:florafocus/models/user.dart';
import 'package:florafocus/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/login_text.dart';
import '../api/api_service.dart';
import 'home_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ApiService apiService = ApiService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _createAccountFormKey = GlobalKey<FormState>();
  final TextEditingController newEmailController = TextEditingController();
  final TextEditingController newNameController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Voer een e-mailadres in';
    } else if (!_isValidEmail(value)) {
      return 'Ongeldig e-mailadres';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Voer een wachtwoord in';
    }
    return null;
  }

  String? _validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Voer een wachtwoord in';
    } else if (value.length < 6) {
      return 'Wachtwoord moet minimaal 6 tekens bevatten';
    }
    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Voer een naam in';
    }
    return null;
  }

  bool _isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  void _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      String email = emailController.text;
      String password = passwordController.text;

      User? user = await apiService.loginUser(email, password);
      if (!mounted) return;

      if (user != null) {
        Provider.of<UserProvider>(context, listen: false).setUser(user);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login mislukt. Controleer uw inloggegevens.'),
          ),
        );
      }
    }
  }

  void _createAccount() async {
    if (_createAccountFormKey.currentState?.validate() ?? false) {
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
            content:
                Text('Account succesvol aangemaakt. Log in om verder te gaan.'),
          ),
        );
        Navigator.of(context).pop();
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
            child: Form(
              key: _createAccountFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LoginTextField(
                    label: "Email",
                    controller: newEmailController,
                    validator: _validateEmail,
                  ),
                  const SizedBox(height: 16),
                  LoginTextField(
                    label: "Naam",
                    controller: newNameController,
                    validator: _validateName,
                  ),
                  const SizedBox(height: 16),
                  LoginTextField(
                    label: "Wachtwoord",
                    obscureText: true,
                    controller: newPasswordController,
                    validator: _validateNewPassword,
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
              child: const Text(
                'Aanmaken',
                style: TextStyle(color: Colors.white),
              ),
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
        title: const Text(
          "Login",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green[600],
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
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    validator: _validateEmail,
                  ),
                  const SizedBox(height: 16),
                  LoginTextField(
                    label: "Wachtwoord",
                    obscureText: true,
                    controller: passwordController,
                    validator: _validatePassword,
                  ),
                  const SizedBox(height: 16),
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
                    child: const Text(
                      'Inloggen',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: _showCreateAccountDialog,
                    child: const Text(
                      'Geen account? Maak een nieuw account aan',
                      style: TextStyle(color: Colors.white),
                    ),
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
