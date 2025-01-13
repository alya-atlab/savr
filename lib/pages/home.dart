import 'package:flutter/material.dart';
import '../api_services/order_service.dart';
import '../api_services/category_service.dart';

class HomePage extends StatefulWidget {
  final int userId;

  const HomePage({Key? key, required this.userId}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic>? currentOrder;
  List<Map<String, dynamic>> categories = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      // final orderData = await OrderService.fetchCurrentOrder(widget.userId);
      final categoryData = await CategoryService.fetchCategories();

      setState(() {
        // currentOrder = orderData.isNotEmpty ? orderData[0] : null;
        categories = categoryData;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0FFFD),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildGreetingSection(),
                  const SizedBox(height: 20),
                  currentOrder != null && currentOrder!.isNotEmpty
                      ? _buildCurrentOrderSection()
                      : const Text(
                          "You don't have any current orders.",
                          style: TextStyle(
                            color: Color(0xFF007E6C),
                            fontSize: 16,
                          ),
                        ),
                  const SizedBox(height: 20),
                  const Text(
                    "Categories",
                    style: TextStyle(
                      color: Color(0xFF007E6C),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildCategoriesGrid(),
                ],
              ),
            ),
    );
  }

  Widget _buildGreetingSection() {
    return Column(
      children: [
        Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'imgs/logo.png',
              height: 100,
            ),
            const SizedBox(height: 10),
            const Text(
              "SAVR",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF007E6C),
              ),
            ),
          ],
        )),
        const SizedBox(height: 20),
        // Greeting Message
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xFFDFF5F2),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Hello food savior",
                      style: TextStyle(
                        color: Color(0xFF007E6C),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "You are in the best place for saving and savoring food!",
                      style: TextStyle(
                        color: Color(0xFF007E6C),
                        fontSize: 14,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Image.asset(
                  'imgs/planet-earth.png',
                  height: 40,
                  width: 40,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentOrderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Your current order",
          style: TextStyle(
            color: Color(0xFF007E6C),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xFFDFF5F2),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            children: [
              currentOrder!['imageUrl'] != null
                  ? Image.network(
                      currentOrder!['imageUrl'],
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.image_not_supported, size: 50);
                      },
                    )
                  : const Icon(Icons.image_not_supported, size: 50),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentOrder!['name'] ?? "Unknown",
                      style: const TextStyle(
                        color: Color(0xFF007E6C),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Available time: ${currentOrder!['time'] ?? 'N/A'}",
                      style: const TextStyle(
                        color: Color(0xFF007E6C),
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      currentOrder!['status'] == 'ready'
                          ? "Ready"
                          : "In process",
                      style: TextStyle(
                        color: currentOrder!['status'] == 'ready'
                            ? Colors.green
                            : Colors.orange,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return GestureDetector(
          onTap: () {
            // Handle category click
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFDFF5F2),
              borderRadius: BorderRadius.circular(12.0),
              image: category['img'] != null && category['img'] != ''
                  ? DecorationImage(
                      image: NetworkImage(category['img']),
                      fit: BoxFit.cover,
                      onError: (exception, stackTrace) {
                        print("Failed to load image: ${category['img']}");
                      },
                    )
                  : const DecorationImage(
                      image:
                          AssetImage('assets/images/default_placeholder.jpg'),
                      fit: BoxFit.cover,
                    ),
            ),
            child: Center(
              child: Text(
                category['name'] ?? "Unknown",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
