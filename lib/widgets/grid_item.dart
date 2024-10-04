import 'package:flutter/material.dart'; // Importeer de Flutter-material design bibliotheek

class GridItem extends StatelessWidget {
  final IconData icon; // Icon voor de grid item
  final String label; // Label voor de grid item
  final String route; // Route voor navigatie bij het klikken
  final Color color; // Kleur van het icoon

  // Constructor voor de GridItem widget
  const GridItem({
    required this.icon, // Icon is verplicht
    required this.label, // Label is verplicht
    required this.route, // Route is verplicht
    required this.color, // Kleur is verplicht
    Key? key, // Sleutel voor widget identificatie (optioneel)
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Bouw de UI van het GridItem
    return GestureDetector(
      onTap: () {
        // Navigeren naar de opgegeven route wanneer het item wordt aangeraakt
        if (ModalRoute.of(context)?.settings.name != route) {
          Navigator.pushNamed(context, route);
        }
      },
      child: Card(
        elevation: 6, // Schaduw voor diepte-effect
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)), // Afgeronde hoeken
        color: Colors.green[100], // Achtergrondkleur van het kaartje
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Centreer de inhoud van de kolom
          children: [
            Icon(icon, size: 48, color: color), // Toon het icoon
            SizedBox(height: 8), // Ruimte tussen icoon en label
            Text(label,
                style: TextStyle(
                    fontSize: 18, color: Colors.green[900])), // Toon het label
          ],
        ),
      ),
    );
  }
}
