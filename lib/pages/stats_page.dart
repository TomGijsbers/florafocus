import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '/widgets/statistics_header.dart';

class StatisticsPage extends StatefulWidget {
  final Map<String, dynamic> user;

  StatisticsPage({required this.user});

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  List<dynamic> productSkucodes = [];
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() async {
    Map<String, dynamic>? user =
        await apiService.fetchUserDataByName(widget.user['name']);
    if (user != null) {
      setState(() {
        productSkucodes = user['productSkucodes'] ?? [];
      });
      print(
          'User data updated: ${user['name']}, Product SKU Codes: $productSkucodes'); // Debug print
    }
  }

  @override
  Widget build(BuildContext context) {
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
              text: "Hier zijn je statistieken van de gescande producten.",
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: productSkucodes.length,
                itemBuilder: (context, index) {
                  var skuCode = productSkucodes[index];

                  return Card(
                    color: Colors.green[100],
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      title: Text(
                        skuCode,
                        style: TextStyle(
                          color: Colors.green[800],
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
