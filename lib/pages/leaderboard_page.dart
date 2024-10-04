import 'package:flutter/material.dart';
import '../api/api_service.dart'; // Zorg ervoor dat je dit pad hebt ingesteld
import 'package:flutter/material.dart';

class LeaderboardPage extends StatefulWidget {
  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  final ApiService _apiService = ApiService();
  List<Map<String, dynamic>> _users = [];
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    try {
      List<Map<String, dynamic>> users = await _apiService.fetchUsers();
      // Tel het aantal gescande zaden en voeg het toe aan een lijst
      users.forEach((user) {
        user['scanned_count'] = user['scanned_seeds']?.length ?? 0;
      });
      // Sorteer gebruikers op basis van het aantal gescande zaden, aflopend
      users.sort((a, b) => b['scanned_count'].compareTo(a['scanned_count']));
      setState(() {
        _users = users;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Fout bij het ophalen van gebruikers: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Klassement"),
      ),
      body: _errorMessage.isNotEmpty
          ? Center(child: Text(_errorMessage))
          : ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                final user = _users[index];
                return ListTile(
                  title: Text('${user['first_name']} ${user['last_name']}'),
                  subtitle: Text('Gescanden zaden: ${user['scanned_count']}'),
                  leading: CircleAvatar(
                    child: Text('${index + 1}'), // Rangnummer
                  ),
                );
              },
            ),
    );
  }
}
