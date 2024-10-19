import 'category.dart';

class ScannedSeed {
  final String name;
  final String skuCode;
  final double price;
  final Category category;

  ScannedSeed(
      {required this.name,
      required this.skuCode,
      required this.price,
      required this.category});

  factory ScannedSeed.fromJson(Map<String, dynamic> json) {
    return ScannedSeed(
        name: json['name'],
        skuCode: json['skuCode'],
        price: json['price'],
        category: json['category']);
  }
}
