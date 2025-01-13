import 'dart:convert';
import 'package:http/http.dart' as http;

class BagService {
  static const String baseUrl = 'http://192.168.1.8/savr/mobile/get_bags.php';

  static Future<List<Map<String, dynamic>>> fetchBags(
      double latitude, double longitude) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl?latitude=$latitude&longitude=$longitude'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          return List<Map<String, dynamic>>.from(data['bags']);
        } else {
          print("API Error: ${data['message']}");
        }
      } else {
        print("HTTP Error: ${response.statusCode}");
        print("Response: ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    }

    return [];
  }

  static Future<int> fetchAvailableQuantity({required int bagId}) async {
    print("Fetching available quantity for bagId: $bagId"); // Debugging line
    final response = await http.get(
      Uri.parse(
          'http://192.168.1.8/savr/mobile/get_available_quantity.php?bag_id=$bagId'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        return data['available_quantity'];
      } else {
        throw Exception(
            "Error fetching available quantity: ${data['message']}");
      }
    } else {
      throw Exception("Failed to fetch available quantity");
    }
  }
}
