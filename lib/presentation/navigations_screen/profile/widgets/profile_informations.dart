import 'package:flutter/material.dart';

class ProfileInformations extends StatelessWidget {
  const ProfileInformations({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Text(
          "20 Following",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 2),
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          "10 Followers",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 2),
        )
      ],
    );
  }
}
