import 'package:flutter/material.dart';

class ProfileAvatarNeonBorder extends StatelessWidget {
  const ProfileAvatarNeonBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85,
      height: 85,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
