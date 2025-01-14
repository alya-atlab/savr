import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> signup(String name, String email, String password) async {
  final String baseUrl = 'http://192.168.1.8/savr/mobile/signup.php';
  final Uri url = Uri.parse(baseUrl);

  try {
    final response = await http.post(
      url,
      body: {
        'name': name,
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData['success'] == true) {
        
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt('user_id', responseData['user_id']); // Save user ID
        print('Signup successful. User ID: ${responseData['user_id']}');
        return true;
      } else {
        print('Signup failed: ${responseData['message']}');
        return false;
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print('Error: $e');
    return false;
  }
}

Future<void> saveUserId(int userId) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('user_id', userId);
}
