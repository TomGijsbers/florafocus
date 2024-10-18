import 'product.dart';

class User {
  final String name;
  final String email;
  final String password;
  final List<ScannedSeed> scannedSeeds;

  User(
      {required this.name,
      required this.email,
      required this.password,
      required this.scannedSeeds});

  // fromJson constructor om de data om te zetten
  factory User.fromJson(Map<String, dynamic> json) {
    var seedsFromJson = json['productSkucodes'] as List;
    List<ScannedSeed> seedList =
        seedsFromJson.map((seed) => ScannedSeed.fromJson(seed)).toList();

    return User(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      scannedSeeds: seedList,
    );
  }
}
