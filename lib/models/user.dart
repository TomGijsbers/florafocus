class User {
  final int id;
  String name;
  String email;
  final String password;
  List<String> scannedSeeds;
  int scannedCount = 0;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.scannedSeeds});

  // fromJson constructor om de data om te zetten
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      name: json['name'],
      scannedSeeds: (json['productSkucodes'] as List<dynamic>?)
              ?.map((item) => item as String)
              .toList() ??
          [],
    );
  }
}
