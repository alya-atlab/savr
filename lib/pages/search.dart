import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  final int userId;

  const Search({Key? key, required this.userId}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
