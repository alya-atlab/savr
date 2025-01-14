import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoryService {
  static const String baseUrl =
      'http://192.168.1.8/savr/mobile/get_categories.php';

  static Future<List<Map<String, dynamic>>> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("Categories Response: $data"); // Debug print

        if (data['success']) {
         
          if (data['categories'] is List) {
            return List<Map<String, dynamic>>.from(data['categories']);
          } else {
            throw Exception("Invalid data format in categories.");
          }
        } else {
          throw Exception(data['message'] ?? "Failed to fetch categories.");
        }
      } else {
        throw Exception("HTTP Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching categories: $e");
      return [];
    }
  }
}
