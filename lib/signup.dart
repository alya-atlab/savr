import 'package:flutter/material.dart';
import 'mytextfield.dart';
import 'api_services/signup.dart';
import 'mainpage.dart';

class signUp extends StatefulWidget {
  const signUp({super.key});

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
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
              'Join the food rescuing crew!',
              style: TextStyle(
                color: Color(0xFF007E6C),
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SignUpForm(),
          ],
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  // Define controllers for each text field
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyTextField(
            controller: _nameController,
            hint: 'Name',
            icon: Icons.person,
            f: (value) {
              print("Name: $value");
            },
          ),
          const SizedBox(height: 20),
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
            hint: 'Password',
            icon: Icons.lock,
            f: (value) {
              print("Password: $value");
            },
          ),
          const SizedBox(height: 20),
          MyTextField(
            controller: _confirmPasswordController,
            hint: 'Confirm Password',
            icon: Icons.lock_outline,
            f: (value) {
              print("Confirm Password: $value");
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
              String name = _nameController.text;
              String email = _emailController.text;
              String password = _passwordController.text;
              String confirmPassword = _confirmPasswordController.text;

              if (password != confirmPassword) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Passwords do not match!")),
                );
                return;
              }
              if (name.isEmpty ||
                  email.isEmpty ||
                  password.isEmpty ||
                  confirmPassword.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("All fields are required!")),
                );
                return;
              }

              bool isSuccess = await signup(name, email, password);

              if (isSuccess) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Signup failed. Please try again.")),
                );
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'CREATE ACCOUNT',
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
          )
        ],
      ),
    );
  }
}
