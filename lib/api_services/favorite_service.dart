import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoriteService {
  static Future<List<Map<String, dynamic>>> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? favoritesString = prefs.getString('favorites');
    if (favoritesString != null) {
      return List<Map<String, dynamic>>.from(json.decode(favoritesString));
    }
    return [];
  }

  static Future<void> saveFavorites(
      List<Map<String, dynamic>> favorites) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('favorites', json.encode(favorites));
  }

  static Future<void> toggleFavorite(Map<String, dynamic> bag) async {
    List<Map<String, dynamic>> favorites = await loadFavorites();
    final bagId = bag['bag_id'].toString();

    if (favorites.any((favorite) => favorite['bag_id'].toString() == bagId)) {
      favorites
          .removeWhere((favorite) => favorite['bag_id'].toString() == bagId);
    } else {
      favorites.add(bag);
    }

    await saveFavorites(favorites);
  }

  static Future<bool> isFavorite(String bagId) async {
    List<Map<String, dynamic>> favorites = await loadFavorites();
    return favorites.any((favorite) => favorite['bag_id'].toString() == bagId);
  }
}
