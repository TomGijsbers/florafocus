import 'package:florafocus/models/user.dart';
import 'package:flutter/material.dart'; // Importeer de Flutter-material design bibliotheek

class GridItem extends StatelessWidget {
  final IconData icon; // Icon voor de grid item
  final String label; // Label voor de grid item
  final String route; // Route voor navigatie bij het klikken
  final Color color; // Kleur van het icoon
  final User user; // Add user data

  GridItem({
    required this.icon,
    required this.label,
    required this.route,
    required this.color,
    required this.user, // Add user data
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          route,
          arguments: user, // Pass user data
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontFamily: 'Montserrat',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
