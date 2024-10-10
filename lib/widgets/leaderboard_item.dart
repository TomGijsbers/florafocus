import 'package:flutter/material.dart';

class LeaderboardItem extends StatelessWidget {
  final Map<String, dynamic> user; // Gebruikersinformatie
  final int rank; // De rang van de gebruiker in het klassement

  const LeaderboardItem({
    Key? key,
    required this.user,
    required this.rank,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: 8.0, horizontal: 16.0), // Buitenruimte rondom het item
      padding: EdgeInsets.all(16.0), // Binnenruimte binnen het item
      decoration: BoxDecoration(
        color: Colors.green[50], // Achtergrondkleur van het item
        borderRadius: BorderRadius.circular(10), // Afgeronde hoeken
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Schaduw rondom het item
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // Positie van de schaduw
          ),
        ],
      ),
      child: Row(
        children: [
          // Toon de rang van de gebruiker in een cirkel
          CircleAvatar(
            backgroundColor:
                Colors.green[700], // Achtergrondkleur van de cirkel
            child: Text(
              rank.toString(), // Rangnummer
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
          SizedBox(width: 16.0), // Ruimte tussen de cirkel en de tekst
          // Toon de naam van de gebruiker en het aantal gescande zaadjes
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${user['first_name']} ${user['last_name']}', // Naam van de gebruiker
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.green[900],
                  fontFamily: 'Montserrat',
                ),
              ),
              Text(
                'Zaadjes gescand: ${user['scanned_seeds'].length}', // Aantal gescande zaadjes
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.green[700],
                  fontFamily: 'Montserrat',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
