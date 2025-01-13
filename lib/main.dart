import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mainpage.dart';
import 'start.dart';

Future<bool> isUserLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.containsKey('user_id'); 
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool loggedIn = await isUserLoggedIn();
  runApp(MyApp(loggedIn: loggedIn));
}

class MyApp extends StatelessWidget {
  final bool loggedIn;

  MyApp({required this.loggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: loggedIn ? MainPage() : Start(), 
    );
  }
}
