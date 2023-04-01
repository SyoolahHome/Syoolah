import 'package:flutter/material.dart';

class ProfileName extends StatelessWidget {
  const ProfileName({
    super.key,
    required this.name,
    required this.username,
  });

  final String name;
  final String username;
  @override
  Widget build(BuildContext context) {
    final String toShow;
    if (name.isEmpty) {
      toShow = username;
    } else {
      toShow = name;
    }
    return Text(
      toShow,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
