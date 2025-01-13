import 'package:savr_app/start.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

Future<void> logout(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear(); 

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => Start()),
  );
}
