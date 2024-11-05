import 'category.dart';

class Product {
  final String name;
  final String skuCode;
  final double price;
  final Category category;

  Product(
      {required this.name,
      required this.skuCode,
      required this.price,
      required this.category});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      skuCode: json['skuCode'],
      price: (json['price'] as num).toDouble(),
      category: _categoryFromString(
          json['category']), // Parse category as Category enum
    );
  }

  static Category _categoryFromString(String category) {
    switch (category) {
      case 'VEGETABLE':
        return Category.VEGETABLE;
      case 'FRUIT':
        return Category.FRUIT;
      case 'FLOWER':
        return Category.FLOWER;
      default:
        throw Exception('Unknown category: $category');
    }
  }

  String categoryToString(Category category) {
    return category.toString().split('.').last;
  }
}
