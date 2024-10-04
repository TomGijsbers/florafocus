import 'package:flutter/material.dart';

class LeaderboardItem extends StatelessWidget {
  final Map<String, dynamic> user;
  final int rank;

  const LeaderboardItem({
    Key? key,
    required this.user,
    required this.rank,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${user['first_name']} ${user['last_name']}'),
      subtitle: Text('Zaadjes gescand: ${user['scanned_seeds'].length}'),
      leading: CircleAvatar(
        child: Text(rank.toString()), // Rangnummer
      ),
    );
  }
}
