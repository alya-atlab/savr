import 'dart:convert';
import 'package:http/http.dart' as http;


class OrderService {
  static const String baseUrl = 'http://192.168.1.8/savr/mobile';

  static Future<int> fetchAvailableQuantity(int bagId) async {
    final response = await http
        .get(Uri.parse('$baseUrl/get_available_quantity.php?bag_id=$bagId'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success'] == true) {
        return data['available_quantity'] as int;
      } else {
        throw Exception(data['message']);
      }
    } else {
      throw Exception('Failed to fetch available quantity');
    }
  }
}
