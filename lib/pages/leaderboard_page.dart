import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../widgets/leaderboard_item.dart'; // Import LeaderboardItem widget

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
      users.forEach((user) {
        user['scanned_count'] = user['scanned_seeds']?.length ?? 0;
      });
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
        title: Text(
          "Klassement",
          style: TextStyle(fontFamily: 'Roboto'),
        ),
        backgroundColor: Colors.green[700],
        centerTitle: true,
      ),
      body: _errorMessage.isNotEmpty
          ? Center(
              child: Text(
                _errorMessage,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                  fontFamily: 'Montserrat',
                ),
              ),
            )
          : ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                final user = _users[index];
                return LeaderboardItem(
                  user: user,
                  rank: index + 1,
                );
              },
            ),
    );
  }
}
