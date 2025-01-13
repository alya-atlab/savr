import 'package:flutter/material.dart';
import 'mytextfield.dart';
import 'mainpage.dart';
import 'api_services/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0FFFD),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF0FFFD),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Color(0xFF007E6C),
        ),
      ),
      body: Align(
        alignment: Alignment(0.0, -0.75),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xFF007E6C),
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            LoginForm(),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyTextField(
            controller: _emailController,
            hint: 'Email',
            icon: Icons.email,
            f: (value) {
              print("Email: $value");
            },
          ),
          const SizedBox(height: 20),
          MyTextField(
            controller: _passwordController,
            hint: 'password',
            icon: Icons.lock,
            f: (value) {
              print("password: $value");
            },
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00897B),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            ),
            onPressed: () async {
              final email = _emailController.text.trim();
              final password = _passwordController.text.trim();

              // Call the login function and get the response
              final responseData = await login(email, password);

              if (responseData['success']) {
                // Extract the user ID from the API response
                final userId = responseData['user_id'];

                // Save the user ID locally using SharedPreferences
                final prefs = await SharedPreferences.getInstance();
                await prefs.setInt('user_id', userId);

                // Navigate to the main page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainPage(),
                  ),
                );
              } else {
                // Show error message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Invalid email or password')),
                );
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'START SAVING FOOD',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          SizedBox(width: 40),
          TextButton(
            onPressed: () {
              print("Forgot Password? clicked");
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
            ),
            child: const Text(
              'Forgot Password?',
              style: TextStyle(
                color: Color(0xFF00897B),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
