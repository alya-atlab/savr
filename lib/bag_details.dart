import 'package:flutter/material.dart';
import 'order_page.dart';

class BagDetails extends StatelessWidget {
  final int bagId;
  final String bagName;
  final String bagImage;
  final String restaurantName;
  final String restaurantLogo;
  final double? distance;
  final double? oldPrice;
  final double? discountedPrice;
  final double rating;
  final int userId;

  const BagDetails({
    Key? key,
    required this.bagId,
    required this.bagName,
    required this.bagImage,
    required this.restaurantName,
    required this.restaurantLogo,
    required this.distance,
    required this.oldPrice,
    required this.discountedPrice,
    required this.rating,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(bagImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 16,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(restaurantLogo),
                        radius: 24,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          restaurantName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (oldPrice != null)
                        Text(
                          "\$${oldPrice!.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const SizedBox(width: 8),
                      Text(
                        "\$${discountedPrice!.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        "$rating",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Spacer(),
                      if (distance != null)
                        Text(
                          "${distance!.toStringAsFixed(1)} km away",
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "What's Inside?",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Your Savr Surprise Bag is filled with a mix of fresh items. Each bag is unique and designed to reduce food waste while offering delicious surprises!",
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 30,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderPage(
                              bagId: bagId,
                              bagName: bagName,
                              bagImage: bagImage,
                              restaurantName: restaurantName,
                              userId: userId, // Pass userId to OrderPage
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "Surprised bag \$${discountedPrice!.toStringAsFixed(2)}",
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
