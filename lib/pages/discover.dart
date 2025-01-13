import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../api_services/bag_service.dart';
import '../bagcard.dart';
import '../bag_details.dart';

class Discover extends StatefulWidget {
  final int userId;

  const Discover({Key? key, required this.userId}) : super(key: key);

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  bool isLoading = true;
  double? latitude;
  double? longitude;
  List<Map<String, dynamic>> bags = [];

  @override
  void initState() {
    super.initState();
    fetchLocationAndBags();
  }

  Future<void> fetchLocationAndBags() async {
    try {
      Position position = await _determinePosition();
      latitude = position.latitude;
      longitude = position.longitude;

      // Fetch all bags
      bags = await BagService.fetchBags(latitude!, longitude!);

      // Fetch available quantity for each bag and filter out unavailable ones
      List<Map<String, dynamic>> filteredBags = [];
      for (var bag in bags) {
        final int availableQuantity = await BagService.fetchAvailableQuantity(
          bagId: int.parse(bag['bag_id'].toString()),
        );
        if (availableQuantity > 0) {
          bag['available_quantity'] = availableQuantity;
          filteredBags.add(bag);
        }
      }

      setState(() {
        bags = filteredBags; // Only bags with available quantity > 0
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("Location services are disabled.");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Location permissions are denied.");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("Location permissions are permanently denied.");
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Discover')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : bags.isEmpty
              ? const Center(
                  child: Text(
                    "No bags available",
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.75, // Adjust this as needed
                  ),
                  itemCount: bags.length,
                  itemBuilder: (context, index) {
                    final bag = bags[index];

                    // Parse the bag rating as a double
                    final double rating = bag['bag_rating'] != null
                        ? double.tryParse(bag['bag_rating'].toString()) ?? 0.0
                        : 0.0;

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BagDetails(
                              bagId: int.parse(bag['bag_id'].toString()),
                              bagName: bag['bag_name'] ?? "Unknown Bag",
                              bagImage: bag['bag_image'] ?? "",
                              restaurantName: bag['restaurant_name'] ??
                                  "Unknown Restaurant",
                              restaurantLogo: bag['restaurant_logo'] ?? "",
                              distance: bag['distance'],
                              oldPrice: bag['total_price'],
                              discountedPrice: bag['discounted_price'],
                              rating: rating,
                              userId: widget.userId,
                            ),
                          ),
                        );
                      },
                      child: BagCard(
                        bagName: bag['bag_name'],
                        bagImage: bag['bag_image'],
                        restaurantName: bag['restaurant_name'],
                        restaurantLogo: bag['restaurant_logo'],
                        distance: bag['distance'],
                        oldPrice: bag['total_price'],
                        discountedPrice: bag['discounted_price'],
                      ),
                    );
                  },
                ),
    );
  }
}
