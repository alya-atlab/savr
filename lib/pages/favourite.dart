import 'package:flutter/material.dart';

class Favourite extends StatefulWidget {
  final int userId;

  const Favourite({Key? key, required this.userId}) : super(key: key);

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
