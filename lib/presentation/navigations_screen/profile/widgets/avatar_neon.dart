import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';

class ProfileAvatarNeon extends StatelessWidget {
  const ProfileAvatarNeon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 62.5,
      height: 62.5,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.of(context).primaryColor,
            blurRadius: 12.5,
            spreadRadius: 7,
          ),
        ],
      ),
    );
  }
}
