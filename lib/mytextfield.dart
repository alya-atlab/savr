import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final Function(String) f;
  final String hint;
  final IconData? icon;
  final TextEditingController controller;

  const MyTextField({
    super.key,
    required this.f,
    required this.hint,
    required this.controller,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF00897B), width: 2),
        borderRadius: BorderRadius.circular(30),
        color: const Color(0xFFEFFFFA),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color: const Color(0xFF00897B),
            ),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: TextField(
              controller: controller,  // Using TextEditingController to manage input
              style: const TextStyle(fontSize: 16, color: Color(0xFF00897B)),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(color: Color(0xFF007E6C)),
                border: InputBorder.none,
              ),
              onChanged: (text) {
                f(text);
              },
            ),
          ),
        ],
      ),
    );
  }
}
