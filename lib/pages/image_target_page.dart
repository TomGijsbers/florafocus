import '../api/api_service.dart'; // Import the ApiService
import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class ImageTargetPage extends StatefulWidget {
  const ImageTargetPage({Key? key}) : super(key: key);

  @override
  State<ImageTargetPage> createState() => _ImageTargetScreenState();
}

class _ImageTargetScreenState extends State<ImageTargetPage> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  UnityWidgetController? _unityWidgetController;
  final ApiService apiService = ApiService(); // Initialize the ApiService
  List<Map<String, dynamic>>? _products; // State variable to hold products
  bool _isPlaying = false; // State variable to track play state

  @override
  void initState() {
    super.initState();
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
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  contentPadding: const EdgeInsets.all(15),
                                  title: Text(
                                    product['name'],
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.green[900],
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Category: ${product['category']}\nPrice: \$${product['price']}',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14,
                                      color: Colors.green[700],
                                    ),
                                  ),
                                  trailing: Text(
                                    'SKU: ${product['skuCode']}',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 12,
                                      color: Colors.green[500],
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () =>
                                      _togglePlay(product['skuCode']),
                                  child: Text(_isPlaying ? 'Stop' : 'Play'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  void onUnityMessage(message) {
    print('Received message from unity: ${message.toString()}');
    _isPlaying = false; // Reset the play state
    _fetchProducts(message); // Call the API when the condition is met
  }

  void _fetchProducts(message) async {
    try {
      final products = await apiService.fetchProductBySku(message);
      setState(() {
        _products = products; // Update the state with the fetched products
      });
    } catch (error) {
      print('Error fetching products: $error');
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

  void _showImageScannedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Image Scanned'),
          content: const Text('An image has been successfully scanned.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _togglePlay(message) {
    setState(() {
      _isPlaying = !_isPlaying;
    });

    if (_unityWidgetController != null) {
      if (message == 'APPLE001') {
        _unityWidgetController!.postMessage(
          'APPLE001',
          'OnFlutterMessageReceived',
          _isPlaying ? 'Play' : 'Stop',
        );
      } else if (message == 'PEAR001') {
        _unityWidgetController!.postMessage(
          'PEAR001',
          'OnFlutterMessageReceived',
          _isPlaying ? 'Play' : 'Stop',
        );
      }
    }
  }
}
