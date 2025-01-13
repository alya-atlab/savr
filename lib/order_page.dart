import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderPage extends StatefulWidget {
  final int bagId;
  final String bagName;
  final String bagImage;
  final String restaurantName;
  final int userId;

  const OrderPage({
    Key? key,
    required this.bagId,
    required this.bagName,
    required this.bagImage,
    required this.restaurantName,
    required this.userId,
  }) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int availableQuantity = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAvailableQuantity();
  }

  Future<void> fetchAvailableQuantity() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://192.168.1.8/savr/mobile/get_available_quantity.php?bag_id=${widget.bagId}'),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['success'] == true) {
        setState(() {
          availableQuantity = data['available_quantity'];
          isLoading = false;
        });
      } else {
        throw Exception(data['message'] ?? 'Failed to fetch quantity');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching quantity: $e")),
      );
    }
  }

  Future<void> placeOrder() async {
    final url = 'http://192.168.1.8/savr/mobile/place_order.php';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'bag_id': widget.bagId,
          'user_id': widget.userId,
          'quantity': 1, // Fixed quantity to 1
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['message'])),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['message'] ?? 'Order failed')),
          );
        }
      } else {
        throw Exception('Failed to place order: ${response.reasonPhrase}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error placing order: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      appBar: AppBar(
        title: const Text("Order Bag",
            style: TextStyle(
              color: Colors.white,
            )),
        backgroundColor: Color(0xFF007E6C),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.bagImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Content Section
                  Container(
                    color: const Color(0xFFEFEFEF),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.bagName,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "by ${widget.restaurantName}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Quantity available: $availableQuantity",
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            onPressed:
                                availableQuantity > 0 ? placeOrder : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 20,
                              ),
                            ),
                            child: const Text(
                              "Order Bag",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
