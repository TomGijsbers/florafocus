import 'package:florafocus/models/product.dart';
import 'package:flutter/material.dart';
import '../api/api_service.dart'; // Importeer de ApiService

class ProductsPage extends StatelessWidget {
  final ApiService apiService = ApiService();

  ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Producten",
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        backgroundColor: Colors.green[700],
      ),
      body: FutureBuilder<List<Product>>(
        future: apiService.fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Geen producten gevonden'));
          } else {
            final products = snapshot.data!;
            products.sort((a, b) => a.name
                .compareTo(b.name)); // Sort products alphabetically by name
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(15),
                    title: Text(
                      product.name,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.green[900],
                      ),
                    ),
                    subtitle: Text(
                      'Category: ${product.categoryToString(product.category)}\nPrice: €${product.price}',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        color: Colors.green[700],
                      ),
                    ),
                    trailing: Text(
                      'SKU: ${product.skuCode}',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                        color: Colors.green[500],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
