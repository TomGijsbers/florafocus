import 'package:flutter/material.dart';
import '/widgets/statistics_header.dart';

class StatisticsPage extends StatelessWidget {
  final Map<String, dynamic> user;

  StatisticsPage({required this.user});

  @override
  Widget build(BuildContext context) {
    List<dynamic> scannedSeeds = user['scanned_seeds'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Statistieken',
          style: TextStyle(fontFamily: 'Roboto'),
        ),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StatisticsHeader(
              text: "Hier zijn je statistieken van de gescande zaadjes.",
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: scannedSeeds.length,
                itemBuilder: (context, index) {
                  var seed = scannedSeeds[index];

                  return Card(
                    color: Colors.green[100],
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      title: Text(
                        seed['seed_name'],
                        style: TextStyle(
                          color: Colors.green[800],
                          fontFamily: 'Roboto',
                        ),
                      ),
                      subtitle: Text(
                        "Fruit: ${seed['fruit_name']}\nSKU: ${seed['sku_code']}",
                        style: TextStyle(
                          color: Colors.green[600],
                          fontFamily: 'Roboto',
                        ),
                      ),
                      leading: Icon(
                        Icons.check_circle,
                        color: Colors.green[700],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
