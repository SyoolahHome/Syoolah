import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';

class ProfileAvatarNeon extends StatelessWidget {
  const ProfileAvatarNeon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 65,
      height: 65,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.teal,
            blurRadius: 12.5,
            spreadRadius: 7,
          ),
        ],
      ),
    );
  }
}
