import 'package:florafocus/models/user.dart';
import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../models/product.dart';
import '/widgets/statistics_header.dart';

class StatisticsPage extends StatefulWidget {
  final User user;

  const StatisticsPage({super.key, required this.user});

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  List<String>? _productSkucodes;
  List<Product>? _products; // State variable to hold products
  final ApiService apiService =
      ApiService(); // Instantieer ApiService voor API-aanroepen

  @override
  void initState() {
    super.initState();
    _fetchProductSkucodes(); // Haal de SKU-codes op wanneer de pagina wordt geladen
    _getAllProducts(); // Haal alle producten op wanneer de pagina wordt geladen
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
              child: ListView.builder(
                itemCount: _products?.length ?? 0, // Aantal items in de lijst
                itemBuilder: (context, index) {
                  var product = _products![index]; // Haal het product op
                  bool hasProduct =
                      _productSkucodes?.contains(product.skuCode) ?? false;

                  return Card(
                    color: Colors.green[100],
                    // Achtergrondkleur van de kaart
                    elevation: 4,
                    // Hoogte-effect voor de kaart
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12), // Afronden van de hoeken
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    // Ruimte tussen de kaarten
                    child: ListTile(
                      title: Text(
                        product.skuCode, // Toon de SKU-code in de titel
                        style: TextStyle(
                          color: Colors.green[800], // Tekstkleur
                          fontFamily: 'Roboto',
                        ),
                      ),
                      leading: Icon(
                        hasProduct ? Icons.check_circle : Icons.circle,
                        // Icoon aan de linkerkant
                        color: hasProduct
                            ? Colors.green[700]
                            : Colors.red[700], // Kleur van het icoon
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _fetchProductSkucodes() async {
    final products = await apiService.fetchUserProducts(widget.user.id);
    setState(() {
      _productSkucodes = products.map((product) => product.skuCode).toList();
    });
  }

  void _getAllProducts() async {
    try {
      final products = await apiService.fetchProducts();
      setState(() {
        _products = products; // Update the state with the fetched products
      });
    } catch (error) {
      print('Error fetching products: $error');
      // Handle the error appropriately
    }
  }
}
