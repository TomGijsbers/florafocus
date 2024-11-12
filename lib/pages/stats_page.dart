import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../api/api_service.dart';
import '../models/product.dart';
import '/widgets/statistics_header.dart';

class StatisticsPage extends StatelessWidget {
  StatisticsPage({super.key});

  final ApiService apiService = ApiService();

  Future<List<Product>> _fetchAllProducts() async {
    return await apiService.fetchProducts();
  }

  Future<List<String>> _fetchProductSkucodes(BuildContext context) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    final products = await apiService.fetchUserProducts(user.id);
    return products.map((product) => product.skuCode).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistieken',
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding rondom de inhoud
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StatisticsHeader(
              text:
                  "Hier zijn je statistieken van de gescande producten.", // Toon de statistieken header
            ),
            const SizedBox(height: 20), // Ruimte tussen de header en de lijst
            Expanded(
              child: FutureBuilder<List<Product>>(
                future: _fetchAllProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No products found.'));
                  } else {
                    final products = snapshot.data!;
                    return FutureBuilder<List<String>>(
                      future: _fetchProductSkucodes(context),
                      builder: (context, skuSnapshot) {
                        if (skuSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (skuSnapshot.hasError) {
                          return Center(
                              child: Text('Error: ${skuSnapshot.error}'));
                        } else if (!skuSnapshot.hasData ||
                            skuSnapshot.data!.isEmpty) {
                          return const Center(
                              child: Text('No scanned products found.'));
                        } else {
                          final productSkucodes = skuSnapshot.data!;
                          return ListView.builder(
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              var product = products[index];
                              bool hasProduct =
                                  productSkucodes.contains(product.skuCode);

                              return Card(
                                color: Colors.green[100],
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: ListTile(
                                  title: Text(
                                    product.skuCode,
                                    style: TextStyle(
                                      color: Colors.green[800],
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                  leading: Icon(
                                    hasProduct
                                        ? Icons.check_circle
                                        : Icons.circle,
                                    color: hasProduct
                                        ? Colors.green[700]
                                        : Colors.red[700],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
