import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  static const String baseUrl = 'http://192.168.1.8/savr/mobile/';

  static Future<Map<String, dynamic>> fetchUserData(int userId) async {
    final url = Uri.parse('${baseUrl}total_savings.php');

    try {
      final response = await http.post(
        url,
        body: {'user_id': userId.toString()},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        print('API Response: $responseData'); // Debugging

        if (responseData['status'] == 'success') {
          // Ensure the response contains the required fields
          final double totalSavings =
              double.tryParse(responseData['total_money_saved'].toString()) ??
                  0.0;
          final int totalItemsSaved =
              int.tryParse(responseData['total_items_saved'].toString()) ?? 0;

          return {
            'success': true,
            'name': responseData['name'] ?? 'Unknown',
            'totalSavings': totalSavings,
            'totalItemsSaved': totalItemsSaved,
          };
        } else {
          return {'success': false, 'message': responseData['message']};
        }
      } else {
        return {
          'success': false,
          'message': 'HTTP error: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }
}
