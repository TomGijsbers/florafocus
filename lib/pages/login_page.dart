import 'package:flutter/material.dart';
import '../widgets/login_text.dart'; // Ensure this widget is correctly implemented
import '../api/api_service.dart';
import 'home_page.dart'; // Correct import for HomePage

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ApiService apiService = ApiService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login() async {
    String email = emailController.text;
    String password = passwordController.text;

    Map<String, dynamic>? user = await apiService.loginUser(email, password);
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(user: user),
        ),
      );
    } else {
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
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.green[300]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40),
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
                LoginTextField(
                  label: "Email",
                  controller: emailController,
                ),
                SizedBox(height: 16),
                LoginTextField(
                  label: "Wachtwoord",
                  obscureText: true,
                  controller: passwordController,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[600],
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
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

// API service
// import 'package:flutter/material.dart';
// import '../widgets/login_text.dart';
// import '../api/api_service.dart';
// import '../pages/home_page.dart'; // Importeer je HomePage bestand

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
// class _LoginPageState extends State<LoginPage> {
//   final ApiService apiService = ApiService();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   void _login() async {
//     String email = emailController.text;
//     String password = passwordController.text;

//     Map<String, dynamic>? user = await apiService.loginUser(email, password);
//     if (user != null) {
//       // Als de login succesvol is, navigeer naar de HomePage met de gebruikersdata
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => HomePage(user: user), // Geef de user-informatie door
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Login mislukt. Controleer uw inloggegevens.')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Login"),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Colors.white,
//               Colors.green[300]!,
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         padding: EdgeInsets.all(16.0),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(height: 40),
//                 Text(
//                   "Welkom bij de FloraFocus",
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black87,
//                     fontFamily: 'Montserrat',
//                   ),
//                 ),
//                 SizedBox(height: 40),
//                 LoginTextField(
//                   label: "Email",
//                   controller: emailController,
//                 ),
//                 SizedBox(height: 16),
//                 LoginTextField(
//                   label: "Wachtwoord",
//                   obscureText: true,
//                   controller: passwordController,
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: _login,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green[600],
//                     padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     textStyle: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'Roboto',
//                     ),
//                   ),
//                   child: Text("Login"),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }





///// OUD FABERYAYO OLD


// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final ApiService apiService = ApiService();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   void _login() async {
//     String email = emailController.text;
//     String password = passwordController.text;

//     bool success = await apiService.loginUser(email, password);
//     if (success) {
//       Navigator.pushReplacementNamed(context, '/home');
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Login mislukt. Controleer uw inloggegevens.')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Login"),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Colors.white,
//               Colors.green[300]!,
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         padding: EdgeInsets.all(16.0),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(height: 40),
//                 Text(
//                   "Welkom bij de FloraFocus",
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black87,
//                     fontFamily: 'Montserrat',
//                   ),
//                 ),
//                 SizedBox(height: 40),
//                 LoginTextField(
//                   label: "Email",
//                   controller: emailController, // Controller voor email
//                 ),
//                 SizedBox(height: 16),
//                 LoginTextField(
//                   label: "Wachtwoord",
//                   obscureText: true,
//                   controller: passwordController, // Controller voor wachtwoord
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: _login,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green[600],
//                     padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     textStyle: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'Roboto',
//                     ),
//                   ),
//                   child: Text("Login"),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
