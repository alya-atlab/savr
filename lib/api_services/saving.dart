import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getUserSavings(int userId) async {
  final String url = 'http://192.168.1.8/savr/mobile/total_savings.php';
  try {
    final response = await http.post(
      Uri.parse(url),
      body: {
        'user_id': userId.toString(),
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['status'] == 'success') {
        return {
          'total_money_saved': data['total_money_saved'],
          'total_items_saved': data['total_items_saved'],
        };
      } else {
        throw Exception(data['message'] ?? 'Unknown error occurred');
      }
    } else {
      throw Exception(
          'Failed to connect to server. Status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}
