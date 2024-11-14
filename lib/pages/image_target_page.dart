import 'package:florafocus/models/product.dart';
import 'package:provider/provider.dart';

import '../api/api_service.dart'; // Import the ApiService
import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

import '../providers/user_provider.dart';
import '../widgets/product_details.dart';

class ImageTargetPage extends StatefulWidget {
  const ImageTargetPage({super.key});

  @override
  State<ImageTargetPage> createState() => _ImageTargetScreenState();
}

class _ImageTargetScreenState extends State<ImageTargetPage> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  UnityWidgetController? _unityWidgetController;
  final ApiService apiService = ApiService(); // Initialize the ApiService
  List<Product>? _products; // State variable to hold products
  List<Product>? _productsAll; // State variable to hold products

  bool _isPlaying = false; // State variable to track play state

  @override
  void initState() {
    super.initState();
    _getAllProducts(); // Call the API to get all products
  }

  @override
  void dispose() {
    _unityWidgetController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Scan je product'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 500,
            child: UnityWidget(
              onUnityCreated: _onUnityCreated,
              onUnityMessage: onUnityMessage,
              onUnitySceneLoaded: onUnitySceneLoaded,
              useAndroidViewSurface: false,
              borderRadius: const BorderRadius.all(Radius.circular(70)),
            ),
          ),
          Expanded(
            child: _products == null
                ? const Center(child: CircularProgressIndicator())
                : _products!.isEmpty
                    ? const Center(child: Text('Geen producten gevonden'))
                    : ListView.builder(
                        itemCount: _products!.length,
                        itemBuilder: (context, index) {
                          final product = _products![index];
                          return ProductCard(
                            product: product,
                            isPlaying: _isPlaying,
                            onPlayToggle: () => _togglePlay(product.skuCode),
                          );
                        },
                      ),
          )
        ],
      ),
    );
  }

  void onUnityMessage(message) {
    print('Received message from unity: ${message.toString()}');
    _isPlaying = false; // Reset the play state
    _getProductBySku(message); // Call the API when the condition is met
    _addProductToUserBySku(message); // Call the API when the condition is met
  }

  void _getProductBySku(String message) async {
    try {
      final products = await apiService.getProductBySku(message);
      setState(() {
        _products = products; // Update the state with the fetched products
      });
    } catch (error) {
      print('Error fetching products: $error');
      // Handle the error appropriately
    }
  }

  void _getAllProducts() async {
    try {
      final productsAll = await apiService.fetchProducts();
      setState(() {
        _productsAll =
            productsAll; // Update the state with the fetched products
      });
    } catch (error) {
      print('Error fetching products: $error');
      // Handle the error appropriately
    }
  }

  void _addProductToUserBySku(String sku) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      await apiService.addProductToUserBySku(sku, user.id);
    } catch (error) {
      print('Error adding product to user: $error');
      // Handle the error appropriately
    }
  }

  void onUnitySceneLoaded(SceneLoaded? scene) {
    if (scene != null) {
      print('Received scene loaded from unity: ${scene.name}');
      print('Received scene loaded from unity buildIndex: ${scene.buildIndex}');
    } else {
      print('Received scene loaded from unity: null');
    }
  }

  void _onUnityCreated(controller) {
    controller.resume();
    _unityWidgetController = controller;
  }

  void _togglePlay(String message) {
    setState(() {
      _isPlaying = !_isPlaying;
    });

    // Check if the message (SKU code) is in the list of products
    bool productExists =
        _productsAll?.any((product) => product.skuCode == message) ?? false;

    if (productExists && _unityWidgetController != null) {
      _unityWidgetController!.postMessage(
        message,
        'OnFlutterMessageReceived',
        _isPlaying ? 'Play' : 'Stop',
      );
    } else {
      print('Product with SKU $message not found in the list.');
      print(_productsAll?[0].skuCode);
    }
  }

  String _formatCategory(String category) {
    return category.split('.').last;
  }
}
