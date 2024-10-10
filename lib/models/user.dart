class User {
  final String firstName;
  final String lastName;
  final List<ScannedSeed> scannedSeeds;

  User(
      {required this.firstName,
      required this.lastName,
      required this.scannedSeeds});

  // fromJson constructor om de data om te zetten
  factory User.fromJson(Map<String, dynamic> json) {
    var seedsFromJson = json['scannedSeeds'] as List;
    List<ScannedSeed> seedList =
        seedsFromJson.map((seed) => ScannedSeed.fromJson(seed)).toList();

    return User(
      firstName: json['firstName'],
      lastName: json['lastName'],
      scannedSeeds: seedList,
    );
  }
}

class ScannedSeed {
  final String seedName;
  final String fruitName;
  final String skuCode;

  ScannedSeed(
      {required this.seedName, required this.fruitName, required this.skuCode});

  factory ScannedSeed.fromJson(Map<String, dynamic> json) {
    return ScannedSeed(
      seedName: json['seedName'],
      fruitName: json['fruitName'],
      skuCode: json['skuCode'],
    );
  }
}
