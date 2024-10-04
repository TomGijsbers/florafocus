import 'package:flutter/material.dart'; // Importeer de Flutter-material design bibliotheek
import '/widgets/login_text.dart'; // Importeer de aangepaste LoginTextField widget

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Bouw de UI van de LoginPage
    return Scaffold(
      // Gebruik een Scaffold voor de basisstructuur
      appBar: AppBar(
        title: Text("Login"), // Titel van de app-balk
        backgroundColor: Colors
            .transparent, // Maak de achtergrond van de app-balk transparant
        elevation: 0, // Geen schaduw onder de app-balk
      ),
      body: Container(
        // Hoofdinhoud van de pagina
        decoration: BoxDecoration(
          // Voeg een gradient achtergrond toe
          gradient: LinearGradient(
            colors: [
              Colors.white, // Begin kleur van de gradient
              Colors.green[300]!, // Eind kleur van de gradient (groene tint)
            ],
            begin: Alignment.topLeft, // Beginpunt van de gradient
            end: Alignment.bottomRight, // Eindpunt van de gradient
          ),
        ),
        padding: EdgeInsets.all(16.0), // Voeg padding toe rondom de inhoud
        child: Center(
          // Center de inhoud binnen de container
          child: SingleChildScrollView(
            // Maak de inhoud scrollbaar
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Centreer de kinderen in de kolom
              children: [
                SizedBox(height: 40), // Voeg een lege ruimte toe bovenaan
                Text(
                  "Welkom bij de FloraFocus", // Welkomstbericht
                  style: TextStyle(
                    fontSize: 28, // Lettergrootte
                    fontWeight: FontWeight.w600, // Vetgedrukt
                    color: Colors.black87, // Kleur van de tekst
                    fontFamily:
                        'Montserrat', // Gebruik het Montserrat lettertype
                  ),
                ),
                SizedBox(height: 40), // Voeg ruimte toe na de tekst
                LoginTextField(
                    label: "Email"), // Aangepast invoerveld voor e-mail
                SizedBox(height: 16), // Ruimte tussen de invoervelden
                LoginTextField(
                    label: "Wachtwoord",
                    obscureText:
                        true), // Aangepast invoerveld voor wachtwoord (verborgen tekst)
                SizedBox(height: 20), // Ruimte voor de knop
                ElevatedButton(
                  // Login-knop
                  onPressed: () {
                    // Actie bij het indrukken van de knop
                    Navigator.pushReplacementNamed(
                        context, '/home'); // Navigeer naar de homepage
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.green[600], // Groene kleur voor de knop
                    padding: EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15), // Padding voor de knop
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Afgeronde hoeken van de knop
                    ),
                    textStyle: TextStyle(
                      fontSize: 18, // Lettergrootte van de tekst op de knop
                      fontWeight: FontWeight.bold, // Vetgedrukt
                      fontFamily:
                          'Roboto', // Gebruik het Roboto lettertype voor de knop
                    ),
                  ),
                  child: Text("Login"), // Tekst op de knop
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
