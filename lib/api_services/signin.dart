import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, dynamic>> login(String email, String password) async {
  final url = Uri.parse('http://192.168.1.8/savr/mobile/login.php');
  try {
    final response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      // Parse the JSON response
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData; // Return the entire response
    } else {
      return {'success': false, 'message': 'Failed to connect to the server'};
    }
  } catch (e) {
    return {'success': false, 'message': e.toString()};
  }
}

Future<void> saveUserId(int userId) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('user_id', userId);
}
