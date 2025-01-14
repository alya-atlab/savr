import 'package:flutter/material.dart';
import '../api_services/favorite_service.dart';

class Favourite extends StatefulWidget {
  final int userId;

  const Favourite({Key? key, required this.userId}) : super(key: key);

  @override
  _Favourite createState() => _Favourite();
}

class _Favourite extends State<Favourite> {
  List<Map<String, dynamic>> _favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    List<Map<String, dynamic>> favorites =
        await FavoriteService.loadFavorites();
    setState(() {
      _favorites = favorites;
    });
  }

  Future<void> _removeFromFavorites(String bagId) async {
    List<Map<String, dynamic>> updatedFavorites = _favorites
        .where((favorite) => favorite['bag_id'].toString() != bagId)
        .toList();

    await FavoriteService.saveFavorites(updatedFavorites);
    setState(() {
      _favorites = updatedFavorites;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Removed from favorites!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Favorites'),
        centerTitle: true,
      ),
      body: _favorites.isEmpty
          ? const Center(
              child: Text(
                'No favorites added yet.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: _favorites.length,
              itemBuilder: (context, index) {
                final bag = _favorites[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 4,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: bag['bag_image'] != null
                          ? NetworkImage(bag['bag_image'])
                          : const AssetImage(
                                  'assets/images/default_placeholder.jpg')
                              as ImageProvider,
                    ),
                    title: Text(
                      bag['bag_name'] ?? "Unknown Name",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Last order: ${bag['last_order_date'] ?? 'N/A'}"),
                        Text(
                            "Distance: ${bag['distance']?.toStringAsFixed(1) ?? 'Unknown'} km"),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () {
                        _removeFromFavorites(bag['bag_id'].toString());
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
